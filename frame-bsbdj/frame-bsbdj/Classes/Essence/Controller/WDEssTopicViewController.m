//
//  WDEssTopicViewController.m
//  frame-bsbdj
//
//  Created by WangDongya on 2017/12/14.
//  Copyright © 2017年 example. All rights reserved.
//

#import "WDEssTopicViewController.h"
#import <AFNetworking/AFNetworking.h>
#import "WDRefreshHeader.h"
#import "WDRefreshFooter.h"
#import "WDTopic.h"
#import "WDEssTopicCell.h"
#import "WDNewViewController.h"
#import "WDCommentViewController.h"
#import <MJExtension/MJExtension.h>
#import <SDWebImage/UIImageView+WebCache.h>


static NSString * const TOPIC_CELL_ID = @"WDEssTopicCell";

@interface WDEssTopicViewController ()
@property (nonatomic, strong) NSMutableArray *topics;
@property (nonatomic, strong) NSString *maxtime;
/** 声明这个方法的目的 : 为了能够使用点语法的智能提示 */
- (NSString *)aParam;
@end

@implementation WDEssTopicViewController

- (NSMutableArray *)topics
{
    if (!_topics) {
        _topics = [NSMutableArray array];
    }
    return _topics;
}
- (NSString *)aParam
{
    NSLog(@"%@", NSStringFromClass(self.parentViewController.class));
    
    if (self.parentViewController.class == [WDNewViewController class]) {
        NSLog(@"WDNewViewController");
        return @"newlist";
    }
    return @"list";
}
- (WDTopicType)type
{
    return 0;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // 设置tableView的内边距
    [self.tableView setContentInset:UIEdgeInsetsMake(64+35, 0, 49, 0)];
    [self.tableView setScrollIndicatorInsets:self.tableView.contentInset];
    [self.tableView setBackgroundColor:WDColor(222, 222, 222)];
    // 清除系统默认的分割线
    [self.tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([WDEssTopicCell class]) bundle:nil] forCellReuseIdentifier:TOPIC_CELL_ID];
    
    if (@available(iOS 11.0, *)) {
        NSLog(@"当前11.0*");
        self.tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    } else {
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
    
    if (@available(iOS 10.0, *)) {
        
    }
    
    //UIToolbar
    
    
    // 加载数据
    [self loadAllDatas];
    // 设置下拉刷新
    [self setupRefresh];
    // 添加监听通知
    [self setupNote];
}

- (void)dealloc
{
    // 移除通知监听
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

#pragma mark - Notification
- (void)setupNote
{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(tabBarButtonDidRepeatClick) name:WDTabBarDidRepeatClickNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(titleButtonDidRepeatClick) name:WDTitleButtonDidRepeatClickNotification object:nil];
}

#pragma mark - Refresh
- (void)setupRefresh
{
    // 下拉，更新界面数据
    WDRefreshHeader *refreshHeader = [WDRefreshHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadAllDatas)];
    self.tableView.mj_header = refreshHeader;
    [self.tableView.mj_header beginRefreshing];
    
    // 上拉加载更多
    self.tableView.mj_footer = [WDRefreshFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreDatas)];
}

#pragma mark - 监听广播
//
- (void)tabBarButtonDidRepeatClick
{
    // 如果当前控制器的view不在window上，就直接返回，否则这个方法调用5次
    if (self.view.window == nil) return;
    
    // 如果当前控制器的view跟window没有重叠，就直接返回
    if (![self.view intersectWithView:self.view.window]) return;
    
    // 进行下拉刷新
    [self.tableView.mj_header beginRefreshing];
}

- (void)titleButtonDidRepeatClick
{
    [self tabBarButtonDidRepeatClick];
}

#pragma mark - 加载网络数据
- (void)loadAllDatas
{
    // 参数
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"a"] = self.aParam;
    params[@"c"] = @"data";
    params[@"type"] = @(self.type);
    
    // 发送请求
    [[AFHTTPSessionManager manager] GET:@"http://api.budejie.com/api/api_open.php" parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, NSDictionary * _Nullable responseObject) {
        self.maxtime = responseObject[@"info"][@"maxtime"];
        [self.topics addObjectsFromArray:[WDTopic mj_objectArrayWithKeyValuesArray:responseObject[@"list"]]];
        [self.tableView reloadData];
        // 隐藏刷新
        [self.tableView.mj_header endRefreshing];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [self.tableView.mj_header endRefreshing];
    }];
}
- (void)loadMoreDatas
{
    // 参数
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"a"] = self.aParam;
    params[@"c"] = @"data";
    params[@"type"] = @(self.type);
    params[@"maxtime"] = self.maxtime;
    
    // 发送请求
    [[AFHTTPSessionManager manager] GET:@"http://api.budejie.com/api/api_open.php" parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, NSDictionary * _Nullable responseObject) {
        self.maxtime = responseObject[@"info"][@"maxtime"];
        
        [self.topics addObjectsFromArray:[WDTopic mj_objectArrayWithKeyValuesArray:responseObject[@"list"]]];
        [self.tableView reloadData];
        
        // 隐藏刷新
        [self.tableView.mj_footer endRefreshing];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [self.tableView.mj_footer endRefreshing];
    }];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.topics.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    WDEssTopicCell *cell = nil;
    cell = [tableView dequeueReusableCellWithIdentifier:TOPIC_CELL_ID forIndexPath:indexPath];
    
    WDTopic *topic = self.topics[indexPath.row];
    cell.topic = topic;
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    WDTopic *topic = (WDTopic *)self.topics[indexPath.row];
    return topic.cellHeight;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    WDCommentViewController *comment = [[WDCommentViewController alloc] init];
    comment.topic = self.topics[indexPath.row];
    [self.navigationController pushViewController:comment animated:YES];
}

@end

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
#import <MJExtension/MJExtension.h>
#import <SDWebImage/UIImageView+WebCache.h>


static NSString * const TOPIC_CELL_ID = @"WDEssTopicCell";

@interface WDEssTopicViewController ()
@property (nonatomic, strong) NSMutableArray *topics;
@property (nonatomic, strong) NSString *maxtime;

@end

@implementation WDEssTopicViewController

- (NSMutableArray *)topics
{
    if (!_topics) {
        _topics = [NSMutableArray array];
    }
    return _topics;
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



#pragma mark - 加载网络数据
- (void)loadAllDatas
{
    // 参数
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"a"] = @"list";
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
    params[@"a"] = @"list";
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

@end

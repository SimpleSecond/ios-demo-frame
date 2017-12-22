//
//  WDRecommenTagViewController.m
//  frame-bsbdj
//
//  Created by WangDongya on 2017/12/21.
//  Copyright © 2017年 example. All rights reserved.
//

#import "WDRecommenTagViewController.h"
#import "WDHTTPSessionManager.h"
#import "WDRecommendTag.h"
#import "WDRecommendTagCell.h"
#import <MJExtension/MJExtension.h>
#import <SVProgressHUD/SVProgressHUD.h>



@interface WDRecommenTagViewController ()
// 标签数据
@property (nonatomic, strong) NSArray<WDRecommendTag*> *recommendTags;
// 请求管理者
@property (nonatomic, weak) WDHTTPSessionManager *manager;

@end

@implementation WDRecommenTagViewController
// cell的重用标识
static NSString * const WDRecommendTagCellID = @"recommendTag";

// manager属性懒加载
-(WDHTTPSessionManager *)manager
{
    if (!_manager) {
        _manager = [WDHTTPSessionManager manager];
    }
    return _manager;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // 设置导航
    [self setupNav];
    // 设置tableview
    [self setupTable];
    // 加载数据
    [self loadNewRecommendTags];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    // 隐藏HUD
    [SVProgressHUD dismiss];
    
    // 取消请求
    [self.manager invalidateSessionCancelingTasks:YES];
}

// 设置导航
- (void)setupNav
{
    self.navigationItem.title = @"推荐标签";
}
// 设置tableView
- (void)setupTable
{
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([WDRecommendTagCell class]) bundle:nil] forCellReuseIdentifier:WDRecommendTagCellID];
    self.tableView.rowHeight = 70;
    self.tableView.backgroundColor = WDCommonColor;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
}
// 加载标签数据
- (void)loadNewRecommendTags
{
    [SVProgressHUD show];
    
    __weak typeof (self) weakSelf = self;
    
    // 请求参数
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"a"] = @"tag_recommend";
    params[@"action"] = @"sub";
    params[@"c"] = @"topic";
    // 发送请求
    [self.manager GET:WDCommonURL parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        // 1. 字典数组  ->  模型数组
        weakSelf.recommendTags = [WDRecommendTag mj_objectArrayWithKeyValuesArray:responseObject];
        // 2. 刷新
        [weakSelf.tableView reloadData];
        // 3. 去除HUD
        [SVProgressHUD dismiss];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (error.code == NSURLErrorCancelled) return ;
        
        [SVProgressHUD dismiss];
        [SVProgressHUD showErrorWithStatus:@"网络繁忙，请稍后再试。"];
    }];
}


#pragma mark - Table view data source
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.recommendTags.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    WDRecommendTagCell *cell = [tableView dequeueReusableCellWithIdentifier:WDRecommendTagCellID];
    // 设置标签数据
    cell.recommendTag = self.recommendTags[indexPath.row];
    return cell;
}

@end

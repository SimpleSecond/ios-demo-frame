//
//  WDCommentViewController.m
//  frame-bsbdj
//
//  Created by WangDongya on 2017/12/21.
//  Copyright © 2017年 example. All rights reserved.
//

#import "WDCommentViewController.h"
#import "WDHTTPSessionManager.h"
#import "WDRefreshHeader.h"
#import "WDRefreshFooter.h"
#import "WDTopic.h"
#import "WDComment.h"
#import "WDCommentSectionHeader.h"
#import "WDCommentCell.h"
#import "WDEssTopicCell.h"
#import <MJExtension/MJExtension.h>


@interface WDCommentViewController () <UITableViewDelegate, UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tableView;

// 任务管理者
@property (nonatomic, strong) WDHTTPSessionManager *manager;
// 最热评论数据
@property (nonatomic, strong) NSArray<WDComment *> *hotestComments;
// 最新评论数据
@property (nonatomic, strong) NSMutableArray<WDComment *> *latestComments;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *bottomMargin;


// 最热评论
@property (nonatomic, strong) WDComment *savedTopCmt;

@end

@implementation WDCommentViewController

static NSString * const WDCommentCellId = @"comment";
static NSString * const WDSectionHeaderlId = @"header";

#pragma mark - 懒加载
-(WDHTTPSessionManager *)manager
{
    if (!_manager) {
        _manager = [WDHTTPSessionManager manager];
    }
    return _manager;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupBase];
    
    [self setupTable];
    
    [self setupRefresh];
    
    [self setupHeader];
}
- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    
    self.topic.top_cmt = self.savedTopCmt;
    self.topic.cellHeight = 0;
}

- (void)setupBase
{
    self.navigationItem.title = @"评论";
    // 监听键盘通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillChangeFrame:) name:UIKeyboardDidChangeFrameNotification object:nil];
}

- (void)setupTable
{
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([WDCommentCell class]) bundle:nil] forCellReuseIdentifier:WDCommentCellId];
    [self.tableView registerClass:[WDCommentSectionHeader class] forHeaderFooterViewReuseIdentifier:WDSectionHeaderlId];
    
    self.tableView.backgroundColor = WDCommonColor;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    // 每一组头部空间的高度
    self.tableView.sectionHeaderHeight = [UIFont systemFontOfSize:15].lineHeight + 2;
    
    // 设置cell的高度
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    self.tableView.estimatedRowHeight = 44;
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
}


- (void)setupRefresh
{
    self.tableView.mj_header = [WDRefreshHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewComments)];
    [self.tableView.mj_header beginRefreshing];
    
    self.tableView.mj_footer = [WDRefreshFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreComments)];
}


- (void)setupHeader
{
    // 处理模型数据
    self.savedTopCmt = self.topic.top_cmt;
    self.topic.top_cmt = nil;
    self.topic.cellHeight = 0;
    
    // 创建header
    UIView *header = [[UIView alloc] init];
    
    // 添加cell到header
    WDEssTopicCell *cell = [WDEssTopicCell viewFromXib];
    cell.topic = self.topic;
    cell.frame = CGRectMake(0, 0, SCREEN_WIDTH, self.topic.cellHeight);
    [header addSubview:cell];
    header.backgroundColor = [UIColor whiteColor];
    // 设置header的高度
    header.wd_height = cell.wd_height + WDMargin * 2;
    
    // 设置header
    self.tableView.tableHeaderView = header;
}

#pragma mark - 监听键盘的显示
- (void)keyboardWillChangeFrame:(NSNotification *)note
{
    // 修改约束
    CGFloat keyboardY = [note.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue].origin.y;
    CGFloat screenH = [UIScreen mainScreen].bounds.size.height;
    self.bottomMargin.constant = screenH - keyboardY;
    
    // 执行动画
    CGFloat duration = [note.userInfo[UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    [UIView animateWithDuration:duration animations:^{
        [self.view layoutIfNeeded];
    }];
}


#pragma mark - 数据加载
- (void)loadNewComments
{
    // 取消所有请求
    [self.manager.tasks makeObjectsPerformSelector:@selector(cancel)];
    
    // 参数
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"a"] = @"dataList";
    params[@"c"] = @"comment";
    params[@"data_id"] = self.topic.ID;
    params[@"hot"] = @1;
    
    __weak typeof(self) weakSelf = self;
    
    // 发送请求
    [self.manager GET:WDCommonURL parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        // 没有任何评论数据
        if (![responseObject isKindOfClass:[NSDictionary class]]) {
            // 结束刷新
            [weakSelf.tableView.mj_header endRefreshing];
            return ;
        }
        
        // 字典数组  ->  模型数组
        weakSelf.latestComments = [WDComment mj_objectArrayWithKeyValuesArray:responseObject[@"data"]];
        weakSelf.hotestComments = [WDComment mj_objectArrayWithKeyValuesArray:responseObject[@"hot"]];
        
        // 刷新表格
        [weakSelf.tableView reloadData];
        
        // 结束刷新
        [weakSelf.tableView.mj_header endRefreshing];
        
        int total = [responseObject[@"total"] intValue];
        if (weakSelf.latestComments.count == total) {  // 全部加载完成
            // 隐藏
            weakSelf.tableView.mj_footer.hidden = YES;
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        // 结束刷新
        [weakSelf.tableView.mj_header endRefreshing];
    }];
}

- (void)loadMoreComments
{
    // 取消所有请求
    [self.manager.tasks makeObjectsPerformSelector:@selector(cancel)];
    
    // 参数
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"a"] = @"dataList";
    params[@"c"] = @"comment";
    params[@"data_id"] = self.topic.ID;
    params[@"lastcid"] = self.latestComments.lastObject.ID;
    
    __weak typeof(self) weakSelf = self;
    
    // 发送请求
    [self.manager GET:WDCommonURL parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        // 没有任何评论数据
        if (![responseObject isKindOfClass:[NSDictionary class]]) {
            // 结束刷新
            [weakSelf.tableView.mj_footer endRefreshing];
            return ;
        }
        
        // 字典数组  ->  模型数组
        NSArray *moreComments = [WDComment mj_objectArrayWithKeyValuesArray:responseObject[@"data"]];
        [weakSelf.latestComments addObjectsFromArray:moreComments];
        
        // 刷新表格
        [weakSelf.tableView reloadData];
        
        int total = [responseObject[@"total"] intValue];
        if (weakSelf.latestComments.count == total) {  // 全部加载完成
            // 隐藏
            [weakSelf.tableView.mj_footer endRefreshing];
            weakSelf.tableView.mj_footer.hidden = YES;
        } else {  // 还没有加载完
            // 结束刷新
            [weakSelf.tableView.mj_footer endRefreshing];
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        // 结束刷新
        [weakSelf.tableView.mj_footer endRefreshing];
    }];
}



#pragma mark - UITableViewDataSource
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // 有最热评论 + 最新评论数据
    if (self.hotestComments.count) return 2;
    
    // 没有最热评论，有最新评论
    if (self.latestComments.count) return 1;
    
    // 没有最热评论，没有最新评论
    return 0;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // 第0组  &&  有最热评论数据
    if (section == 0 && self.hotestComments.count) {
        return self.hotestComments.count;
    }
    
    // 其他情况
    return self.latestComments.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    WDCommentCell *cell = [tableView dequeueReusableCellWithIdentifier:WDCommentCellId];
    
    if (indexPath.section == 0 && self.hotestComments.count) {
        cell.comment = self.hotestComments[indexPath.row];
    } else {
        cell.comment = self.latestComments[indexPath.row];
    }
    
    return cell;
}

#pragma mark - UITableViewDelegate
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    WDCommentSectionHeader *header = (WDCommentSectionHeader *)[tableView dequeueReusableCellWithIdentifier:WDSectionHeaderlId];
    
    // 0  &&  有最热评论数据
    if (section == 0 && self.hotestComments.count) {
        header.textLabel.text = @"最热评论";
    } else {
        header.textLabel.text = @"最新评论";
    }
    
    return header;
}

// 当用户开始拖拽scrollView就会调用一次
-(void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    [self.view endEditing:YES];
}


@end

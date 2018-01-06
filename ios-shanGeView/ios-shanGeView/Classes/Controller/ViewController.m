//
//  ViewController.m
//  ios-shanGeView
//
//  Created by WangDongya on 2017/12/26.
//  Copyright © 2017年 example. All rights reserved.
//

#import "ViewController.h"
#import "WDGridLayoutView.h"
#import "WDTableViewCell.h"
#import <Masonry/Masonry.h>
#import <SVPullToRefresh/SVPullToRefresh.h>

@interface ViewController () <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSString *jsonStr;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 设置TableView
    [self setupTable];
    // 下拉刷新
    [self setupPullToefresh];
}

- (void)setupTable
{
    self.tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:self.tableView];
    
    
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(self.view);
    }];
}

- (void)setupPullToefresh
{
    __weak typeof(self) weakSelf = self;
    [self.tableView addPullToRefreshWithActionHandler:^{
        [weakSelf insertWithTop];
    }];
}

- (void)insertWithTop
{
    [self.tableView.pullToRefreshView setTitle:@"下拉更改数据" forState:SVPullToRefreshStateTriggered];
    [self.tableView.pullToRefreshView setTitle:@"更换数据中..." forState:SVPullToRefreshStateLoading];
    
    dispatch_after(difftime(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self.tableView.pullToRefreshView stopAnimating];
        NSString *path = [[NSBundle mainBundle] pathForResource:[NSString stringWithFormat:@"%d", arc4random()%4] ofType:@"txt"];
        
        self.jsonStr = [NSString stringWithContentsOfFile:path encoding:NSUTF8StringEncoding error:nil];
        
        [self.tableView reloadData];
    });
}


#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    WDTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    
    if (!cell) {
        cell = [[WDTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    
    cell.jsonStr = self.jsonStr;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    return cell;
}


#pragma mark - UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return [WDGridLayoutView GridViewHeightWithJsonStr:self.jsonStr];
}


@end

//
//  WDMeViewController.m
//  frame-bsbdj
//
//  Created by WangDongya on 2017/12/5.
//  Copyright © 2017年 example. All rights reserved.
//

#import "WDMeViewController.h"
#import "WDMeCell.h"
#import "WDMeFooterView.h"
#import "WDSettingViewController.h"

#define ID @"MeCell"

@interface WDMeViewController ()

@end

@implementation WDMeViewController

- (instancetype)init
{
    return [super initWithStyle:UITableViewStyleGrouped];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view setBackgroundColor:WDColor(222, 222, 222)];
    
    [self setupNav];
    [self setupTable];
}

- (void)setupTable
{
    self.tableView.sectionHeaderHeight = 0;
    self.tableView.sectionFooterHeight = WDMargin;
    self.tableView.contentInset = UIEdgeInsetsMake(WDMargin - 35, 0, 0, 0);
    
    // 设置footerView
    self.tableView.tableFooterView = [[WDMeFooterView alloc] init];
    
}

- (void)setupNav
{
    // 标题
    self.navigationItem.title = @"我的";
    // 右边
    UIBarButtonItem *settingItem = [UIBarButtonItem itemWithImage:@"mine-setting-icon" highImage:@"mine-setting-icon-click" target:self action:@selector(settingClick)];
    UIBarButtonItem *moonItem = [UIBarButtonItem itemWithImage:@"mine-moon-icon" highImage:@"mine-moon-icon-click" target:self action:@selector(moonClick)];
    
    self.navigationItem.rightBarButtonItems = @[settingItem, moonItem];
}

- (void)settingClick
{
    WDSettingViewController *setting = [[WDSettingViewController alloc] init];
    [self.navigationController pushViewController:setting animated:YES];
}
- (void)moonClick
{
    WDLog(@"%s", __func__);
}


#pragma mark - 代理方法
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    WDMeCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    
    if (!cell) {
        cell = [[WDMeCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    
    if (indexPath.section == 0) {
        cell.imageView.image = [UIImage imageNamed:@"setup-head-default"];
        cell.textLabel.text = @"登录/注册";
    } else {
        // 如果没有图片，最好置为nil
        cell.imageView.image = nil;
        cell.textLabel.text = @"离线下载";
    }
    
    return cell;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

@end

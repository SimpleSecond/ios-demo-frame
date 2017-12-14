//
//  WDFollowViewController.m
//  frame-bsbdj
//
//  Created by WangDongya on 2017/12/5.
//  Copyright © 2017年 example. All rights reserved.
//

#import "WDFollowViewController.h"
#import "WDRecommentFollowController.h"
#import "WDLoginRegisterViewController.h"

@interface WDFollowViewController ()

@end

@implementation WDFollowViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view setBackgroundColor:WDColor(222, 222, 222)];
    
    // 标题
    self.navigationItem.title = @"我的关注";
    // 左边
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithImage:@"friendsRecommentIcon" highImage:@"friendsRecommentIcon-click" target:self action:@selector(recommentClick)];
    
}
// 推荐关注
- (void)recommentClick
{
    WDLog(@"%s", __func__);
    WDRecommentFollowController *testVC = [[WDRecommentFollowController alloc] init];
    testVC.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:testVC animated:YES];
}

- (IBAction)loginClick:(id)sender {
    WDLoginRegisterViewController *loginCtrl = [[WDLoginRegisterViewController alloc] init];
    
    [self presentViewController:loginCtrl animated:YES completion:nil];
}

@end

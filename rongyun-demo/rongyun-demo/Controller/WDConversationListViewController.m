//
//  WDConversationListViewController.m
//  rongyun-demo
//
//  Created by WangDongya on 2018/1/4.
//  Copyright © 2018年 example. All rights reserved.
//

#import "WDConversationListViewController.h"
#import "WDConversationViewController.h"

@interface WDConversationListViewController ()

@end

@implementation WDConversationListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIButton *logoutBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [logoutBtn setTitle:@" 退出 " forState:UIControlStateNormal];
    [logoutBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    //[logoutBtn setBackgroundColor:[UIColor greenColor]];
    [logoutBtn addTarget:self action:@selector(logoutEvent:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *logoutBar = [[UIBarButtonItem alloc] initWithCustomView:logoutBtn];
    [self.navigationItem setLeftBarButtonItem:logoutBar];
    
    UIButton *addBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [addBtn setTitle:@" 添加 " forState:UIControlStateNormal];
    [addBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [addBtn addTarget:self action:@selector(addEvent:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *addBar = [[UIBarButtonItem alloc] initWithCustomView:addBtn];
    [self.navigationItem setRightBarButtonItems:@[addBar]];
    
    self.conversationListTableView.tableFooterView = [UIView new];
    self.showConnectingStatusOnNavigatorBar = YES;
    self.isShowNetworkIndicatorView = YES;
    
    
    
}

- (void)logoutEvent:(UIButton *)sender
{
    [[RCIM sharedRCIM] logout];
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"com.rongcloud.token"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
    UIViewController *vc = [[NSClassFromString(@"WDWaitingViewController") alloc] init];
    [self.navigationController setViewControllers:@[vc]];
}

- (void)addEvent:(UIButton *)sender
{
    NSString *targetID = @"1001";
    if ([[[RCIMClient sharedRCIMClient] currentUserInfo].userId isEqualToString:targetID]) {
        targetID = @"1002";
    }
    
    WDConversationViewController *conversationVC = [[WDConversationViewController alloc] initWithConversationType:ConversationType_PRIVATE targetId:targetID];
    conversationVC.title = targetID;
    [self.navigationController pushViewController:conversationVC animated:YES];
    
}

- (void)onSelectedTableRow:(RCConversationModelType)conversationModelType conversationModel:(RCConversationModel *)model atIndexPath:(NSIndexPath *)indexPath
{
    WDConversationViewController *convationVC = [[WDConversationViewController alloc] initWithConversationType:model.conversationType targetId:model.targetId];
    convationVC.title = model.targetId;
    [self.navigationController pushViewController:convationVC animated:YES];
}

@end

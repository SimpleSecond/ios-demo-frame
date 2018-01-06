//
//  WDWaitingViewController.m
//  rongyun-demo
//
//  Created by WangDongya on 2018/1/4.
//  Copyright © 2018年 example. All rights reserved.
//

#import "WDWaitingViewController.h"
#import "WDLoginViewController.h"
#import "WDConversationListViewController.h"
#import <Masonry/Masonry.h>
#import <RongIMKit/RongIMKit.h>

@interface WDWaitingViewController () <RCIMConnectionStatusDelegate>

@property (nonatomic, strong) UIActivityIndicatorView *indicatorView;

@end

@implementation WDWaitingViewController

- (UIActivityIndicatorView *)indicatorView
{
    if (!_indicatorView) {
        _indicatorView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
    }
    return _indicatorView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view setBackgroundColor:[[UIColor lightGrayColor] colorWithAlphaComponent:0.9]];
    // 隐藏导航条
    //self.navigationController.navigationBar.hidden = YES;
    
    
    [self.view addSubview:self.indicatorView];
    // 设置约束
    [self.indicatorView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view.mas_centerX);
        make.centerY.equalTo(self.view.mas_centerY);
    }];
}

- (BOOL)prefersStatusBarHidden
{
    return NO;
}

- (UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}


- (void)viewWillAppear:(BOOL)animated
{
    [self.indicatorView startAnimating];
    
    NSLog(@"显示");
    // 页面显示出来后，判断是否已经登录
    NSString *token = [[NSUserDefaults standardUserDefaults] valueForKey:@"com.rongcloud.token"];
    if (!token) {
        WDLoginViewController *loginVC = [[WDLoginViewController alloc] init];
        [self presentViewController:loginVC animated:YES completion:nil];
    } else {
        NSLog(@"进入会话界面！");
//        RCConversationViewController *conversationVC = [[RCConversationViewController alloc] initWithConversationType:ConversationType_PRIVATE targetId:@"10001"];
        //[self.navigationController pushViewController:conversationVC animated:YES];
        
        [RCIM sharedRCIM].connectionStatusDelegate = self;
        [[RCIM sharedRCIM] connectWithToken:token success:^(NSString *userId) {
            NSLog(@"connectWithToken: success:");
        } error:^(RCConnectErrorCode status) {
            if (status == RC_CONNECTION_EXIST) {
                [self onRCIMConnectionStatusChanged:ConnectionStatus_Connected];
            }
        } tokenIncorrect:^{
            NSLog(@"tokenIncorrect");
        }];
        
        
    }
}

- (void)viewWillDisappear:(BOOL)animated
{
    [self.indicatorView stopAnimating];
}

#pragma mark - RCIMConnectionStatusDelegate
- (void)onRCIMConnectionStatusChanged:(RCConnectionStatus)status
{
    if (status == ConnectionStatus_Connected) {
        dispatch_async(dispatch_get_main_queue(), ^{
            WDConversationListViewController *listVC = [[WDConversationListViewController alloc] init];
            listVC.displayConversationTypeArray = @[@(ConversationType_PRIVATE)];
            [self.navigationController setViewControllers:@[listVC]];
        });
    }
}


@end

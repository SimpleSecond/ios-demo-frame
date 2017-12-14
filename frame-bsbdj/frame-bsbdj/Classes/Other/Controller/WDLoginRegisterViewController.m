//
//  WDLoginRegisterViewController.m
//  frame-bsbdj
//
//  Created by WangDongya on 2017/12/6.
//  Copyright © 2017年 example. All rights reserved.
//

#import "WDLoginRegisterViewController.h"

@interface WDLoginRegisterViewController ()
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *leftMargin;

@end

@implementation WDLoginRegisterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = WDRandomColor;
}

- (UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}


- (IBAction)closeLogin:(id)sender {
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)showLoginOrRegister:(UIButton *)sender {
    // 隐藏键盘
    [self.view endEditing:YES];
    // 切换界面
    if (self.leftMargin.constant) {
        self.leftMargin.constant = 0;
        sender.selected = NO;
    } else {
        self.leftMargin.constant = -self.view.wd_width;
        sender.selected = YES;
    }
    // 动画
    [UIView animateWithDuration:0.3 animations:^{
        [self loadViewIfNeeded];
    }];
}


@end

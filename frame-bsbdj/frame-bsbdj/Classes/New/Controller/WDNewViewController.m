//
//  WDNewViewController.m
//  frame-bsbdj
//
//  Created by WangDongya on 2017/12/5.
//  Copyright © 2017年 example. All rights reserved.
//

#import "WDNewViewController.h"

@interface WDNewViewController ()

@end

@implementation WDNewViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view setBackgroundColor:WDRandomColor];
    // 标题
    self.navigationItem.titleView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"MainTitle"]];
    // 左边
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setImage:[UIImage imageNamed:@"MainTagSubIcon"] forState:UIControlStateNormal];
    [button setImage:[UIImage imageNamed:@"MainTagSubIconClick"] forState:UIControlStateHighlighted];
    [button sizeToFit];
    [button addTarget:self action:@selector(tagSubIconClick) forControlEvents:UIControlEventTouchUpInside];
    
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithImage:@"MainTagSubIcon" highImage:@"MainTagSubIconClick" target:self action:@selector(tagSubIconClick)];
}

- (void)tagSubIconClick
{
    WDLog(@"%s", __func__);
}

@end

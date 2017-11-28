//
//  WDYBaseTabBarController.m
//  frame-news
//
//  Created by WangDongya on 2017/11/28.
//  Copyright © 2017年 example. All rights reserved.
//

#import "WDYBaseTabBarController.h"
#import "WDYTabBarView.h"
#import "WDYBaseNavController.h"
#import "WDYHomeController.h"

@interface WDYBaseTabBarController () <WDYTabBarContentViewDelegate>

@end

@implementation WDYBaseTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 利用KVO使用自定义的tabbar
    WDYTabBarView *tabBarView = [[WDYTabBarView alloc] init];
    tabBarView.contentView.contentDelegate = self;
    [self setValue:tabBarView forKey:@"tabBar"];
    
    // 首先加载子视图
    [self loadSubControllers];
    
}

// 加载子视图
- (void)loadSubControllers
{
    
    // 1. Home
    WDYHomeController *homeVc = [[WDYHomeController alloc] init];
    WDYBaseNavController *nav1 = [[WDYBaseNavController alloc] initWithRootViewController:homeVc];
    [self addChildViewController:nav1];
    
    // 2.
    
    
    // 3.
    
    
    // 4.
    
}

// 切换子视图
- (void)contentView:(WDYTabBarContentView*)view didSelectedItemAtIndex:(NSInteger)index
{
    NSLog(@"Index = %d", index);
    //self.selectedIndex = index;
}

// 点击中间凸起按钮事件
- (void)contentViewClickCenterItem:(WDYTabBarContentView*)view
{
    NSLog(@"点击了中间按钮事件");
}

@end

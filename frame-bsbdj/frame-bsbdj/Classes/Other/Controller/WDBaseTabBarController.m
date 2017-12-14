//
//  WDBaseTabBarController.m
//  frame-bsbdj
//
//  Created by WangDongya on 2017/12/5.
//  Copyright © 2017年 example. All rights reserved.
//

#import "WDBaseTabBarController.h"
#import "WDBaseTabBar.h"
#import "WDEssenceViewController.h"
#import "WDNewViewController.h"
#import "WDFollowViewController.h"
#import "WDMeViewController.h"
#import "WDBaseNavigationController.h"

@interface WDBaseTabBarController ()

@end

@implementation WDBaseTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    // 添加属性设置
    [self setupItemTitleAttrs];
    // 添加子控制器
    [self setupAllChildControllers];
    // 添加自定义的UITabBar
    [self setValue:[[WDBaseTabBar alloc] init] forKeyPath:@"tabBar"];
}
#pragma mark - 设置Item标题属性
- (void)setupItemTitleAttrs
{
    // 设置tabbar的文字属性
    NSMutableDictionary *normalDict = [NSMutableDictionary dictionary];
    normalDict[NSForegroundColorAttributeName] = [UIColor lightGrayColor];
    normalDict[NSFontAttributeName] = [UIFont systemFontOfSize:12];
    NSMutableDictionary *selectDict = [NSMutableDictionary dictionary];
    selectDict[NSForegroundColorAttributeName] = [UIColor darkGrayColor];
    // 设置正常属性
    [[UITabBarItem appearance] setTitleTextAttributes:normalDict forState:UIControlStateNormal];
    // 选择属性
    [[UITabBarItem appearance] setTitleTextAttributes:selectDict forState:UIControlStateSelected];
    
    [self.tabBarItem setTitleTextAttributes:normalDict forState:UIControlStateNormal];
    [self.tabBarItem setTitleTextAttributes:selectDict forState:UIControlStateSelected];
}
#pragma mark - 设置所有自控制区
- (void)setupAllChildControllers
{
    [self setupOneChildViewCongroller:[[WDBaseNavigationController alloc] initWithRootViewController:[[WDEssenceViewController alloc]init]] title:@"精华" image:@"tabBar_essence_icon" selectedImage:@"tabBar_essence_click_icon"];
    [self setupOneChildViewCongroller:[[WDBaseNavigationController alloc] initWithRootViewController:[[WDNewViewController alloc]init]] title:@"新帖" image:@"tabBar_new_icon" selectedImage:@"tabBar_new_click_icon"];
    [self setupOneChildViewCongroller:[[WDBaseNavigationController alloc] initWithRootViewController:[[WDFollowViewController alloc]init]] title:@"关注" image:@"tabBar_friendTrends_icon" selectedImage:@"tabBar_friendTrends_click_icon"];
    [self setupOneChildViewCongroller:[[WDBaseNavigationController alloc] initWithRootViewController:[[WDMeViewController alloc]init]] title:@"我" image:@"tabBar_me_icon" selectedImage:@"tabBar_me_click_icon"];
}
#pragma mark - 初始化一个子控制器
- (void)setupOneChildViewCongroller:(UIViewController *)vc title:(NSString *)title image:(NSString *)image selectedImage:(NSString *)selectedImage
{
    vc.tabBarItem.title = title;
    if (image.length) {
        vc.tabBarItem.image = [UIImage imageNamed:image];
        vc.tabBarItem.selectedImage = [UIImage imageNamed:selectedImage];
    }
    [self addChildViewController:vc];
}

@end

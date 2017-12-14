//
//  WDTabViewController.m
//  frame-bsbdj
//
//  Created by WangDongya on 2017/12/5.
//  Copyright © 2017年 example. All rights reserved.
//

#import "WDTabViewController.h"




@interface WDTabViewController ()

@property (nonatomic, strong) UIButton *publischButton;

@end


@implementation WDTabViewController

-(UIButton *)publischButton
{
    if (!_publischButton) {
        _publischButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_publischButton setImage:[UIImage imageNamed:@"tabBar_publish_icon"] forState:UIControlStateNormal];
        [_publischButton setImage:[UIImage imageNamed:@"tabBar_publish_click_icon"] forState:UIControlStateSelected];
        _publischButton.frame = CGRectMake(0, 0, self.tabBar.frame.size.width/5, self.tabBar.frame.size.height);
        _publischButton.center = CGPointMake(self.tabBar.frame.size.width * 0.5, self.tabBar.frame.size.height * 0.5);
        [_publischButton addTarget:self action:@selector(publishClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _publischButton;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
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
    
    
    [self setupOneChildViewCongroller:[[UIViewController alloc]init] title:@"精华" image:@"tabBar_essence_icon" selectedImage:@"tabBar_essence_click_icon"];
    [self setupOneChildViewCongroller:[[UIViewController alloc]init] title:@"新帖" image:@"tabBar_new_icon" selectedImage:@"tabBar_new_click_icon"];
    // 占位视图控制器
    [self setupOneChildViewCongroller:[[UIViewController alloc]init] title:nil image:nil selectedImage:nil];
    [self setupOneChildViewCongroller:[[UIViewController alloc]init] title:@"关注" image:@"tabBar_friendTrends_icon" selectedImage:@"tabBar_friendTrends_click_icon"];
    [self setupOneChildViewCongroller:[[UIViewController alloc]init] title:@"我" image:@"tabBar_me_icon" selectedImage:@"tabBar_me_click_icon"];
    
}


- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    // 一个控件addSubview无论多少次，都是将这个控件置为最前
    [self.tabBar addSubview:self.publischButton];
    
//    // 这里按钮需要只加载一次(dispatch_once / 懒加载)
//    static dispatch_once_t onceToken;
//    dispatch_once(&onceToken, ^{
//        /** 增加一个发布按钮 */
//        UIButton *publishBtn = [UIButton buttonWithType:UIButtonTypeCustom];
//        [publishBtn setImage:[UIImage imageNamed:@"tabBar_publish_icon"] forState:UIControlStateNormal];
//        [publishBtn setImage:[UIImage imageNamed:@"tabBar_publish_click_icon"] forState:UIControlStateSelected];
//        publishBtn.frame = CGRectMake(0, 0, self.tabBar.frame.size.width/5, self.tabBar.frame.size.height);
//        publishBtn.center = CGPointMake(self.tabBar.frame.size.width * 0.5, self.tabBar.frame.size.height * 0.5);
//        [publishBtn addTarget:self action:@selector(publishClick) forControlEvents:UIControlEventTouchUpInside];
//        [self.tabBar addSubview:publishBtn];
//    });
}


// 初始化一个子控制器
- (void)setupOneChildViewCongroller:(UIViewController *)vc title:(NSString *)title image:(NSString *)image selectedImage:(NSString *)selectedImage
{
    vc.view.backgroundColor = WDRandomColor;
    vc.tabBarItem.title = title;
    if (image.length) {
        vc.tabBarItem.image = [UIImage imageNamed:image];
        vc.tabBarItem.selectedImage = [UIImage imageNamed:selectedImage];
    }
    [self addChildViewController:vc];
}


- (void)publishClick
{
    WDLog(@"%s", __func__);
}



@end

//
//  WDBaseNavigationController.m
//  frame-bsbdj
//
//  Created by WangDongya on 2017/12/5.
//  Copyright © 2017年 example. All rights reserved.
//

#import "WDBaseNavigationController.h"

@interface WDBaseNavigationController () <UIGestureRecognizerDelegate>

@end

@implementation WDBaseNavigationController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 修改左上角按后，会影响到默认的右滑操作
    // 支持右滑，重新设置代理
    self.interactivePopGestureRecognizer.delegate = self;
    
    // 设置导航背景图片
//    [self.navigationBar setBackgroundImage:[UIImage imageNamed:@"navigationbarBackgroundWhite"] forBarMetrics:UIBarMetricsDefault];
}

// 重写该方法的目的：拦截所有push进的子控制器
- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    // rootViewController不需要设置左上角按钮
    if (self.childViewControllers.count > 0) {
        // 左边（返回按钮）
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        [button setImage:[UIImage imageNamed:@"navigationButtonReturn"] forState:UIControlStateNormal];
        [button setImage:[UIImage imageNamed:@"navigationButtonReturnClick"] forState:UIControlStateHighlighted];
        [button setTitle:@"返回" forState:UIControlStateNormal];
        [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [button setTitleColor:[UIColor redColor] forState:UIControlStateHighlighted];
        // 计算尺寸
        [button sizeToFit];
        // 必须尺寸展现出来后才能调用
        button.contentEdgeInsets = UIEdgeInsetsMake(0, -20, 0, 0);
        [button addTarget:self action:@selector(backClick) forControlEvents:UIControlEventTouchUpInside];
        viewController.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:button];
        
        // 隐藏底部的tabBar
        viewController.hidesBottomBarWhenPushed = YES;
    }
    // 所有设置搞定后，再push子控制器
    [super pushViewController:viewController animated:animated];
}

- (UIViewController *)popViewControllerAnimated:(BOOL)animated
{
    return [super popViewControllerAnimated:animated];
}

- (void)backClick
{
    [self popViewControllerAnimated:YES];
}

#pragma mark <UIGestureRecognizerDelegate>
- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer
{
    // return YES; 表示手势有效
    // return NO; 表示手势无效
    // 但是，最前面的控制器进行了了手势识别，则会产生问题；
    //    if (self.childViewControllers.count == 1) {  // 导航控制器中只有一个控制器
    //        return NO;
    //    }
    //    return YES;
    return self.childViewControllers.count>1;
}

@end

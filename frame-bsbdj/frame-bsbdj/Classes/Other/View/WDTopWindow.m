//
//  WDTopWindow.m
//  frame-bsbdj
//
//  Created by WangDongya on 2017/12/23.
//  Copyright © 2017年 example. All rights reserved.
//

#import "WDTopWindow.h"

@implementation WDTopWindow

static UIWindow *window_;

+ (void)show
{
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.25 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        window_ = [[UIWindow alloc] init];
        window_.frame = [UIApplication sharedApplication].statusBarFrame;
        // 窗口显示默认黑色
        window_.backgroundColor = [UIColor clearColor];
        // UIWindowLevelAlert > UIWindowLevelStatusBar > UIWindowLevelNormal
        // 窗口默认等级是UIWindowLevelNormal，等级最低，放在最下层，点击手势被拦截，无法被监听
        window_.windowLevel = UIWindowLevelAlert;
        
        // 默认是隐藏
        window_.hidden = NO;
        [window_ addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(topWindowClick)]];
    });
}

+ (void)topWindowClick
{
    // 主窗口
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    
    // 查找主窗口中的所有scrollView
    [self findScrollViewsInView:window];
}

// 查找view中所有的scrollView
+ (void)findScrollViewsInView:(UIView *)view
{
    // 利用递归查找所有的子控件
    for (UIView *subview in view.subviews) {
        [self findScrollViewsInView:subview];
    }
    
    if (![view isKindOfClass:[UIScrollView class]]) return;
    
    // 判断是否跟window有重叠
    if (![view intersectWithView:[UIApplication sharedApplication].keyWindow]) return;
    
    // 如果是scrollView
    UIScrollView *scrollView = (UIScrollView *)view;
    
    // 修改offset
    CGPoint offset = scrollView.contentOffset;
    offset.y = -scrollView.contentInset.top;
    [scrollView setContentOffset:offset animated:YES];
}

@end

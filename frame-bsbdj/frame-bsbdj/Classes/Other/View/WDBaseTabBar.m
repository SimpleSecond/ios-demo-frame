//
//  WDBaseTabBar.m
//  frame-bsbdj
//
//  Created by WangDongya on 2017/12/5.
//  Copyright © 2017年 example. All rights reserved.
//

#import "WDBaseTabBar.h"

@interface WDBaseTabBar ()

@property (nonatomic, weak) UIButton *publishButton;

@end

@implementation WDBaseTabBar

-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
//        self.backgroundImage = [UIImage imageNamed:@"tabbar-light"];
    }
    return self;
}

#pragma mark - 中间按钮
-(UIButton *)publishButton
{
    if (!_publishButton) {
        UIButton *publishButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [publishButton setImage:[UIImage imageNamed:@"tabBar_publish_icon"] forState:UIControlStateNormal];
        [publishButton setImage:[UIImage imageNamed:@"tabBar_publish_click_icon"] forState:UIControlStateSelected];
        [publishButton addTarget:self action:@selector(publishClick) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:publishButton];
        _publishButton = publishButton;
    }
    return _publishButton;
}

#pragma mark - 初始化
-(void)layoutSubviews
{
    [super layoutSubviews];
    
    CGFloat buttonW = self.wd_width / 5;
    CGFloat buttonH = self.wd_height;
    CGFloat buttonY = 0;
    // 按钮索引
    CGFloat buttonIndex = 0;
    for (UIView *subview in self.subviews) {
        // 过滤掉非UITabBarButton类的对象
        if (subview.class != NSClassFromString(@"UITabBarButton")) {
            continue;
        }
        CGFloat buttonX = buttonIndex * buttonW;
        if (buttonIndex >= 2) {
            buttonX += buttonW;
        }
        subview.frame = CGRectMake(buttonX, buttonY, buttonW, buttonH);
        buttonIndex++;
    }
    // 加载发布按钮，并设置位置大小
    self.publishButton.wd_width = buttonW;
    self.publishButton.wd_height = buttonH;
    self.publishButton.center = CGPointMake(self.wd_width * 0.5, self.wd_height * 0.5);
    // 注意：控件的中心点必须在控件大小设置完毕后，才能正常响应。
}

#pragma mark - 发布事件
- (void)publishClick
{
    WDLog(@"%s", __func__);
}

#pragma mark - 凸起Button原本是接收不到点击事件的，需要重新hitTest:withEvent:方法
- (UIView*)hitTest:(CGPoint)point withEvent:(UIEvent *)event
{
    if (self.clipsToBounds || self.hidden || (self.alpha == 0.f)) {
        return nil;
    }
    UIView *result = [super hitTest:point withEvent:event];
    // 如果事件发生在tabbar里面直接返回
    if (result) {
        return result;
    }
    // 这里遍历那些超出部分
    for (UIView *view in self.subviews) {
        // 这个坐标从tabbar的坐标系转为subview的坐标系
        CGPoint subPoint = [view convertPoint:point fromView:self];
        result = [view hitTest:subPoint withEvent:event];
        // 如果事件发生在 view 里就返回
        if (result) {
            return result;
        }
    }
    return nil;
}

@end

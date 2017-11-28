//
//  WDYTabBarView.m
//  frame-news
//
//  Created by WangDongya on 2017/11/28.
//  Copyright © 2017年 example. All rights reserved.
//

#import "WDYTabBarView.h"

@implementation WDYTabBarView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self addSubview:self.contentView];
    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    // 设置contentView的frame
    self.contentView.frame = self.bounds;
    // 把contentView置为最前
    [self bringSubviewToFront:self.contentView];
}

- (WDYTabBarContentView *)contentView
{
    if (!_contentView) {
        _contentView = [[WDYTabBarContentView alloc] init];
    }
    return _contentView;
}

// 凸起Button原本是接收不到点击事件的，需要重新hitTest:withEvent:方法
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

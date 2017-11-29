//
//  WDYTabBarContentView.m
//  frame-news
//
//  Created by WangDongya on 2017/11/28.
//  Copyright © 2017年 example. All rights reserved.
//

#import "WDYTabBarContentView.h"
#import "WDYVerticalButton.h"


@interface WDYTabBarContentView ()
// 视图背景图片
@property (nonatomic, strong) UIImageView *tabBackgroundView;
// 当前选中的位置
@property (nonatomic, assign) NSInteger selectIndex;
@property (nonatomic, strong) NSArray *imageNameList; // 图片名称
@property (nonatomic, strong) NSArray *titleList; // 标题名称
@property (nonatomic, strong) WDYVerticalButton *lastItem; // 上传选中按钮

// 中间凸出按钮
@property (nonatomic, strong) UIButton *centerItem;

@end


@implementation WDYTabBarContentView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self loadSubviews];
    }
    return self;
}

// 加载子视图
- (void)loadSubviews
{
    // 1. 加载背景
    [self addSubview:self.tabBackgroundView];
    
    // 2. 加载四个Item
    for (int i=0; i<self.imageNameList.count; i++) {
        WDYVerticalButton *item = [WDYVerticalButton buttonWithType:UIButtonTypeCustom];
        item.adjustsImageWhenHighlighted = NO;
        [item setImage:[UIImage imageNamed:self.imageNameList[i]] forState:UIControlStateNormal];
        [item setImage:[UIImage imageNamed:[NSString stringWithFormat:@"%@_p", self.imageNameList[i]]] forState:UIControlStateSelected];
        [item setImage:[UIImage imageNamed:[NSString stringWithFormat:@"%@_p", self.imageNameList[i]]] forState:UIControlStateHighlighted];
        
        [item setTitle:self.titleList[i] forState:UIControlStateNormal];
        [item setTitleColor:[UIColor redColor] forState:UIControlStateSelected];
        
        // ##
        item.tag = i;
        [item addTarget:self action:@selector(clickItem:) forControlEvents:UIControlEventTouchUpInside];
        
        // 初始化时，设置第一个为选中按钮
        if (i == 0) {
            item.selected = YES;
            self.lastItem = item;
        }
        
        // 添加视图
        [self addSubview:item];
    }
    
    // 3. 加载中间按钮
    [self addSubview:self.centerItem];
}

// 调整子视图布局
- (void)layoutSubviews
{
    [super layoutSubviews];
    [self setBackgroundColor:[UIColor whiteColor]];
    
    // 取出WDYVerticalButton
    NSMutableArray *tabBarItemArr = [NSMutableArray array];
    for (UIView *view in self.subviews) {
        if ([view isKindOfClass:[WDYVerticalButton class]]) {
            [tabBarItemArr addObject:view];
        }
    }
    
    // 调整布局
    CGFloat barWidth = self.bounds.size.width;
    CGFloat barHeight = self.bounds.size.height;
    CGFloat centerBtnWidth = CGRectGetWidth(self.centerItem.frame);
    CGFloat centerBtnHeight = CGRectGetHeight(self.centerItem.frame);
    // 设置中间按钮的位置，居中，部分凸起
    self.centerItem.center = CGPointMake(barWidth/2, barHeight - centerBtnHeight/2 + 10);
    
    // 平均分配其他 tabBarItem 的宽度
    CGFloat barItemWidth = (barWidth - centerBtnWidth) / tabBarItemArr.count;
    // 逐个布局 tabBarItem , 修改 UITabBarButton 的 frame
    [tabBarItemArr enumerateObjectsUsingBlock:^(UIView * _Nonnull view, NSUInteger idx, BOOL * _Nonnull stop) {
        CGRect frame = view.frame;
        if (idx >= tabBarItemArr.count / 2) {
            // 重新设置 x 坐标 : 排在中间按钮的右边需要加上中间按钮的宽度
            frame.origin.x = idx * barItemWidth + centerBtnWidth;
        } else {
            frame.origin.x = idx * barItemWidth;
        }
        // 重新设置宽度和高度，默认y轴都为0
        frame.size.width = barItemWidth;
        frame.size.height = barHeight;
        view.frame = frame;
    }];
    
    // 将中间按钮置为最前端
    [self bringSubviewToFront:self.centerItem];
}

// 按钮的点击事件
- (void)clickItem:(UIButton *)button
{
    // 如果上次点击按钮与本次点击按钮为同一个，则返回
    if (self.lastItem.tag == button.tag) {
        return;
    }
    
    // 按钮分类调用不同事件
    if ([button isKindOfClass:[WDYVerticalButton class]]) {
        // 调用代理方法，切换视图控制器
        [self.contentDelegate contentView:self didSelectedItemAtIndex:button.tag];
        
        // 点击按钮的样式设置
        self.selectIndex = button.tag;
        button.selected = YES;
        
        // 上次按钮样式的设置
        self.lastItem.selected = NO;
        self.lastItem = (WDYVerticalButton*)button;
        
        // 放大缩小 动画效果
        [UIView animateWithDuration:0.3 animations:^{
            button.imageView.transform = CGAffineTransformMakeScale(1.2, 1.2);
        } completion:^(BOOL finished) {
            [UIView animateWithDuration:0.3 animations:^{
                button.imageView.transform = CGAffineTransformIdentity;
            }];
        }];
    } else {
        // 调用中间按钮的代理方法
        [self.contentDelegate contentViewClickCenterItem:self];
    }
    
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

// 中间凸起按钮初始化
- (UIButton *)centerItem
{
    if (_centerItem == nil) {
        _centerItem = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 90, 90)];
        [_centerItem setImage:[UIImage imageNamed:@"tab_launch"] forState:UIControlStateNormal];
        // 添加点击事件
        [_centerItem addTarget:self action:@selector(clickItem:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _centerItem;
}

// Tab标题列表
- (NSArray *)titleList
{
    if (_titleList == nil) {
        _titleList = @[@"首页", @"直播", @"附近", @"我的"];
    }
    return _titleList;
}

// 图标名称列表
- (NSArray *)imageNameList
{
    if (_imageNameList == nil) {
        _imageNameList = @[@"tab_live", @"tab_following", @"tab_near", @"tab_me"];
    }
    return _imageNameList;
}

// 背景图片的实例化
- (UIImageView *)tabBackgroundView
{
    if (_tabBackgroundView == nil) {
        _tabBackgroundView = [[UIImageView alloc] initWithImage:[UIImage new]];
    }
    return _tabBackgroundView;
}
@end

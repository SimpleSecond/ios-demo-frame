//
//  UIView+WDExtension.m
//  ios-shanGeView
//
//  Created by WangDongya on 2017/12/26.
//  Copyright © 2017年 example. All rights reserved.
//

#import "UIView+WDExtension.h"
#import <Masonry/Masonry.h>

@implementation UIView (WDExtension)

- (void)distributeSpacingHorizontalWith:(NSArray *)views
{
    NSMutableArray *spaces = [NSMutableArray arrayWithCapacity:views.count + 1];
    
    for (int i=0; i<views.count + 1; i++) {
        UIView *v = [UIView new];
        [spaces addObject:v];
        [self addSubview:v];
        
        // 添加约束 (宽高相等)
        [v mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.equalTo(v.mas_height);
        }];
    }
    
    UIView *v0 = spaces[0];
    
    __weak typeof(self)  weakSelf = self;
    
    [v0 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.mas_left);
        make.centerY.equalTo(((UIView *)views[0]).mas_centerY);
    }];
    
    UIView *lastSpace = v0;
    for (int i=0 ; i<views.count ; i++) {
        UIView *obj = views[i];
        UIView *space = spaces[i+1];
        
        [obj mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(lastSpace.mas_right);
        }];
        
        [spaces mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(obj.mas_right);
            make.centerY.equalTo(obj.mas_centerY);
            make.width.equalTo(v0);
        }];
        
        lastSpace = space;
    }
    
    [lastSpace mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(weakSelf.mas_right);
    }];
}

-(void)distributeSpacingVerticalWith:(NSArray *)views
{
    NSMutableArray *spaces = [NSMutableArray arrayWithCapacity:views.count + 1];
    
    for (int i=0; i<views.count + 1; i++) {
        UIView *v = [UIView new];
        [spaces addObject:v];
        [self addSubview:v];
        
        // 添加约束 (宽高相等)
        [v mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.equalTo(v.mas_height);
        }];
    }
    
    UIView *v0 = spaces[0];
    
    __weak typeof(self)  weakSelf = self;
    
    [v0 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.mas_top);
        make.centerX.equalTo(((UIView *)views[0]).mas_centerX);
    }];
    
    UIView *lastSpace = v0;
    for (int i=0 ; i<views.count ; i++) {
        UIView *obj = views[i];
        UIView *space = spaces[i+1];
        
        [obj mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(lastSpace.mas_bottom);
        }];
        
        [spaces mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(obj.mas_bottom);
            make.centerX.equalTo(obj.mas_centerX);
            make.height.equalTo(v0);
        }];
        
        lastSpace = space;
    }
    
    [lastSpace mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(weakSelf.mas_bottom);
    }];
}

@end

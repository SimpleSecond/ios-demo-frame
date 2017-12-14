//
//  WDEssTitleButton.m
//  frame-bsbdj
//
//  Created by WangDongya on 2017/12/8.
//  Copyright © 2017年 example. All rights reserved.
//

#import "WDEssTitleButton.h"

@implementation WDEssTitleButton

-(instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        // 设置文字状态
        [self setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [self setTitleColor:[UIColor redColor] forState:UIControlStateSelected];
        // 设置文字大小
        [self.titleLabel setFont:[UIFont systemFontOfSize:14]];
    }
    return self;
}

-(void)setHighlighted:(BOOL)highlighted{}

@end

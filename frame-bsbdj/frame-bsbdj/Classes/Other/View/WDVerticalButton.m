//
//  WDVerticalButton.m
//  frame-bsbdj
//
//  Created by WangDongya on 2017/12/6.
//  Copyright © 2017年 example. All rights reserved.
//

#import "WDVerticalButton.h"

@implementation WDVerticalButton

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    
    // 图片居中
    CGPoint center = self.imageView.center;
    center.x = self.frame.size.width/2;
    center.y = self.frame.size.height/2 + 5;
    self.imageView.center = center;
    
    // 文字居中
    CGRect textFrame = [self titleLabel].frame;
    textFrame.origin.x = 0;
    textFrame.origin.y = CGRectGetMaxY(self.imageView.frame) + 2;
    textFrame.size.width = self.frame.size.width;
    self.titleLabel.frame = textFrame;
    self.titleLabel.textAlignment = NSTextAlignmentCenter;
    self.titleLabel.font = [UIFont systemFontOfSize:12];
    
//    // 状态文字颜色的设置
//    [self setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
//    [self setTitleColor:[UIColor redColor] forState:UIControlStateSelected];
}

@end

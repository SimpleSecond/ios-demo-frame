//
//  WDMeSquareButton.m
//  frame-bsbdj
//
//  Created by WangDongya on 2017/12/7.
//  Copyright © 2017年 example. All rights reserved.
//

#import "WDMeSquareButton.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import <SDWebImage/UIButton+WebCache.h>
#import "WDMeSquare.h"

@implementation WDMeSquareButton

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        self.titleLabel.textAlignment = NSTextAlignmentCenter;
        [self setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        self.titleLabel.font = [UIFont systemFontOfSize:14];
        [self setBackgroundImage:[UIImage imageNamed:@"mainCellBackground"] forState:UIControlStateNormal];
    }
    return self;
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    
    // 调整图片
    self.imageView.wd_y = self.wd_height * 0.2;
    self.imageView.wd_height = self.wd_height * 0.5;
    self.imageView.wd_width = self.imageView.wd_height;
    self.imageView.wd_centerX = self.wd_centerX;
    
    // 调整文字
    self.titleLabel.wd_x = 0;
    self.titleLabel.wd_y = self.imageView.wd_bottom;
    self.titleLabel.wd_height = self.wd_height - self.imageView.wd_bottom;
    self.titleLabel.wd_width = self.wd_width;
}

- (void)setSquare:(WDMeSquare *)square
{
    _square = square;
    // 设置数据
    [self setTitle:square.name forState:UIControlStateNormal];
    
    // 设置图片
//    [self setImage:[UIImage imageNamed:@"setup-head-default"] forState:UIControlStateNormal];
    [self sd_setImageWithURL:[NSURL URLWithString:square.icon] forState:UIControlStateNormal placeholderImage:[UIImage imageNamed:@"setup-head-default"]];
}

@end

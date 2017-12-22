//
//  WDCommentSectionHeader.m
//  frame-bsbdj
//
//  Created by WangDongya on 2017/12/21.
//  Copyright © 2017年 example. All rights reserved.
//

#import "WDCommentSectionHeader.h"

@implementation WDCommentSectionHeader


-(instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithReuseIdentifier:reuseIdentifier]) {
        self.textLabel.textColor = [UIColor darkGrayColor];
        self.contentView.backgroundColor = WDCommonColor;
    }
    return self;
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    
    // 覆盖子控件的一些设置
    self.textLabel.font = [UIFont systemFontOfSize:14];
    // 设置label的x值
    self.textLabel.wd_x = WDMarginSmall;
}


@end

//
//  WDMeCell.m
//  frame-bsbdj
//
//  Created by WangDongya on 2017/12/7.
//  Copyright © 2017年 example. All rights reserved.
//

#import "WDMeCell.h"

@implementation WDMeCell


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.imageView.contentMode = UIViewContentModeScaleAspectFit;
        self.textLabel.textColor = [UIColor darkGrayColor];
        // 右侧箭头（系统自带）
        self.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        // 右侧箭头（图片）
        // self.accessoryView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"arrow"]];
        // 背景图片
        self.backgroundView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"mainCellBackground"]];
    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    if (self.imageView.image == nil) {
        return;
    }
    // 如有图片，则设置图片边距（5）
    self.imageView.wd_y = WDSmallMargin;
    self.imageView.wd_height = self.contentView.wd_height - WDSmallMargin * 2;
    // 设置文字距离图片的距离10
    self.textLabel.wd_x = CGRectGetMaxX(self.imageView.frame) + WDMargin;
}

- (void)awakeFromNib {
    [super awakeFromNib];
}

@end

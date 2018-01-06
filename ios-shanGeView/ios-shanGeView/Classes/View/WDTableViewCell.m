//
//  WDTableViewCell.m
//  ios-shanGeView
//
//  Created by WangDongya on 2017/12/26.
//  Copyright © 2017年 example. All rights reserved.
//

#import "WDTableViewCell.h"
#import <Masonry/Masonry.h>


@implementation WDTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
    }
    return self;
}

- (void)setJsonStr:(NSString *)jsonStr
{
    [self.layoutView removeFromSuperview];
    self.layoutView = [WDGridLayoutView new];
    self.layoutView.jsonStr = jsonStr;
    [self addSubview:self.layoutView];
    
    // 添加约束
    [self.layoutView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.mas_equalTo(self);
        make.height.mas_equalTo([WDGridLayoutView GridViewHeightWithJsonStr:jsonStr]);
    }];
    
}


@end

//
//  ProductTagViewCell.m
//  tbCart
//
//  Created by WangDongya on 2018/1/15.
//  Copyright © 2018年 wdy-test. All rights reserved.
//

#import "ProductTagViewCell.h"
#import "Masonry.h"

@implementation ProductTagViewCell

-(UILabel *)leftTitleLabel
{
    if (!_leftTitleLabel) {
        _leftTitleLabel = [[UILabel alloc] init];
        _leftTitleLabel.font = [UIFont boldSystemFontOfSize:18];
    }
    return _leftTitleLabel;
}

-(SKTagView *)tagView
{
    if (!_tagView) {
        _tagView = [[SKTagView alloc] init];
    }
    return _tagView;
}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        // 添加子视图
        [self.contentView addSubview:self.leftTitleLabel];
        [self.contentView addSubview:self.tagView];
        
        
        // 注意：约束必须在初始化中设置好，不能在layoutSubview中设置。避免影响之后cell高度
        
        
        // 添加子视图的约束
        // 1. 宽度不够时
        // [_label1 setContentCompressionResistancePriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisHorizontal];
        // 2. 宽度够时
        // [label setContentHuggingPriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisHorizontal];
        [self.leftTitleLabel setContentHuggingPriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisHorizontal];
        [self.leftTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.contentView).offset(20);
            make.top.equalTo(self.contentView).offset(5);
        }];
        
        //[self.tagView setContentCompressionResistancePriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisVertical];
        [self.tagView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.contentView);
            make.right.equalTo(self.contentView).offset(-5);
            make.bottom.equalTo(self.contentView).offset(-5);
            
            make.left.equalTo(self.leftTitleLabel.mas_right).offset(10);
        }];
    }
    return self;
}



@end

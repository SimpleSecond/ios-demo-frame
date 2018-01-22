//
//  RelatedProductCell.m
//  tbCart
//
//  Created by WangDongya on 2018/1/22.
//  Copyright © 2018年 wdy-test. All rights reserved.
//

#import "RelatedProductCell.h"
#import <Masonry/Masonry.h>

@implementation RelatedProductCell

#pragma mark -

+ (void)initialize
{
    NSLog(@"RelatedProductCell initialize");
}

+ (void)load
{
    NSLog(@"RelatedProductCell load");
}

#pragma mark - 初始化
- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self.contentView setBackgroundColor:[UIColor whiteColor]];
        [self setupViews];
    }
    return self;
}


- (void)setupViews
{
    [self.contentView addSubview:self.imageView];
    [self.contentView addSubview:self.nameLabel];
    [self.contentView addSubview:self.priceLabel];
    [self.contentView addSubview:self.contryLabel];
    
    [self.imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.contentView);
        make.top.equalTo(self.contentView);
        make.trailing.equalTo(self.contentView);
        
        make.height.equalTo(self.imageView.mas_width);
    }];
    [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.contentView).offset(8);
        make.trailing.equalTo(self.contentView).offset(-6);
        make.top.equalTo(self.imageView.mas_bottom).offset(5);
    }];
    [self.priceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.contentView).offset(8);
        make.trailing.equalTo(self.contentView).offset(-8);
        make.top.equalTo(self.nameLabel.mas_bottom).offset(8);
    }];
    [self.contryLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.contentView).offset(8);
        make.top.equalTo(self.priceLabel.mas_bottom).offset(8);
    }];
}



#pragma mark - 懒加载
- (UIImageView *)imageView
{
    if (!_imageView) {
        _imageView = [[UIImageView alloc] init];
    }
    return _imageView;
}

- (UILabel *)contryLabel
{
    if (!_contryLabel) {
        _contryLabel = [[UILabel alloc] init];
        _contryLabel.textColor = [UIColor lightGrayColor];
        _contryLabel.font = [UIFont systemFontOfSize:12];
    }
    return _contryLabel;
}

- (UILabel *)priceLabel
{
    if (!_priceLabel) {
        _priceLabel = [[UILabel alloc] init];
        _priceLabel.textColor = [UIColor blackColor];
        _priceLabel.font = [UIFont systemFontOfSize:14];
    }
    return _priceLabel;
}

- (UILabel *)nameLabel
{
    if (!_nameLabel) {
        _nameLabel = [[UILabel alloc] init];
        _nameLabel.numberOfLines = 2;
        _nameLabel.textColor = [UIColor blackColor];
        _nameLabel.font = [UIFont systemFontOfSize:11];
    }
    return _nameLabel;
}


@end

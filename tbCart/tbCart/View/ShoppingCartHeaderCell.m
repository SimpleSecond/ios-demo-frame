//
//  ShoppingCartHeaderCell.m
//  tbCart
//
//  Created by WangDongya on 2018/1/18.
//  Copyright © 2018年 wdy-test. All rights reserved.
//

#import "ShoppingCartHeaderCell.h"
#import <Masonry/Masonry.h>


@interface ShoppingCartHeaderCell()

@property (nonatomic, strong) UIImageView *arrowRightImageView;

@end

@implementation ShoppingCartHeaderCell

- (instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithReuseIdentifier:reuseIdentifier]) {
        [self.contentView setBackgroundColor:[UIColor whiteColor]];
        // 添加子视图并设置约束
        [self setupSubviews];
    }
    return self;
}

#pragma mark - 事件
- (void)buyerClickSelected:(id)sender
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(buyerSelected:)]) {
        [self.delegate buyerSelected:self.sectionIndex];
    }
}

- (void)buyerClickEdit:(id)sender
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(buyerEditingSelected:)]) {
        [self.delegate buyerEditingSelected:self.sectionIndex];
    }
}


#pragma mark - 添加视图及约束

- (void)setupSubviews
{
    [self.contentView addSubview:self.headerSelectedBtn];
    [self.headerSelectedBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.contentView);
        make.top.equalTo(self.contentView);
        make.bottom.equalTo(self.contentView);
        
        make.width.mas_equalTo(35);
    }];
    
    [self.contentView addSubview:self.buyerImageView];
    [self.buyerImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView).offset(5);
        make.bottom.equalTo(self.contentView).offset(-5);
        make.leading.equalTo(self.headerSelectedBtn.mas_trailing).offset(10);
        make.width.mas_equalTo(39);
    }];
    
    [self.contentView addSubview:self.buyerNameBackView];
    [self.buyerNameBackView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView);
        make.bottom.equalTo(self.contentView);
        
        make.leading.equalTo(self.buyerImageView.mas_trailing).offset(10);
    }];
    
    [self.buyerNameBackView addSubview:self.buyerNameLabel];
    [self.buyerNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.buyerNameBackView);
        make.centerY.equalTo(self.buyerNameBackView);
    }];
    
    [self.buyerNameBackView addSubview:self.arrowRightImageView];
    [self.arrowRightImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.buyerNameLabel.mas_trailing).offset(5);
        make.centerY.equalTo(self.buyerNameBackView);
    }];
    
    [self.contentView addSubview:self.editSectionHeaderBtn];
    [self.editSectionHeaderBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.trailing.equalTo(self.contentView);
        make.top.equalTo(self.contentView);
        make.bottom.equalTo(self.contentView);
        
        make.width.mas_equalTo(60);
        make.leading.equalTo(self.buyerNameBackView.mas_trailing);
    }];
}

#pragma mark - 懒加载

- (UIButton *)headerSelectedBtn
{
    if (!_headerSelectedBtn) {
        _headerSelectedBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_headerSelectedBtn setImage:[UIImage imageNamed:@"checkbox_0"] forState:UIControlStateNormal];
        [_headerSelectedBtn setImage:[UIImage imageNamed:@"checkbox_1"] forState:UIControlStateSelected];
        
        [_headerSelectedBtn addTarget:self action:@selector(buyerClickSelected:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _headerSelectedBtn;
}

- (UIImageView *)buyerImageView
{
    if (!_buyerImageView) {
        _buyerImageView = [[UIImageView alloc] init];
    }
    return _buyerImageView;
}

- (UIView *)buyerNameBackView
{
    if (!_buyerNameBackView) {
        _buyerNameBackView = [[UIView alloc] init];
    }
    return _buyerNameBackView;
}

- (UIButton *)editSectionHeaderBtn
{
    if (!_editSectionHeaderBtn) {
        _editSectionHeaderBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_editSectionHeaderBtn setTitle:@"编辑" forState:UIControlStateNormal];
        [_editSectionHeaderBtn setTitle:@"完成" forState:UIControlStateSelected];
        [_editSectionHeaderBtn setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
        
        [_editSectionHeaderBtn addTarget:self action:@selector(buyerClickEdit:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _editSectionHeaderBtn;
}

- (UILabel *)buyerNameLabel
{
    if (!_buyerNameLabel) {
        _buyerNameLabel = [[UILabel alloc] init];
    }
    return _buyerNameLabel;
}

- (UIImageView *)arrowRightImageView
{
    if (!_arrowRightImageView) {
        _arrowRightImageView = [[UIImageView alloc] init];
        [_arrowRightImageView setImage:[UIImage imageNamed:@"arrow_right"]];
        [_arrowRightImageView setContentMode:UIViewContentModeScaleAspectFit];
    }
    return _arrowRightImageView;
}


@end

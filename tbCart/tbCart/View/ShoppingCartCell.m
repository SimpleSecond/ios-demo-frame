//
//  ShoppingCartCell.m
//  tbCart
//
//  Created by WangDongya on 2018/1/18.
//  Copyright © 2018年 wdy-test. All rights reserved.
//

#import "ShoppingCartCell.h"
#import <Masonry/Masonry.h>

@implementation ShoppingCartCell


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        // 添加视图
        [self setupCommonView];
        [self setupNormalView];
        [self setupEditView];
    }
    return self;
}


#pragma mark - 事件

- (void)pe_clickGarbage:(id)sender
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(productGarbageClick:)]) {
        [self.delegate productGarbageClick:self];
    }
}

- (void)pe_clickPlusOrMinus:(UIButton *)sender
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(plusOrMinusCount:tag:)]) {
        [self.delegate plusOrMinusCount:self tag:sender.tag];
    }
}

- (void)pe_clickSelected:(UIButton *)sender
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(productSelected:isSelected:)]) {
        [self.delegate productSelected:self isSelected:!sender.selected];
    }
}

- (void)pe_clickProductIMG:(UITapGestureRecognizer *)tap
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(clickProductIMG:)]) {
        [self.delegate clickProductIMG:self];
    }
}

- (void)pe_clickEdit:(UITapGestureRecognizer *)tap
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(clickEditingDetailInfo:)]) {
        [self.delegate clickEditingDetailInfo:self];
    }
}


#pragma mark - 添加视图及约束
- (void)setupCommonView
{
    [self.contentView addSubview:self.productImageView];
    [self.productImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.contentView).offset(40);
        make.top.equalTo(self.contentView).offset(10);
        
        make.width.mas_equalTo(80);
        make.height.mas_equalTo(80);
    }];
    
    [self.contentView addSubview:self.leftChooseBtn];
    [self.leftChooseBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.contentView);
        make.centerY.equalTo(self.productImageView);
        
        make.height.equalTo(self.productImageView);
        make.width.mas_equalTo(35);
    }];
}

- (void)setupNormalView
{
    [self.contentView addSubview:self.normalBackView];
    [self.normalBackView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.productImageView.mas_trailing).offset(8);
        make.trailing.equalTo(self.contentView.mas_trailing).offset(-8);
        make.top.equalTo(self.contentView).offset(10);
        make.bottom.equalTo(self.contentView).offset(-10);
    }];
    
    [self.normalBackView addSubview:self.titleLabel];
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.normalBackView).offset(5);
        make.leading.equalTo(self.normalBackView);
        make.trailing.equalTo(self.normalBackView);
    }];
    
    [self.normalBackView addSubview:self.sizeDetailLabel];
    [self.sizeDetailLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.titleLabel.mas_bottom).offset(10);
        make.leading.equalTo(self.normalBackView);
        make.trailing.equalTo(self.normalBackView);
    }];
    
    [self.normalBackView addSubview:self.priceLabel];
    [self.priceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.sizeDetailLabel.mas_bottom).offset(16);
        make.leading.equalTo(self.normalBackView);
        make.bottom.equalTo(self.normalBackView);
    }];
    
    [self.normalBackView addSubview:self.countLabel];
    [self.countLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.trailing.equalTo(self.normalBackView);
        make.leading.greaterThanOrEqualTo(self.priceLabel.mas_trailing).offset(20);
        
        make.centerY.equalTo(self.priceLabel);
    }];
}

- (void)setupEditView
{
    [self.contentView addSubview:self.editBackView];
    [self.editBackView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.productImageView.mas_trailing).offset(8);
        make.trailing.equalTo(self.contentView.mas_trailing).offset(-8);
        make.top.equalTo(self.contentView).offset(10);
        make.bottom.equalTo(self.contentView).offset(-10);
    }];
    
    [self.editBackView addSubview:self.minusBtn];
    [self.minusBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.editBackView);
        make.top.equalTo(self.editBackView);
        
        make.height.mas_equalTo(50);
        make.width.equalTo(self.editBackView).dividedBy(8);
    }];
    [self.editBackView addSubview:self.editCountLabel];
    [self.editCountLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.minusBtn.mas_trailing);
        make.top.equalTo(self.editBackView);
        
        make.height.mas_equalTo(50);
        make.width.equalTo(self.editBackView).dividedBy(2);
    }];
    [self.editBackView addSubview:self.plusBtn];
    [self.plusBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.editCountLabel.mas_trailing);
        make.top.equalTo(self.editBackView);

        make.height.mas_equalTo(50);
        make.width.equalTo(self.editBackView).dividedBy(8);
    }];
    
    [self.editBackView addSubview:self.editDetailView];
    [self.editDetailView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.editBackView);
        make.bottom.equalTo(self.editBackView);
        make.trailing.equalTo(self.plusBtn.mas_trailing);
        make.top.equalTo(self.plusBtn.mas_bottom);
    }];
    
    [self.editDetailView addSubview:self.editDetailTitleLabel];
    [self.editDetailTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.editDetailView);
        make.top.equalTo(self.editDetailView);
        make.bottom.equalTo(self.editDetailView);
    }];
    
    [self.editDetailView addSubview:self.downArrowBtn];
    [self.downArrowBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.editDetailView);
        make.bottom.equalTo(self.editDetailView);
        make.trailing.equalTo(self.editDetailView).offset(-10);
        
        make.width.mas_equalTo(12);
        make.leading.greaterThanOrEqualTo(self.editDetailTitleLabel.mas_trailing).offset(20);
    }];
    
    [self.editBackView addSubview:self.deleteBtn];
    [self.deleteBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.plusBtn.mas_trailing);
        make.top.equalTo(self.editBackView);
        make.trailing.equalTo(self.editBackView);
        make.bottom.equalTo(self.editBackView);
    }];
}


#pragma mark - 懒加载

- (UIButton *)leftChooseBtn
{
    if (!_leftChooseBtn) {
        _leftChooseBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_leftChooseBtn setImage:[UIImage imageNamed:@"checkbox_0"] forState:UIControlStateNormal];
        [_leftChooseBtn setImage:[UIImage imageNamed:@"checkbox_1"] forState:UIControlStateSelected];
        
        [_leftChooseBtn addTarget:self action:@selector(pe_clickSelected:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _leftChooseBtn;
}

- (UIImageView *)productImageView
{
    if (!_productImageView) {
        _productImageView = [[UIImageView alloc] init];
        _productImageView.userInteractionEnabled = YES;
        
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(pe_clickProductIMG:)];
        [_productImageView addGestureRecognizer:tap];
    }
    return _productImageView;
}

- (UIView *)normalBackView
{
    if (!_normalBackView) {
        _normalBackView = [[UIView alloc] init];
    }
    return _normalBackView;
}

- (UILabel *)titleLabel
{
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.numberOfLines = 2;
        _titleLabel.font = [UIFont boldSystemFontOfSize:13];
        _titleLabel.textColor = [UIColor blackColor];
    }
    return _titleLabel;
}

- (UILabel *)sizeDetailLabel
{
    if (!_sizeDetailLabel) {
        _sizeDetailLabel = [[UILabel alloc] init];
        _sizeDetailLabel.numberOfLines = 2;
        _sizeDetailLabel.font = [UIFont boldSystemFontOfSize:13];
        _sizeDetailLabel.textColor = [UIColor lightGrayColor];
    }
    return _sizeDetailLabel;
}

- (UILabel *)priceLabel
{
    if (!_priceLabel) {
        _priceLabel = [[UILabel alloc] init];
        _priceLabel.numberOfLines = 1;
        _priceLabel.font = [UIFont boldSystemFontOfSize:13.0];
        _priceLabel.textColor = [UIColor redColor];
    }
    return _priceLabel;
}

- (UILabel *)countLabel
{
    if (!_countLabel) {
        _countLabel = [[UILabel alloc] init];
        _countLabel.numberOfLines = 1;
        _countLabel.font = [UIFont boldSystemFontOfSize:13.0];
        _countLabel.textColor = [UIColor orangeColor];
    }
    return _countLabel;
}

// 编辑模式下的view
- (UIView *)editBackView
{
    if (!_editBackView) {
        _editBackView = [[UIView alloc] init];
    }
    return _editBackView;
}

-(UIButton *)minusBtn
{
    if (!_minusBtn) {
        _minusBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _minusBtn.tag = 555;
        [_minusBtn setTitle:@"-" forState:UIControlStateNormal];
        [_minusBtn.titleLabel setFont:[UIFont systemFontOfSize:18]];
        [_minusBtn setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
        [_minusBtn setBackgroundColor:[UIColor colorWithRed:240.0/255.0 green:240.0/255.0 blue:240.0/255.0 alpha:1.0]];
        
        [_minusBtn addTarget:self action:@selector(pe_clickPlusOrMinus:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _minusBtn;
}

- (UILabel *)editCountLabel
{
    if (!_editCountLabel) {
        _editCountLabel = [[UILabel alloc] init];
        _editCountLabel.textAlignment = NSTextAlignmentCenter;
        _editCountLabel.font = [UIFont systemFontOfSize:17];
        [_editCountLabel setBackgroundColor:[UIColor colorWithRed:240.0/255.0 green:240.0/255.0 blue:240.0/255.0 alpha:1.0]];
    }
    return _editCountLabel;
}

- (UIButton *)plusBtn
{
    if (!_plusBtn) {
        _plusBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _plusBtn.tag = 666;
        [_plusBtn setTitle:@"+" forState:UIControlStateNormal];
        [_plusBtn.titleLabel setFont:[UIFont systemFontOfSize:18]];
        [_plusBtn setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
        [_plusBtn setBackgroundColor:[UIColor colorWithRed:240.0/255.0 green:240.0/255.0 blue:240.0/255.0 alpha:1.0]];
        
        [_plusBtn addTarget:self action:@selector(pe_clickPlusOrMinus:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _plusBtn;
}

- (UIView *)editDetailView
{
    if (!_editDetailView) {
        _editDetailView = [[UIView alloc] init];
    }
    return _editDetailView;
}

- (UILabel *)editDetailTitleLabel
{
    if (!_editDetailTitleLabel) {
        _editDetailTitleLabel = [[UILabel alloc] init];
        _editDetailTitleLabel.font = [UIFont systemFontOfSize:13.0];
        _editDetailTitleLabel.textColor = [UIColor redColor];
        _editDetailTitleLabel.numberOfLines = 1;
    }
    return _editDetailTitleLabel;
}

- (UIImageView *)downArrowBtn
{
    if (!_downArrowBtn) {
        _downArrowBtn = [[UIImageView alloc] init];
        _downArrowBtn.image = [UIImage imageNamed:@"downArrow"];
        _downArrowBtn.contentMode = UIViewContentModeScaleAspectFit;
        
        _downArrowBtn.userInteractionEnabled = YES;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(pe_clickEdit:)];
        [_downArrowBtn addGestureRecognizer:tap];
    }
    return _downArrowBtn;
}

- (UIButton *)deleteBtn
{
    if (!_deleteBtn) {
        _deleteBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_deleteBtn setImage:[UIImage imageNamed:@"delete"] forState:UIControlStateNormal];
        [_deleteBtn setBackgroundColor:[UIColor colorWithRed:217.0/255.0 green:255.0/255.0 blue:255.0/255.0 alpha:1]];
        
        [_deleteBtn addTarget:self action:@selector(pe_clickGarbage:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _deleteBtn;
}

@end

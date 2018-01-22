//
//  ProductCountViewCell.m
//  tbCart
//
//  Created by WangDongya on 2018/1/15.
//  Copyright © 2018年 wdy-test. All rights reserved.
//

#import "ProductCountViewCell.h"
#import <Masonry/Masonry.h>

@interface ProductCountViewCell ()

@property (nonatomic, strong) UIView *panelView;
@property (nonatomic, strong) UIView *topLineView;
@property (nonatomic, strong) UIView *bottomLineView;

@end

@implementation ProductCountViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self setupSubviews];
    }
    return self;
}

#pragma mark - 添加子视图并设置约束

- (void)setupSubviews
{
    // 标签
    [self.contentView addSubview:self.leftTitleLabel];
    [self.leftTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView).offset(20);
        make.centerY.equalTo(self.contentView);
    }];
    
    // 加减部分
    [self.contentView addSubview:self.plusBtn];
    [self.plusBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.contentView).offset(-15);
        make.top.equalTo(self.contentView).offset(5);
        make.bottom.equalTo(self.contentView).offset(-5);
        
        make.width.mas_equalTo(50);
    }];
    
    [self.contentView addSubview:self.countLabel];
    [self.countLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.plusBtn.mas_left);
        make.top.equalTo(self.contentView).offset(5);
        make.bottom.equalTo(self.contentView).offset(-5);
        
        make.width.mas_equalTo(120);
    }];
    
    [self.contentView addSubview:self.minusBtn];
    [self.minusBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.countLabel.mas_left);
        make.top.equalTo(self.contentView).offset(5);
        make.bottom.equalTo(self.contentView).offset(-5);
        
        make.width.mas_equalTo(50);
    }];
    
    [self.contentView addSubview:self.topLineView];
    [self.topLineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.countLabel);
        make.trailing.equalTo(self.countLabel);
        make.top.equalTo(self.countLabel);
        
        make.height.mas_equalTo(1);
    }];
    
    [self.contentView addSubview:self.bottomLineView];
    [self.bottomLineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.countLabel);
        make.trailing.equalTo(self.countLabel);
        make.top.equalTo(self.countLabel.mas_bottom).offset(-1);
        
        make.height.mas_equalTo(1);
    }];
}


#pragma mark - 懒加载

-(UILabel *)leftTitleLabel
{
    if (!_leftTitleLabel) {
        _leftTitleLabel = [[UILabel alloc] init];
        _leftTitleLabel.text = @"数量";
        _leftTitleLabel.font = [UIFont boldSystemFontOfSize:18];
    }
    return _leftTitleLabel;
}

- (UIButton *)minusBtn
{
    if (!_minusBtn) {
        _minusBtn = [[UIButton alloc] init];
        [_minusBtn setTitle:@"-" forState:UIControlStateNormal];
        [_minusBtn setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
        [_minusBtn.titleLabel setFont:[UIFont boldSystemFontOfSize:18]];
        [_minusBtn setBackgroundColor:[UIColor lightGrayColor]];
        
        _minusBtn.layer.borderWidth = 1.f;
        _minusBtn.layer.borderColor = [UIColor blackColor].CGColor;
        _minusBtn.layer.masksToBounds = YES;
    }
    return _minusBtn;
}

- (UIButton *)plusBtn
{
    if (!_plusBtn) {
        _plusBtn = [[UIButton alloc] init];
        [_plusBtn setTitle:@"+" forState:UIControlStateNormal];
        [_plusBtn setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
        [_plusBtn.titleLabel setFont:[UIFont boldSystemFontOfSize:18]];
        [_plusBtn setBackgroundColor:[UIColor lightGrayColor]];
        
        _plusBtn.layer.borderWidth = 1.f;
        _plusBtn.layer.borderColor = [UIColor blackColor].CGColor;
        _plusBtn.layer.masksToBounds = YES;
    }
    return _plusBtn;
}

- (UILabel *)countLabel
{
    if (!_countLabel) {
        _countLabel = [[UILabel alloc] init];
        _countLabel.text = @"1";
        _countLabel.font = [UIFont boldSystemFontOfSize:16];
        _countLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _countLabel;
}

- (UIView *)panelView
{
    if (!_panelView) {
        _panelView = [[UIView alloc] init];
    }
    return _panelView;
}

- (UIView *)topLineView
{
    if (!_topLineView) {
        _topLineView = [[UIView alloc] init];
        [_topLineView setBackgroundColor:[UIColor blackColor]];
    }
    return _topLineView;
}

- (UIView *)bottomLineView
{
    if (!_bottomLineView) {
        _bottomLineView = [[UIView alloc] init];
        [_bottomLineView setBackgroundColor:[UIColor blackColor]];
    }
    return _bottomLineView;
}



@end

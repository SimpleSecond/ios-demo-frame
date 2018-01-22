//
//  RelatedHeaderReusableView.m
//  tbCart
//
//  Created by WangDongya on 2018/1/22.
//  Copyright © 2018年 wdy-test. All rights reserved.
//

#import "RelatedHeaderReusableView.h"
#import <Masonry/Masonry.h>


@interface RelatedHeaderReusableView ()

@property (nonatomic, strong) UIButton *centerSperator;
@property (nonatomic, strong) UIView *leftSperator;
@property (nonatomic, strong) UIView *rightSperator;

@end

@implementation RelatedHeaderReusableView


- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self setBackgroundColor:[UIColor whiteColor]];
        [self setupViews];
        
        NSLog(@"RelatedHeaderReusableView initWithFrame:");
    }
    return self;
}

- (void)setupViews
{
    [self addSubview:self.centerSperator];
    [self addSubview:self.leftSperator];
    [self addSubview:self.rightSperator];
    
    [self.centerSperator mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self);
        make.centerY.equalTo(self);
    }];
    
    [self.leftSperator mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self);
        make.left.equalTo(self).offset(20);
        make.right.equalTo(self.centerSperator.mas_left).offset(-20);
        
        make.height.mas_equalTo(1);
    }];
    
    [self.rightSperator mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self);
        make.left.equalTo(self.centerSperator.mas_right).offset(20);
        make.right.equalTo(self).offset(-20);
        
        make.height.mas_equalTo(1);
    }];
}


#pragma mark - 懒加载

- (UIButton *)centerSperator
{
    if (!_centerSperator) {
        _centerSperator = [UIButton buttonWithType:UIButtonTypeCustom];
        [_centerSperator setImage:[UIImage imageNamed:@"dot1"] forState:UIControlStateNormal];
        [_centerSperator setTitle:@"猜你喜欢" forState:UIControlStateNormal];
        [_centerSperator setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
        [_centerSperator.titleLabel setFont:[UIFont systemFontOfSize:16]];
    }
    return _centerSperator;
}

- (UIView *)leftSperator
{
    if (!_leftSperator) {
        _leftSperator = [[UIView alloc] init];
        [_leftSperator setBackgroundColor:[UIColor lightGrayColor]];
    }
    return _leftSperator;
}

- (UIView *)rightSperator
{
    if (!_rightSperator) {
        _rightSperator = [[UIView alloc] init];
        [_rightSperator setBackgroundColor:[UIColor lightGrayColor]];
    }
    return _rightSperator;
}



@end

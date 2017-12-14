//
//  WDLoginRegisterTextField.m
//  frame-bsbdj
//
//  Created by WangDongya on 2017/12/6.
//  Copyright © 2017年 example. All rights reserved.
//

#import "WDLoginRegisterTextField.h"

@implementation WDLoginRegisterTextField

-(void)awakeFromNib
{
    [super awakeFromNib];
    // 设置光标颜色
    self.tintColor = [UIColor whiteColor];
    
    // 设置placeHolder的颜色
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    dict[NSForegroundColorAttributeName] = [UIColor lightGrayColor];
    NSAttributedString *placeholderAttr = [[NSAttributedString alloc] initWithString:self.placeholder attributes: dict];
    self.attributedPlaceholder = placeholderAttr;
    
    
    // 监听器：监听编辑状态的改变
    [self addTarget:self action:@selector(editBegin) forControlEvents:UIControlEventEditingDidBegin];
     [self addTarget:self action:@selector(editEnd) forControlEvents:UIControlEventEditingDidEnd];
}

- (void)editBegin
{
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    dict[NSForegroundColorAttributeName] = [UIColor whiteColor];
    NSAttributedString *placeholderAttr = [[NSAttributedString alloc] initWithString:self.placeholder attributes: dict];
    self.attributedPlaceholder = placeholderAttr;
}

- (void)editEnd
{
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    dict[NSForegroundColorAttributeName] = [UIColor lightGrayColor];
    NSAttributedString *placeholderAttr = [[NSAttributedString alloc] initWithString:self.placeholder attributes: dict];
    self.attributedPlaceholder = placeholderAttr;
}


@end

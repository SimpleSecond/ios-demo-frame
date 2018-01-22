//
//  ProductCountViewCell.h
//  tbCart
//
//  Created by WangDongya on 2018/1/15.
//  Copyright © 2018年 wdy-test. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ProductCountViewCell : UITableViewCell

@property (nonatomic, strong) UILabel *leftTitleLabel;
@property (nonatomic, strong) UIButton *minusBtn;
@property (nonatomic, strong) UIButton *plusBtn;
@property (nonatomic, strong) UILabel *countLabel;

@end

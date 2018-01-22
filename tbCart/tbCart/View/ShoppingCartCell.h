//
//  ShoppingCartCell.h
//  tbCart
//
//  Created by WangDongya on 2018/1/18.
//  Copyright © 2018年 wdy-test. All rights reserved.
//

#import <UIKit/UIKit.h>


@class ShoppingCartCell;
@protocol ShoppingCartCellDelegate <NSObject>

// 点击单个商品选择按钮回调
- (void)productSelected:(ShoppingCartCell *)cell isSelected:(BOOL)choosed;
// 点击垃圾桶删除
- (void)productGarbageClick:(ShoppingCartCell *)cell;
// 商品添加或减少回调
- (void)plusOrMinusCount:(ShoppingCartCell *)cell tag:(NSInteger)tag;
// 点击编辑规格按钮下拉回调
- (void)clickEditingDetailInfo:(ShoppingCartCell *)cell;
// 点击图片回调到主页显示
- (void)clickProductIMG:(ShoppingCartCell *)cell;

@end

@interface ShoppingCartCell : UITableViewCell

@property (nonatomic, weak) id<ShoppingCartCellDelegate> delegate;

// 左侧选择按钮、商品图片
@property (nonatomic, strong) UIButton *leftChooseBtn;
@property (nonatomic, strong) UIImageView *productImageView;


// 普通模式下的容器view
@property (nonatomic, strong) UIView *normalBackView;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *sizeDetailLabel;
@property (nonatomic, strong) UILabel *priceLabel;
@property (nonatomic, strong) UILabel *countLabel;

// 编辑模式下的view
@property (nonatomic, strong) UIView *editBackView;
@property (nonatomic, strong) UIButton *minusBtn;
@property (nonatomic, strong) UILabel *editCountLabel;
@property (nonatomic, strong) UIButton *plusBtn;
@property (nonatomic, strong) UIView *editDetailView;
@property (nonatomic, strong) UILabel *editDetailTitleLabel;
@property (nonatomic, strong) UIImageView *downArrowBtn;
@property (nonatomic, strong) UIButton *deleteBtn;


@end

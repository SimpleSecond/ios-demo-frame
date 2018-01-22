//
//  ShoppingCartHeaderCell.h
//  tbCart
//
//  Created by WangDongya on 2018/1/18.
//  Copyright © 2018年 wdy-test. All rights reserved.
//

#import <UIKit/UIKit.h>


@protocol ShoppingCartHeaderCellDelegate <NSObject>

// 点击buyer选择按钮回调
- (void)buyerSelected:(NSInteger)sectionIndex;
// 点击buyer编辑按钮的回调
- (void)buyerEditingSelected:(NSInteger)sectionIndex;

@end

@interface ShoppingCartHeaderCell : UITableViewHeaderFooterView

@property (nonatomic, assign) id<ShoppingCartHeaderCellDelegate> delegate;

@property (nonatomic, strong) UIButton *headerSelectedBtn;
@property (nonatomic, strong) UIImageView *buyerImageView;

@property (nonatomic, strong) UIView *buyerNameBackView;
@property (nonatomic, strong) UIButton *editSectionHeaderBtn;
@property (nonatomic, strong) UILabel *buyerNameLabel;
@property (nonatomic, assign) NSInteger sectionIndex;

@end

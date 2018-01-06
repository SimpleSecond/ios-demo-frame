//
//  WDGridLayoutView.m
//  ios-shanGeView
//
//  Created by WangDongya on 2017/12/26.
//  Copyright © 2017年 example. All rights reserved.
//

#import "WDGridLayoutView.h"
#import "WDBaseModel.h"
#import "WDItem.h"
#import <MJExtension/MJExtension.h>
#import <SDWebImage/UIImageView+WebCache.h>
#import <Masonry/Masonry.h>

@implementation WDGridLayoutView


#pragma mark - 类方法

+ (UIColor*) randomColor{
    NSInteger r = arc4random() % 255;
    NSInteger g = arc4random() % 255;
    NSInteger b = arc4random() % 255;
    return [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:1];
}

+ (CGFloat)getRowsTotalHeight:(WDBaseModel *)baseModel
{
    CGFloat height = 0;
    for (NSDictionary *dict in baseModel.images) {
        WDBaseModel *subModel = [WDBaseModel mj_objectWithKeyValues:dict];
        if (subModel.height) {
            height += subModel.height;
        }
    }
    return height;
}

+ (CGFloat)GridViewHeightWithJsonStr:(NSString *)jsonStr
{
    WDBaseModel *baseModel = [WDBaseModel mj_objectWithKeyValues:jsonStr];
    return [WDGridLayoutView getRowsTotalHeight:baseModel];
}

#pragma mark - 对象方法

-(void)setJsonStr:(NSString *)jsonStr
{
    WDBaseModel *baseModel = [WDBaseModel mj_objectWithKeyValues:jsonStr];
    WDLog(@"共有--%lu行", (unsigned long)baseModel.images.count);
    
    [WDGridLayoutView getRowsTotalHeight:baseModel];
    NSMutableArray *rows = [NSMutableArray array];
    for (NSDictionary *dict in baseModel.images) {
        WDBaseModel *base = [WDBaseModel mj_objectWithKeyValues:dict];
        if (base.height) {
            [rows addObject:base];
        }
    }
    [self setupRowsViewWithArr:rows];
}

#pragma mark 创建row
- (void)setupRowsViewWithArr:(NSMutableArray *)rows
{
    CGFloat rowH = 0;
    for (WDBaseModel *base in rows) {
        UIImageView *rowView = [[UIImageView alloc] init];
        rowView.backgroundColor = [WDGridLayoutView randomColor];
        [self addSubview:rowView];
        
        [rowView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.mas_top).with.offset(rowH);
            make.left.right.mas_equalTo(self);
            make.height.mas_equalTo(base.height);
        }];
        
        rowH += base.height;
        [self setupItemViewWithItemModel:[WDItem getItemWithModel:base] parentView:rowView];
    }
}

#pragma mark 创建item
- (void)setupItemViewWithItemModel:(WDItem *)item parentView:(UIImageView *)parentView
{
    parentView.userInteractionEnabled = YES;
    
    CGFloat totalWeight = 0;
    for (WDBaseModel *subBase in item.itemModels) {
        totalWeight += subBase.weight;
    }
    
    NSMutableArray *subViews = [NSMutableArray array];
    for (WDBaseModel *subBase in item.itemModels) {
        UIImageView *itemView = [[UIImageView alloc] init];
        itemView.backgroundColor = [WDGridLayoutView randomColor];
        [parentView addSubview:itemView];
        if ([item.orientation isEqualToString:@"h"]) {
            [itemView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.width.mas_equalTo(parentView).multipliedBy(subBase.weight / totalWeight);
                make.top.bottom.mas_equalTo(parentView);
            }];
        } else {
            [itemView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.height.mas_equalTo(parentView).multipliedBy(subBase.weight / totalWeight);
                make.left.right.mas_equalTo(parentView);
            }];
        }
        
        [subViews addObject:itemView];
        
        if (subBase.children) {
            [self setupItemViewWithItemModel:[WDItem getItemWithModel:subBase] parentView:itemView];
        }
        
        if (subBase.image) {  // 有image就显示，代表分割到底了
            itemView.userInteractionEnabled = YES;
            [itemView sd_setImageWithURL:[NSURL URLWithString:subBase.image]];
            
#warning 添加手势
            
        }
        
        itemView.layer.borderColor = [UIColor redColor].CGColor;
        itemView.layer.borderWidth = 0.5f;
        itemView.layer.masksToBounds = YES;
    }
    
    [item.orientation isEqualToString:@"h"] ? [parentView distributeSpacingHorizontalWith:subViews] : [parentView distributeSpacingVerticalWith:subViews];
}

@end

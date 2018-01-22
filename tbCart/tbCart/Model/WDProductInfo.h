//
//  WDProductInfo.h
//  tbCart
//
//  Created by WangDongya on 2018/1/18.
//  Copyright © 2018年 wdy-test. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WDProductInfo : NSObject

@property (nonatomic,assign) CGFloat cn_price;
@property (nonatomic,assign) NSInteger count;
@property (nonatomic,copy) NSString *image;
@property (nonatomic,assign) CGFloat order_price;
@property (nonatomic,assign) CGFloat price;
@property (nonatomic,copy) NSString *prod_id;
@property (nonatomic,copy) NSString *remark;
@property (nonatomic,copy) NSString *title;
@property (nonatomic,strong) NSArray *model_detail;

// 商品左侧按钮是否选中
@property (nonatomic,assign) BOOL productIsChoosed;

@end

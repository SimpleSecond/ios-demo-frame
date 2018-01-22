//
//  WDSingleProduct.h
//  tbCart
//
//  Created by WangDongya on 2018/1/18.
//  Copyright © 2018年 wdy-test. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WDSingleProduct : NSObject

@property (nonatomic,copy) NSString *img;
@property (nonatomic,copy) NSString * title;
@property (nonatomic,assign) CGFloat order_price;
@property (nonatomic,assign) CGFloat cn_price;
@property (nonatomic,copy) NSString *user_id;

@end

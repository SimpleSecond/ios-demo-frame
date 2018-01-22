//
//  WDRequestHelper.h
//  tbCart
//
//  Created by WangDongya on 2018/1/18.
//  Copyright © 2018年 wdy-test. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^requestHelperBlock)(id obj, NSError *error);

@interface WDRequestHelper : NSObject

+ (instancetype)sharedInstance;

- (void)requestShoppingCartInfo:(requestHelperBlock)block;

- (void)requestMoreRecommandInfo:(requestHelperBlock)block;

- (BOOL)isEmptyArray:(NSArray *)array;

- (NSAttributedString *)recombinePrice:(CGFloat)cnPrice orderPrice:(CGFloat)unitPrice;

@end

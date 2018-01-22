//
//  WDRequestHelper.m
//  tbCart
//
//  Created by WangDongya on 2018/1/18.
//  Copyright © 2018年 wdy-test. All rights reserved.
//

#import "WDRequestHelper.h"
#import "AllModels.h"
#import <MJExtension/MJExtension.h>

@implementation WDRequestHelper


static id _reqeustHelper;

+ (instancetype)sharedInstance
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _reqeustHelper = [[self alloc] init];
    });
    return _reqeustHelper;
}

+ (instancetype)allocWithZone:(struct _NSZone *)zone
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _reqeustHelper = [super allocWithZone:zone];
    });
    return _reqeustHelper;
}


- (void)requestShoppingCartInfo:(requestHelperBlock)block
{
    NSString *path = [[NSBundle mainBundle] pathForResource:@"shoppingCart" ofType:@"json"];
    NSString *shoppingStr = [NSString stringWithContentsOfFile:path encoding:NSUTF8StringEncoding error:nil];
    NSDictionary *shoppingDict = [shoppingStr mj_JSONObject];
    
    [WDBuyerInfo mj_setupObjectClassInArray:^NSDictionary *{
        return @{@"prod_list": @"WDProductInfo"};
    }];
    [WDProductInfo mj_setupObjectClassInArray:^NSDictionary *{
        return @{@"model_detail": @"WDModelDetail"};
    }];
    
    // 将获得的数组，通过block回调
    NSMutableArray *buyerList = [WDBuyerInfo mj_objectArrayWithKeyValuesArray:shoppingDict[@"buyers_data"]];
    block(buyerList, nil);
}

- (void)requestMoreRecommandInfo:(requestHelperBlock)block
{
    NSString *path = [[NSBundle mainBundle] pathForResource:@"moreRecommand" ofType:@"json"];
    NSString *relatedStr = [NSString stringWithContentsOfFile:path encoding:NSUTF8StringEncoding error:nil];
    NSDictionary *reatedDict = [relatedStr mj_JSONObject];
    
    [WDRelatedProducts mj_setupObjectClassInArray:^NSDictionary *{
        return @{@"list": @"WDSingleProduct"};
    }];
    
    WDRelatedProducts *products = [WDRelatedProducts mj_objectWithKeyValues:reatedDict];
    block(products.list, nil);
}

- (BOOL)isEmptyArray:(NSArray *)array
{
    return (array.count == 0 || array == nil);
}

- (NSAttributedString *)recombinePrice:(CGFloat)cnPrice orderPrice:(CGFloat)unitPrice
{
    NSMutableAttributedString *mutableAttributeStr = [[NSMutableAttributedString alloc] init];
    NSAttributedString *str1 = [[NSAttributedString alloc] initWithString:[NSString stringWithFormat:@"￥%.f", unitPrice] attributes:@{NSForegroundColorAttributeName: [UIColor redColor], NSFontAttributeName : [UIFont boldSystemFontOfSize:12]}];
    NSAttributedString *str2 = [[NSAttributedString alloc] initWithString:[NSString stringWithFormat:@"￥%.f", cnPrice] attributes:@{NSForegroundColorAttributeName: [UIColor lightGrayColor], NSFontAttributeName : [UIFont boldSystemFontOfSize:11], NSStrikethroughStyleAttributeName :@(NSUnderlineStyleSingle),NSStrikethroughColorAttributeName : [UIColor lightGrayColor]}];

    [mutableAttributeStr appendAttributedString:str1];
    [mutableAttributeStr appendAttributedString:str2];
    
    return mutableAttributeStr;
}


@end

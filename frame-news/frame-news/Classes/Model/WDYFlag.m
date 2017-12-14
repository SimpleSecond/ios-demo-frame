//
//  WDYFlag.m
//  frame-news
//
//  Created by WangDongya on 2017/12/2.
//  Copyright © 2017年 example. All rights reserved.
//

#import "WDYFlag.h"

@implementation WDYFlag


+ (instancetype)flagWithDictionary:(NSDictionary *)dict
{
    WDYFlag *flag = [[self alloc] init];
    [flag setValuesForKeysWithDictionary:dict];
    return flag;
}

@end

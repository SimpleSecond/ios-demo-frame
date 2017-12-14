//
//  WDYFlag.h
//  frame-news
//
//  Created by WangDongya on 2017/12/2.
//  Copyright © 2017年 example. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WDYFlag : NSObject

@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *icon;

+ (instancetype)flagWithDictionary:(NSDictionary *)dict;

@end

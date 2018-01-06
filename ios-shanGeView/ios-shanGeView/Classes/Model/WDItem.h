//
//  WDItem.h
//  ios-shanGeView
//
//  Created by WangDongya on 2017/12/26.
//  Copyright © 2017年 example. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MJExtension/MJExtension.h>
#import "WDBaseModel.h"

@interface WDItem : NSObject
@property (nonatomic, strong) NSMutableArray *itemModels;
@property (nonatomic, copy) NSString *orientation;


+ (WDItem *)getItemWithModel:(WDBaseModel *)base;

@end

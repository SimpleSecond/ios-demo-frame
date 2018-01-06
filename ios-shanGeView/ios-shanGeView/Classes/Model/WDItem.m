//
//  WDItem.m
//  ios-shanGeView
//
//  Created by WangDongya on 2017/12/26.
//  Copyright © 2017年 example. All rights reserved.
//

#import "WDItem.h"

@implementation WDItem


- (NSMutableArray *)itemModels
{
    if (!_itemModels) {
        _itemModels = [NSMutableArray array];
    }
    return _itemModels;
}


+ (WDItem *)getItemWithModel:(WDBaseModel *)base
{
    WDItem *item = [WDItem new];
    item.orientation = base.orientation;
    for (NSDictionary *dict in base.children) {
        WDBaseModel *subBase = [WDBaseModel mj_objectWithKeyValues:dict];
        [item.itemModels addObject:subBase];
    }
    return item;
}

@end

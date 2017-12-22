//
//  WDRecommendTag.h
//  frame-bsbdj
//
//  Created by WangDongya on 2017/12/21.
//  Copyright © 2017年 example. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WDRecommendTag : NSObject

// 名字
@property (nonatomic, copy) NSString *theme_name;
// 图片
@property (nonatomic, copy) NSString *image_list;
// 订阅数
@property (nonatomic, assign) NSInteger sub_number;

@end

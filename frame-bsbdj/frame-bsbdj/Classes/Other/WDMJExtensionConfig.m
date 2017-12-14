//
//  WDMJExtensionConfig.m
//  frame-bsbdj
//
//  Created by WangDongya on 2017/12/14.
//  Copyright © 2017年 example. All rights reserved.
//

#import "WDMJExtensionConfig.h"
#import <MJExtension/MJExtension.h>
#import "WDTopic.h"
#import "WDComment.h"

@implementation WDMJExtensionConfig

+(void)load
{
    [WDTopic mj_setupObjectClassInArray:^NSDictionary *{
        return @{@"top_cmt" : [WDComment class]};
    }];
    
    [WDTopic mj_setupReplacedKeyFromPropertyName:^NSDictionary *{
        return @{
                 @"top_cmt" : @"top_cmt[0]",
                 @"small_image" : @"image0",
                 @"middle_image" : @"image2",
                 @"large_image" : @"image1",
                 };
    }];
}

@end

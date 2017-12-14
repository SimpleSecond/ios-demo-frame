//
//  NSDate+WDExtension.h
//  frame-bsbdj
//
//  Created by WangDongya on 2017/12/11.
//  Copyright © 2017年 example. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDate (WDExtension)


// 是否为今年
- (BOOL)wd_isThisYear;
// 是否为今天
- (BOOL)wd_isToday;
// 是否为昨天
- (BOOL)wd_isYesterday;
// 是否为明天
- (BOOL)wd_isTomorrow;
@end

//
//  UIBarButtonItem+WDButtonItemExtension.h
//  frame-bsbdj
//
//  Created by WangDongya on 2017/12/5.
//  Copyright © 2017年 example. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIBarButtonItem (WDButtonItemExtension)
+ (UIBarButtonItem *)itemWithImage:(NSString *)image highImage:(NSString *)highImage target:(id)target action:(SEL)action;
@end

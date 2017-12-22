//
//  UIImage+WDExtension.h
//  frame-bsbdj
//
//  Created by WangDongya on 2017/12/16.
//  Copyright © 2017年 example. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (WDExtension)


/* 返回圆形图片 */
- (instancetype)wd_circleImage;
+ (instancetype)wd_circleImage:(NSString *)imageName;

@end

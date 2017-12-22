//
//  UIImage+WDExtension.m
//  frame-bsbdj
//
//  Created by WangDongya on 2017/12/16.
//  Copyright © 2017年 example. All rights reserved.
//

#import "UIImage+WDExtension.h"

@implementation UIImage (WDExtension)


/* 返回圆形图片 */
- (instancetype)wd_circleImage
{
    // 开启上下文
    UIGraphicsBeginImageContext(self.size);
    // 上下文
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    
    // 添加一个圆
    CGRect rect = CGRectMake(0, 0, self.size.width, self.size.height);
    CGContextAddEllipseInRect(ctx, rect);
    
    // 裁剪
    CGContextClip(ctx);
    
    // 绘制图片
    [self drawInRect:rect];
    
    // 获取图片
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    
    // 关闭上下文
    UIGraphicsEndImageContext();
    
    return image;
}
+ (instancetype)wd_circleImage:(NSString *)imageName
{
    return [[self imageNamed:imageName] wd_circleImage];
}

@end

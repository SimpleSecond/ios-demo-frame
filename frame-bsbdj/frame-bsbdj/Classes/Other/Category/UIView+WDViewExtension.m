//
//  UIView+WDViewExtension.m
//  frame-bsbdj
//
//  Created by WangDongya on 2017/12/5.
//  Copyright © 2017年 example. All rights reserved.
//

#import "UIView+WDViewExtension.h"

@implementation UIView (WDViewExtension)

-(CGFloat)wd_width
{
    return self.frame.size.width;
}
-(CGFloat)wd_height
{
    return self.frame.size.height;
}
-(void)setWd_width:(CGFloat)width
{
    CGRect frame = self.frame;
    frame.size.width = width;
    self.frame = frame;
}
-(void)setWd_height:(CGFloat)height
{
    CGRect frame = self.frame;
    frame.size.height = height;
    self.frame = frame;
}

-(CGFloat)wd_x
{
    return self.frame.origin.x;
}
-(void)setWd_x:(CGFloat)wd_x
{
    CGRect frame = self.frame;
    frame.origin.x = wd_x;
    self.frame = frame;
}
-(CGFloat)wd_y
{
    return self.frame.origin.y;
}
-(void)setWd_y:(CGFloat)wd_y
{
    CGRect frame = self.frame;
    frame.origin.y = wd_y;
    self.frame = frame;
}
-(CGFloat)wd_centerX
{
    return self.center.x;
}
-(void)setWd_centerX:(CGFloat)wd_centerX
{
    CGPoint center = self.center;
    center.x = wd_centerX;
    self.center = center;
}
-(CGFloat)wd_centerY
{
    return self.center.y;
}
-(void)setWd_centerY:(CGFloat)wd_centerY
{
    CGPoint center = self.center;
    center.y = wd_centerY;
    self.center = center;
}
-(CGSize)wd_size
{
    return self.frame.size;
}
-(void)setWd_size:(CGSize)wd_size
{
    CGRect frame = self.frame;
    frame.size = wd_size;
    self.frame = frame;
}
-(CGFloat)wd_bottom
{
    return self.frame.origin.y + self.frame.size.height;
}

+ (instancetype)viewFromXib
{
    return [[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self) owner:nil options:nil].lastObject;
}

- (BOOL)intersectWithView:(UIView *)view
{
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    CGRect selfRect = [self convertRect:self.bounds toView:window];
    CGRect viewRect = [view convertRect:view.bounds toView:window];
    
    return CGRectIntersectsRect(selfRect, viewRect);
}

@end

//
//  UIView+WDViewExtension.h
//  frame-bsbdj
//
//  Created by WangDongya on 2017/12/5.
//  Copyright © 2017年 example. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (WDViewExtension)
@property (nonatomic, assign) CGFloat wd_width;
@property (nonatomic, assign) CGFloat wd_height;
@property (nonatomic, assign) CGFloat wd_x;
@property (nonatomic, assign) CGFloat wd_y;
@property (nonatomic, assign) CGFloat wd_centerX;
@property (nonatomic, assign) CGFloat wd_centerY;
@property (nonatomic, assign) CGSize wd_size;

@property (nonatomic, assign) CGFloat wd_bottom;

// 通过与类名相同的xib文件获取视图
+ (instancetype)viewFromXib;

//
- (BOOL)intersectWithView:(UIView *)view;

@end

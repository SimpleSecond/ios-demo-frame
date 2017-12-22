//
//  UIImageView+WDExtension.m
//  frame-bsbdj
//
//  Created by WangDongya on 2017/12/21.
//  Copyright © 2017年 example. All rights reserved.
//

#import "UIImageView+WDExtension.h"
#import <SDWebImage/UIImageView+WebCache.h>

@implementation UIImageView (WDExtension)

-(void)wd_setupHeader:(NSString *)url
{
    [self setupCircleHeader:url];
}

// 设置头像图片为圆形
- (void)setupCircleHeader:(NSString *)url
{
    UIImage *placeholder = [UIImage wd_circleImage:@"defaultUserIcon"];
    [self sd_setImageWithURL:[NSURL URLWithString:url] placeholderImage:placeholder completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
        if (image == nil) return ;
        
        self.image = [image wd_circleImage];
    }];
}
// 设置头像图片为矩形
- (void)setupRectHeader:(NSString *)url
{
    UIImage *placeholder = [UIImage wd_circleImage:@"defaultUserIcon"];
    [self sd_setImageWithURL:[NSURL URLWithString:url] placeholderImage:placeholder];
}

@end

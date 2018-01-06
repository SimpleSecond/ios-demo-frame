//
//  MBProgressHUD+WDExtension.m
//  mvvm-demo
//
//  Created by WangDongya on 2018/1/5.
//  Copyright © 2018年 example. All rights reserved.
//

#import "MBProgressHUD+WDExtension.h"

@implementation MBProgressHUD (WDExtension)

+ (MBProgressHUD *)sharedInstance
{
    static MBProgressHUD *progress = nil;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        progress = [MBProgressHUD showHUDAddedTo:[UIApplication sharedApplication].keyWindow animated:YES];
        progress.mode = MBProgressHUDModeAnnularDeterminate;
    });
    
    return progress;
}

+ (void)showMessage:(NSString *)msg
{
    MBProgressHUD *progress = [MBProgressHUD showHUDAddedTo:[UIApplication sharedApplication].keyWindow animated:YES];
    progress.mode = MBProgressHUDModeAnnularDeterminate;
    progress.label.text = @"Loading...";
    
    //[progress showAnimated:YES];
}

+ (void)hide
{
    [MBProgressHUD hideHUDForView:[UIApplication sharedApplication].keyWindow animated:YES];
}

@end

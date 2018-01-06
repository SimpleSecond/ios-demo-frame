//
//  MBProgressHUD+WDExtension.h
//  mvvm-demo
//
//  Created by WangDongya on 2018/1/5.
//  Copyright © 2018年 example. All rights reserved.
//

#import <MBProgressHUD/MBProgressHUD.h>

@interface MBProgressHUD (WDExtension)

+ (void)showMessage:(NSString *)msg;
+ (void)hide;

@end

//
//  WDConst.m
//  frame-bsbdj
//
//  Created by WangDongya on 2017/12/21.
//  Copyright © 2017年 example. All rights reserved.
//

#import <UIKit/UIKit.h>

/* 通用的间距值 */
CGFloat const WDMargin = 10;
/* 通用的小间距值 */
CGFloat const WDMarginSmall = WDMargin * 0.5;

/* 公共URL */
NSString * const WDCommonURL = @"http://api.budejie.com/api/api_open.php";


/* WDUser - sex - male */
NSString * const WDUserSexMale = @"m";
/* WDUser - sex - female */
NSString * const WDUserSexFeale = @"f";


/* 通知 */
/* TabBar按钮被重复点击的通知 */
NSString * const WDTabBarDidRepeatClickNotification = @"WDTabBarDidRepeatClickNotification";
/* 标题按钮被重复点击的通知 */
NSString * const WDTitleButtonDidRepeatClickNotification = @"WDTitleButtonDidRepeatClickNotification";

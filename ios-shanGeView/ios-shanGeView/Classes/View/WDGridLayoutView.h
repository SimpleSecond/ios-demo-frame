//
//  WDGridLayoutView.h
//  ios-shanGeView
//
//  Created by WangDongya on 2017/12/26.
//  Copyright © 2017年 example. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WDGridLayoutView : UIView

@property (nonatomic, strong) NSString *jsonStr;


+ (CGFloat)GridViewHeightWithJsonStr:(NSString *)jsonStr;


@end

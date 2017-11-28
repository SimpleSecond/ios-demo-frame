//
//  WDYTabBarContentView.h
//  frame-news
//
//  Created by WangDongya on 2017/11/28.
//  Copyright © 2017年 example. All rights reserved.
//

#import <UIKit/UIKit.h>

@class WDYTabBarContentView;

// 该视图用到的协议
@protocol WDYTabBarContentViewDelegate <NSObject>
- (void)contentView:(WDYTabBarContentView*)view didSelectedItemAtIndex:(NSInteger)index;
- (void)contentViewClickCenterItem:(WDYTabBarContentView*)view;
@end

@interface WDYTabBarContentView : UIView

@property (nonatomic, weak) id<WDYTabBarContentViewDelegate> contentDelegate;

@end

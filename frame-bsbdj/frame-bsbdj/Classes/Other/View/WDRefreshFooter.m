//
//  WDRefreshFooter.m
//  frame-bsbdj
//
//  Created by WangDongya on 2017/12/9.
//  Copyright © 2017年 example. All rights reserved.
//

#import "WDRefreshFooter.h"

@implementation WDRefreshFooter

-(void)prepare
{
    [super prepare];
    // 设置
    [self setTitle:@"上拉刷新" forState:MJRefreshStateIdle];
    [self setTitle:@"加载数据..." forState:MJRefreshStateRefreshing];
    //
    self.automaticallyChangeAlpha = YES;
    self.stateLabel.textColor = [UIColor redColor];
    
    // 上拉刷新控件的30%部分时，就触发自动刷新
    // self.triggerAutomaticallyRefreshPercent = 0.3;
    // 关闭自动刷新；需要点击和狠拉上去后，才会刷新
    // self.automaticallyRefresh = NO;
}

@end

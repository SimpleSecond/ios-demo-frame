//
//  WDRefreshHeader.m
//  frame-bsbdj
//
//  Created by WangDongya on 2017/12/9.
//  Copyright © 2017年 example. All rights reserved.
//

#import "WDRefreshHeader.h"


@interface WDRefreshHeader ()
@property (nonatomic, weak) UIImageView *logo;
@end
@implementation WDRefreshHeader

-(void)prepare
{
    [super prepare];
    
    self.automaticallyChangeAlpha = YES;
    self.lastUpdatedTimeLabel.textColor = [UIColor redColor];
    self.stateLabel.textColor = [UIColor greenColor];
    [self setTitle:@"下拉触发刷新" forState:MJRefreshStateIdle];
    [self setTitle:@"松开执行刷新" forState:MJRefreshStatePulling];
    [self setTitle:@"加载数据中..." forState:MJRefreshStateRefreshing];
    
    UIImageView *logo = [[UIImageView alloc] init];
    logo.image = [UIImage imageNamed:@"bd_logo1"];
    logo.contentMode = UIViewContentModeScaleAspectFit;
    self.logo = logo;
    [self addSubview:self.logo];
}

-(void)placeSubviews
{
    [super placeSubviews];
    
    self.logo.wd_x = 0;
    self.logo.wd_y = -100;
    self.logo.wd_width = self.wd_width;
    self.logo.wd_height = 100;
    
}

@end

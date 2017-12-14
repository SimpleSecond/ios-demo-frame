//
//  WDYRedView.m
//  frame-news
//
//  Created by WangDongya on 2017/12/2.
//  Copyright © 2017年 example. All rights reserved.
//

#import "WDYRedView.h"

@implementation WDYRedView

- (RACSubject *)signalSubject
{
    if (_signalSubject == nil) {
        _signalSubject = [RACSubject subject];
    }
    return _signalSubject;
}

- (void)clickView:(UITapGestureRecognizer *)gesture
{
    [self.signalSubject sendNext:@"点击了View视图"];
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    [self setBackgroundColor:[UIColor redColor]];
    [self setUserInteractionEnabled:YES];
    [self addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickView:)]];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end

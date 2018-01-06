//
//  WDNavigationViewController.m
//  rongyun-demo
//
//  Created by WangDongya on 2018/1/4.
//  Copyright © 2018年 example. All rights reserved.
//

#import "WDNavigationViewController.h"

@interface WDNavigationViewController ()

@end

@implementation WDNavigationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //[[UINavigationBar appearance] setTintColor:[UIColor lightGrayColor]];
    [[UINavigationBar appearance] setBarTintColor:[UIColor redColor]];
    [[UINavigationBar appearance] setTitleTextAttributes:@{NSForegroundColorAttributeName: [UIColor blueColor]}];
}

@end

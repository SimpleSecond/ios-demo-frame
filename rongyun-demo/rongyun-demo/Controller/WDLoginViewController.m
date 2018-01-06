//
//  WDLoginViewController.m
//  rongyun-demo
//
//  Created by WangDongya on 2018/1/4.
//  Copyright © 2018年 example. All rights reserved.
//

#import "WDLoginViewController.h"

#import <Masonry/Masonry.h>
#import <RongIMKit/RongIMKit.h>



@interface WDLoginViewController ()

@property (nonatomic, strong) UIButton *name1Login;
@property (nonatomic, strong) UIButton *name2Login;

@end

@implementation WDLoginViewController

- (UIButton *)name1Login
{
    if (!_name1Login) {
        _name1Login = [UIButton buttonWithType:UIButtonTypeCustom];
        _name1Login.backgroundColor = [UIColor blueColor];
        [_name1Login setTitle:@"name1" forState:UIControlStateNormal];
        [_name1Login addTarget:self action:@selector(name1Click:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _name1Login;
}

- (UIButton *)name2Login
{
    if (!_name2Login) {
        _name2Login = [UIButton buttonWithType:UIButtonTypeCustom];
        _name2Login.backgroundColor = [UIColor blueColor];
        [_name2Login setTitle:@"name2" forState:UIControlStateNormal];
        [_name2Login addTarget:self action:@selector(name2Click:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _name2Login;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view setBackgroundColor:[UIColor whiteColor]];
    
    [self.view addSubview:self.name1Login];
    [self.view addSubview:self.name2Login];
    
    [self.name1Login mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.view.mas_centerY);
        make.left.equalTo(self.view.mas_left).offset(10);
        make.right.equalTo(self.name2Login.mas_left).offset(-5);
        
        make.width.equalTo(self.name2Login);
        make.height.mas_equalTo(45);
    }];
    
    [self.name2Login mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.name1Login.mas_top);
        make.bottom.equalTo(self.name1Login.mas_bottom);
        
        make.right.equalTo(self.view.mas_right).offset(-10);
        //make.left.equalTo(self.name1Login.mas_right).offset(5);
        
        make.width.equalTo(self.name1Login);
        make.height.equalTo(self.name1Login);
    }];
    
}

- (void)name1Click:(UIButton*)sender
{
    [self connectWithToken:@"vvoPT7TF4H27uFYoxi/1iEV/jmMsSSQZo4x8dBfVD2PQgOkjTEEDiY3S9STo024PXGf3CMd+eehrmu7Jc6k0fg==" sender:sender];
}

- (void)name2Click:(UIButton*)sender
{
    [self connectWithToken:@"ulMEJRzPjVIH+DCIZqipmEV/jmMsSSQZo4x8dBfVD2PQgOkjTEEDiZySHkLoNpH4XGf3CMd+eeh79dE6/T+s/Q==" sender:sender];
}

- (void)connectWithToken:(NSString *)token sender:(UIButton *)sender
{
    sender.enabled = NO;
    [[RCIM sharedRCIM] connectWithToken:token success:^(NSString *userId) {
        [self resetSender:sender];
        [self loginSuccess:token];
    } error:^(RCConnectErrorCode status) {
        [self resetSender:sender];
        if (status == RC_CONNECTION_EXIST) {
            [self loginSuccess:token];
        } else {
            NSLog(@"Error RCConnectErrorCode %ld", (long)status);
        }
    } tokenIncorrect:^{
        [self resetSender:sender];
        NSLog(@"Error tokenIncorrect");
    }];
}

- (void)resetSender:(UIButton *)sender
{
    dispatch_async(dispatch_get_main_queue(), ^{
        sender.enabled = YES;
    });
}

- (void)loginSuccess:(NSString *)token
{
    [[NSUserDefaults standardUserDefaults] setObject:token forKey:@"com.rongcloud.token"];
    
    dispatch_async(dispatch_get_main_queue(), ^{
        [self dismissViewControllerAnimated:YES completion:nil];
    });
}


@end

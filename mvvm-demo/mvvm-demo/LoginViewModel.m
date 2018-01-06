//
//  LoginViewModel.m
//  mvvm-demo
//
//  Created by WangDongya on 2018/1/5.
//  Copyright © 2018年 example. All rights reserved.
//

#import "LoginViewModel.h"

#import "MBProgressHUD+WDExtension.h"

#import <AFNetworking/AFNetworking.h>

@implementation LoginViewModel

-(instancetype)init
{
    if (self = [super init]) {
        [self setup];
    }
    return self;
}


- (void)setup
{
    _loginEnableSignal = [RACSignal combineLatest:@[RACObserve(self, username), RACObserve(self, password)] reduce:^id(NSString *account, NSString *pwd) {
        return @(account.length && pwd.length);
    }];
    
    // 2. 处理登录命令
    _loginCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal * _Nonnull(id  _Nullable input) {
        // block : 执行命令就会调用
        // block作用: 事件处理
        // 发送登录请求
        NSLog(@"发送登录请求");
        RACSignal *tempSignal = [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
            
            AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
            NSMutableDictionary *params = [NSMutableDictionary dictionary];
            params[@"q"] = @"傲慢与偏见";
            
            [manager GET:@"https://api.douban.com/v2/book/search" parameters:params progress:^(NSProgress * _Nonnull downloadProgress) {
                NSLog(@"下载过程时，才会回调该方法！");
            } success:^(NSURLSessionDataTask * _Nonnull task, NSDictionary * responseObject) {
                // 发送数据
                [responseObject writeToFile:@"/Users/wangdongya/Desktop/douban.plist" atomically:YES];
                [subscriber sendNext:responseObject[@"books"]];
                [subscriber sendCompleted];
            } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                NSLog(@"failure");
                // 发送数据
                [subscriber sendNext:@"ERROR"];
                [subscriber sendCompleted];
            }];
            
            
            
            
//            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//                // 发送数据
//                [subscriber sendNext:@"请求登录的数据"];
//                [subscriber sendCompleted];
//            });
            
            
            return nil;
        }];
        
        // 返回信号
        return tempSignal;
    }];
    
    // 3. 处理登录请求返回的结果
    // 获取命令中信号源
    //    [_loginCommand.executionSignals.switchToLatest subscribeNext:^(id  _Nullable x) {
    //        NSLog(@"%@", x);
    //    }];
    
    // 4. 处理登录执行过程
    [[_loginCommand.executing skip:1] subscribeNext:^(NSNumber * _Nullable x) {
        if ([x boolValue] == YES) {
            // 正在执行
            NSLog(@"正在执行");
            // 显示蒙版
            [MBProgressHUD showMessage:@""];
        } else {
            // 执行完成
            NSLog(@"执行完成");
            [MBProgressHUD hide];
        }
    }];
    
}


@end

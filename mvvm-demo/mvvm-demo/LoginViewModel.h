//
//  LoginViewModel.h
//  mvvm-demo
//
//  Created by WangDongya on 2018/1/5.
//  Copyright © 2018年 example. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <ReactiveObjC/ReactiveObjC.h>

@interface LoginViewModel : NSObject

@property (nonatomic, strong) NSString *username;
@property (nonatomic, strong) NSString *password;

// 处理按钮能否点击
@property (nonatomic, strong, readonly) RACSignal *loginEnableSignal;  // 信号


// 登录命令
@property (nonatomic, strong, readonly) RACCommand *loginCommand;

@end

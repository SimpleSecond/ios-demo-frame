//
//  LoginViewController.m
//  mvvm-demo
//
//  Created by WangDongya on 2018/1/5.
//  Copyright © 2018年 example. All rights reserved.
//

#import "LoginViewController.h"
#import "LoginViewModel.h"

@interface LoginViewController ()
@property (weak, nonatomic) IBOutlet UITextField *username;
@property (weak, nonatomic) IBOutlet UITextField *password;
@property (weak, nonatomic) IBOutlet UIButton *loginBtn;

@property (nonatomic, strong) LoginViewModel *loginVM;

@end

@implementation LoginViewController

- (LoginViewModel *)loginVM
{
    if (!_loginVM) {
        _loginVM = [[LoginViewModel alloc] init];
    }
    return _loginVM;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // MVVM : 先创建VM模型，吧整个界面的一些业务逻辑处理完成
    // 回到控制器去执行
    
    //
    [self bindViewModel];
    //
    [self loginEvent];
}

// 绑定ViewModel
- (void)bindViewModel
{
    // 1. 绑定信号
    RAC(self.loginVM, username) = self.username.rac_textSignal;
    RAC(self.loginVM, password) = self.password.rac_textSignal;
}

// 处理业务逻辑(事件)
- (void)loginEvent
{
    // 1. 设置按钮能否点击
    RAC(self.loginBtn, enabled) = self.loginVM.loginEnableSignal;
    
    // 2. 监听登录按钮点击
    [[self.loginBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
        // 处理登录事件
        [[self.loginVM.loginCommand execute:nil] subscribeNext:^(id  _Nullable x) {
            
            NSLog(@"处理结果是 : %@", x);
            
        }];
    }];
}



- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
}

@end

//
//  WDYTopController.m
//  frame-news
//
//  Created by WangDongya on 2017/11/29.
//  Copyright © 2017年 example. All rights reserved.
//

#import "WDYTopController.h"
#import "RACReturnSignal.h"
#import "WDYRedView.h"
#import "WDYFlag.h"



@interface WDYTopController ()

@end

@implementation WDYTopController


- (void)updateUI:(NSString *)value1 :(NSString*)value2
{
    NSLog(@"%@, %@", value1, value2);
    NSLog(@"更新界面");
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view setBackgroundColor:[[UIColor darkGrayColor] colorWithAlphaComponent:0.1]];
    
    
    
//    RACSubject *signalA = [RACSubject subject];
//    RACSubject *signalB = [RACSubject subject];
//    // 组合信号
//    RACSignal *mergeSignal = [signalA zipWith:signalB];
//    // 订阅
//    [mergeSignal subscribeNext:^(id  _Nullable x) {
//        NSLog(@"%@", x);
//    }];
//    [signalA sendNext:@"A"];
//    [signalB sendNext:@"B"];
    
    
    // RAC方法过滤
    // filter (过滤)
    // ignore (忽略)
    // take: 从开始一共获取N次的信号
    // takeLast: 取最后N次的信号。
    // 前提条件：订阅者必须调用完成，因为只有完成，才知道总共有多少信号
    // takeUntil:(RACSignal*) 只要传入的信号发送完成或者发送任意数据，就不会再接收源信号内容。
    // distinctUntilChanged:如果当前的值跟上一个值相同，就不会被订阅到
    // skip: 跳过几个值
    
    RACSubject *subject = [RACSubject subject];
    [[subject skip:2] subscribeNext:^(id  _Nullable x) {
        NSLog(@"%@", x);
    }];
    [subject sendNext:@"1"];
    [subject sendNext:@"1"];
    [subject sendNext:@"3"];
    
    
    
//    UITextField *_textField = [[UITextField alloc] initWithFrame:CGRectMake(100, 100, 100, 45)];
//    [self.view addSubview:_textField];
    
    
//    // ignore:忽略一些值
//    // ignoreValues忽略所有值
//    // 1. 创建信号
//    RACSubject *subject = [RACSubject subject];
//    // 2. 忽略一些值
//    // RACSignal *ignoreSignal = [subject ignore:@"1"];
//    RACSignal *ignoreSignal = [subject ignoreValues];
//    // 3. 订阅ignoreSignal
//    [ignoreSignal subscribeNext:^(id  _Nullable x) {
//        NSLog(@"%@", x);
//    }];
//    // 4. 发送数据
//    [subject sendNext:@"1"];
//    [subject sendNext:@"2"];
//    [subject sendNext:@"3"];
    
//    // 过滤一、只有文本框内容长度大于5时，才能获取文本框的内容
//    [[_textField.rac_textSignal filter:^BOOL(NSString * _Nullable value) {
//        // 返回值就是过滤条件，只有满足条件才能够获取内容
//        return (value.length > 5);
//    }] subscribeNext:^(NSString * _Nullable x) {
//        NSLog(@"%@", x);
//    }];
    
    
    
    // RAC中信号的组合
    // concat
    // then (忽略掉第一个信号的返回值，只取后一个信号的返回值)
    // merge (任意一个信号发送内容都会执行订阅信号的block)
    // zipWith (把两个信号压缩成一个信号。只有当两个信号同时发出信号内容时，并且把两个信号的内容合并成一个元组，才会触发压缩流的next事件)
    // combineLatest (将多个信号合并起来，并且拿到各个信号的最新值，必须每个合并的signal至少都有过一次sendNext，才会触发合并的信号。)
    // reduce (聚合：用于信号发出的内容时元组，把信号发出元组的值聚合成一个值)
    // combineLatest 与 reduce 联合使用
    
//    // 创建组合信号
    // reduceBlock参数：跟组合的信号有关，且一一对应
//    RACSignal *combineSignal = [RACSignal combineLatest:@[_pwdFiled.rac_textSignal, _accountField.rac_textSignal] reduce:^id (NSString *pwd, NSString *account){
//        // block：只要源信号发送内容就会调用，组合成一个新值
//        // 聚合的值就是组合信号的内容
//        NSLog(@"%@   %@", account, pwd);
//        return @(account.length && pwd.length);
//    }];
//    // 订阅信号
//    [combineSignal subscribeNext:^(id  _Nullable x) {
//        _loginBtn.enabled = [x boolValue];
//    }];
//    RAC(_loginBtn, enabled) = combineSignal;
}


// RACSubscriber：表示订阅者，用于发送信号，这是一个协议，不是一个类，只要遵守该协议，并实现相应方法才能成为订阅者。通过create创建信号，都有一个订阅者，帮助它发送数据。

// RACDisposable：用于取消订阅或者清理资源，当信号发送完成或者发送错误时，就会自动触发。
// 使用场景：不想监听某个信号时，可以通过它主动取消订阅信号。

// RACSubject：信号提供者，自己可以充当信号,又能发送信号。
// 使用场景：通常用来代替代理。

// RACReplaySubjet：重复提供信号类，(RACSubject子类)。
// RACReplaySubject与RACSubject的区别：RACReplaySubject可以先发送信号，再订阅信号；RACSubject就不可以。
// 使用场景一：如果一个信号每被订阅一次，就需要把之前的值重复发送一遍，使用重复提供信号类。
// 使用场景二：可以设置capacity数量来限制缓存的value的数量，即只缓存最新的几个值。



// ReactiveCocoa开发中常见用法
// 1. 代替代理：rac_signalForSelector:(用于替代代理)
// 2. 代替KVO：rac_valuesAndChangesForKeyPath:(用于监听某个对象的属性变化)
// 3. 监听事件：rac_signalForControlEvents:(用于监听某个事件)
// 4. 代替通知：rac_addObserverForName:(用于监听某个通知)
// 5. 监听文本框文字改变：rac_textSignal:(只用于文本框内容改变时，发出该信号)
// 6. 处理界面有多次请求时，需要都获取到数据时，才能展示界面：
//    rac_liftSelector:withSignalsFromArray:Signals:当传入Signals(信号数组)，每个signal都至少sendNext过一场，就会触发第一个selector参数方法。
//    使用注意：几个信号，参数一的方法就有几个参数，每个参数对应一个信号发出的数据。



// RACTuple：元组类，类似NSArray，用来包装值
// RACSequence：RAC中的集合类，用于代替NSArray，NSDictionary，可以用来快速遍历数组和字典。







- (void)mapMethod
{
    // 创建信号
    RACSubject *subject = [RACSubject subject];
    // 绑定信号
    RACSignal *bindSignal = [subject map:^id _Nullable(id  _Nullable value) {
        // 获取的数据，value
        // NSLog(@"--> %@", value);
        // 返回的类型，就是你需要映射的值
        return [NSString stringWithFormat:@"key:%@", value];
    }];
    // 订阅绑定信号
    [bindSignal subscribeNext:^(id  _Nullable x) {
        NSLog(@"%@", x);
    }];
    // 发送
    [subject sendNext:@"321"];
    [subject sendNext:@"555"];
    [subject sendNext:@"999"];
}

- (void)flattenMap
{
    // 创建信号
    RACSubject *signal = [RACSubject subject];
    
    // 绑定信号
    RACSignal *bindSignal = [signal flattenMap:^__kindof RACSignal * _Nullable(id  _Nullable value) {
        
        NSString *didValue = [NSString stringWithFormat:@"key:%@", value];
        return [RACReturnSignal return:didValue];
    }];
    
    // 订阅信号
    [bindSignal subscribeNext:^(id  _Nullable x) {
        NSLog(@"订阅绑定数据：%@", x);
    }];
    
    // 发送数据
    [signal sendNext:@"value"];
}

- (void)bindMethod
{
    // 绑定
    
    // 1. 创建信号
    RACSubject *subject = [RACSubject subject];
    
    // 2. 绑定信号
    RACSignal *bindSignal = [subject bind:^RACSignalBindBlock _Nonnull{
        return  ^RACSignal *(id _Nullable value, BOOL *stop){
            
            // block调用：只要源信号发送数据，就会调用
            // 作用：处理源信号内容
            // value：源信号发送的内容
            NSLog(@"接收到源信号的内容：%@", value);
            
            return [RACReturnSignal return:value];
        };
    }];
    
    // 3. 订阅绑定信号
    [bindSignal subscribeNext:^(id  _Nullable x) {
        NSLog(@">  %@  <", x);
    }];
    
    // 4. 源信号发送数据
    [subject sendNext:@"123"];
}

- (void)switchToLatest
{
    // switchToLatest
    
    // 创建信号中信号
    RACSubject *signalOfSignals = [RACSubject subject];
    RACSubject *signal = [RACSubject subject];
    
    // 订阅者
    //    [signalOfSignals subscribeNext:^(id  _Nullable x) {
    //        [x subscribeNext:^(id  _Nullable x) {
    //            NSLog(@"%@", x);
    //        }];
    //    }];
    // switchToLatest 信号中的信号发送的最新信号
    [signalOfSignals.switchToLatest subscribeNext:^(id  _Nullable x) {
        NSLog(@"%@", x);
    }];
    
    // 发送信号
    [signalOfSignals sendNext:signal];
    [signal sendNext:@1];
}

- (void)racCommand
{
    // RACCommand 处理事件
    // RACCommand 不能反悔一个空的信号
    // RACCommand 当命令内部发送数据完成，一定要主动发送完成
    
    // 1. 创建命令
    RACCommand *command = [[RACCommand alloc] initWithSignalBlock:^RACSignal * _Nonnull(id  _Nullable input) {
        // input 为执行命令传入的参数
        // 该block为执行命令时调用
        NSLog(@"input : %@", input);
        return [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
            // 发送数据
            [subscriber sendNext:@"执行完命令后，反馈的数据"];
            // * 发送完成
            [subscriber sendCompleted];
            return nil;
        }];
    }];
    
    // 如果拿到执行命令中产生的数据
    // 订阅命令内部的信号
    // 第一种方式：
    // 2. 执行命令
//    RACSignal *signal = [command execute:@5];
//    [signal subscribeNext:^(id  _Nullable x) {
//        NSLog(@"%@", x);
//    }];
    
    // 第二种方式：(注意，必须在执行命令前订阅)
    // 订阅信号
    //executionSignals：信号源，信号中信号，发送数据就是信号
//        [command.executionSignals subscribeNext:^(id  _Nullable x) {
//            NSLog(@"%@", x);
//            [x subscribeNext:^(id  _Nullable x) {
//                NSLog(@"%@", x);
//            }];
//        }];
     //switchToLatest 获取最新发送的信号，只能用于信号中信号
    [command.executionSignals.switchToLatest subscribeNext:^(id  _Nullable x) {
        NSLog(@"%@", x);
    }];
    
//    // 监听事件有没有执行完成
    [command.executing subscribeNext:^(NSNumber * _Nullable x) {

        if ([x boolValue] == YES) {
            NSLog(@"当前正在执行");
        } else {
            // 执行完成/没有执行
            NSLog(@"执行完成/没有执行");
        }
    }];
    // 2. 执行命令
    [command execute:@1];
}

- (void)multiConnect
{
    // RACMulticastConnection
    // 用于当一个信号，被多次订阅时，为了保证创建信号时，避免多次调用创建信号中的block，造成副作用，可以使用该类处理
    // 使用步骤：
    // 1. 创建信息
    // 2. 将信号转换成连接类
    // 3. 订阅连接类的信号
    // 4. 连接
    
    // 1. 创建信号
    RACSignal *signal = [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
        NSLog(@"发送热门模块请求");
        [subscriber sendNext:@1];
        return nil;
    }];
    // 2. 把信号转换成连接类
    // 确定源信号的订阅者RACSubject
    //    RACMulticastConnection *signalConn = [signal publish];
    RACMulticastConnection *signalConn = [signal multicast:[RACReplaySubject subject]];
    // 3.
    [signalConn.signal subscribeNext:^(id  _Nullable x) {
        NSLog(@"订阅1 : %@", x);
    }];
    [signalConn.signal subscribeNext:^(id  _Nullable x) {
        NSLog(@"订阅2 : %@", x);
    }];
    [signalConn.signal subscribeNext:^(id  _Nullable x) {
        NSLog(@"订阅3 : %@", x);
    }];
    // 4. 连接（）
    [signalConn connect];
}

- (void)requestBug
{
    // RACSignal
    // 1. 创建信号
    RACSignal *signal = [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
        NSLog(@"发送热门模块请求");
        [subscriber sendNext:@1];
        return nil;
    }];
    // 2.订阅信号
    [signal subscribeNext:^(id  _Nullable x) {
        NSLog(@"订阅1 : %@", x);
    }];
    [signal subscribeNext:^(id  _Nullable x) {
        NSLog(@"订阅2 : %@", x);
    }];

}

@end

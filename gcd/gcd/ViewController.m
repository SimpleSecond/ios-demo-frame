//
//  ViewController.m
//  gcd
//
//  Created by WangDongya on 2018/2/2.
//  Copyright © 2018年 wdy-test. All rights reserved.
//

#import "ViewController.h"


#pragma mark - NSDate 转 dispatch_time_t
dispatch_time_t getDispatchTimeByDate(NSDate *date)
{
    NSTimeInterval interval;
    double second, subsecond;
    struct timespec time;
    dispatch_time_t milestone;
    
    interval = [date timeIntervalSince1970];
    subsecond = modf(interval, &second);
    time.tv_sec = second;
    time.tv_nsec = subsecond * NSEC_PER_SEC;
    milestone = dispatch_walltime(&time, 0);
    
    return milestone;
}



@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    // 测试Serial（线性执行）
    //[self serialDispatchQueue];
    // 测试Concurrent（并行执行）
    //[self concurrentDispatchQueue];
    
    
    // 两个系统序列
    //[self systemDispatchQueue];
    
    
    // 变更执行优先级
    //[self setTargetQueue];
    
    
    // 3秒后执行
    //[self dispatchAfter];
    
    
    // dispatch group
    //[self dispatchGroup];
    
    
    // Barrier
    //[self barrierTest];
    
    
    // dispatch_apply
    //[self dispatchApplyTest];
    
    
    // 排他控制Semaphore
    //[self semaphoreTest];
    
    
}

#pragma mark - Dispatch I/O  与  Dispatch Data
// 难度系数大，暂不考虑
//// 读取较大文件时，将文件分成合适的大小使用Dispatch Queue并行读取。
//- (void)dispatchIO
//{
//    dispatch_queue_t pipe_q = dispatch_queue_create("com.wdy-test.gcd.io", NULL);
//    dispatch_fd_t fd ;
//    dispatch_io_t pipe_channel = dispatch_io_create(DISPATCH_IO_STREAM, fd, pipe_q, ^(int error) {
//        close(fd);
//    });
//
//
//}



#pragma mark - dispatch_once
// 该函数是保证在应用程序执行中只执行一次指定处理的API。



#pragma mark - Dispatch Semaphore
// Serial Dispatch Queue 和 dispatch_barrier_async 之外的，更细粒度的排他控制。

// 使用Global Dispatch Queue更细NSMutableArray类对象，导致应用程序异常结束的概率非常高。
// 此时，应使用Dispatch Semaphore
// Dispatch Semaphore 是持有计数的信号，计数为0时等待，计数为1或大于1时，减去1而不等待。
// dispatch_semaphore_wait函数等待Dispatch Semaphore的计算值达到大于或等于1.

- (void)semaphoreTest
{
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    
    dispatch_semaphore_t semaphore = dispatch_semaphore_create(1);
    NSMutableArray *array = [NSMutableArray array];
    for (int i=0; i<1000; i++) {
        dispatch_async(queue, ^{
            
            // 等待Dispatch Semaphore
            // 一直等待，直到Dispatch Semaphore的计算值达到大于或等于1
            dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER);
            
            // 这里NSMutableArray类对象可以安全的进行更新
            [array addObject:[NSNumber numberWithInt:i]];
            
            NSLog(@"%zd", [array count]);
            
            // 排他控制处理结束
            dispatch_semaphore_signal(semaphore);
            
        });
    }
    
}




#pragma mark - dispatch_suspend / dispatch_resume
// dispatch_suspend 挂起指定的Dispatch Queue
// dispatch_resume  恢复指定的Dispatch Queue




#pragma mark - dispatch_apply
- (void)dispatchApplyTest
{
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
//    dispatch_apply(10, queue, ^(size_t index) {
//        NSLog(@"%zu", index);
//    });
//
//    // “Done”必定在最后显示：dispatch_apply函数会等待全部处理执行结束
//    NSLog(@"Done");
    
    // 注意：
    // dispatch_apply函数与dispatch_sync函数相同，会等待处理执行结束。
    // 因此推荐在dispatch_async函数中非同步执行dispatch_apply函数
    
    dispatch_async(queue, ^{
        
        // 等待dispatch_apply函数中全部执行结束
        dispatch_apply(10, queue, ^(size_t index) {
            NSLog(@"%zu", index);
        });
        
        // dispatch_apply 函数执行结束
        
        // Main Dispatch Queue中非同步执行
        dispatch_async(dispatch_get_main_queue(), ^{
            NSLog(@"Done");
        });
    });
}


#pragma mark - dispatch_sync
- (void)syncTest
{
    
}



#pragma mark - dispatch_barrier_async
// 读取处理追加到Concurrent Dispatch Queue中，
// 写入处理在任一个读取处理没有执行的状态下，追加到Serial Dispatch Queue中即可（在写入处理结束前，读取处理不可执行）。
- (void)barrierTest
{
    dispatch_queue_t queue = dispatch_queue_create("com.wdy-test.gcd.barrier", DISPATCH_QUEUE_CONCURRENT);
    
    dispatch_async(queue, ^{ NSLog(@"读取 - 1"); });
    dispatch_async(queue, ^{ NSLog(@"读取 - 2"); });
    dispatch_async(queue, ^{ NSLog(@"读取 - 3"); });
    
    // 写入处理
    dispatch_barrier_async(queue, ^{
        NSLog(@"写入中 ... ");
    });
    
    // 将写入的内容读取之后的处理中
    dispatch_async(queue, ^{ NSLog(@"读取 - 4"); });
    dispatch_async(queue, ^{ NSLog(@"读取 - 5"); });
    dispatch_async(queue, ^{ NSLog(@"读取 - 6"); });
    dispatch_async(queue, ^{ NSLog(@"读取 - 7"); });
}

#pragma mark - Dispatch Group
// 在追加到Dispatch Queue中的多个处理全部结束后想执行结束处理时。
// 只使用一个Serial Dispatch Queue时，只要将想执行的处理全部追加到该Serial Dispatch Queue中并在最后追加结束处理，即可实现。
// 但是使用Concurrent Dispatch Queue时或者同事使用多个Dispatch Queue时，结束就会变得复杂。
// 这种情况下使用Dispatch Group
- (void)dispatchGroup
{
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_group_t group = dispatch_group_create();
    
    dispatch_group_async(group, queue, ^{
        NSLog(@"group block 1");
    });
    dispatch_group_async(group, queue, ^{
        NSLog(@"group block 2");
    });
    dispatch_group_async(group, queue, ^{
        NSLog(@"group block 3");
    });
    
    // 结束时，执行block
    dispatch_group_notify(group, dispatch_get_main_queue(), ^{
        NSLog(@"Done!");
    });
    
    
//    // 一旦调用dispatch_group_wait函数，则该函数就处于调用的状态而不返回。
//    // 即执行dispatch_group_wait函数的线程（当前线程）停止。
//    // 在经过dispatch_group_wait函数指定的时间或属于指定dispatch group的处理全部完成后，执行该函数的线程停止。
//
//    // 永久等待
//    //dispatch_group_wait(group, DISPATCH_TIME_FOREVER);
//    // 等待5秒
//    long result = dispatch_group_wait(group, dispatch_time(DISPATCH_TIME_NOW, 5 * NSEC_PER_SEC));
//    if (result == 0) {
//        // Dispatch Group全部处理结束
//        NSLog(@"Done!");
//    } else {
//        // 某一个还在处理中
//        NSLog(@"某一个还在处理中");
//    }
    
    // 注意：
    // 推荐使用dispatch_group_notify函数追加结束处理到Main Dispatch Queue中。
}


#pragma mark - 3秒后执行处理
- (void)dispatchAfter
{
    NSLog(@"开始监听");
    dispatch_time_t time = dispatch_time(DISPATCH_TIME_NOW, NSEC_PER_SEC * 3);
    dispatch_after(time, dispatch_get_main_queue(), ^{
        NSLog(@"3秒已结束，监听完毕！");
    });
}


#pragma mark - 变更执行优先级dispatch_set_target_queue
- (void)setTargetQueue
{
    // dispatch_queue_create函数生成的Dispatch Queue不管是Serial Queue还是Concurrent Queue，
    // 使用与默认优先级Global Dispatch Queue相同执行优先级的线程
    // 如果要变更执行优先级使用dispatch_set_target_queue
    
    dispatch_queue_t mySerialDispatchQueue = dispatch_queue_create("com.wdy-test.gcd", NULL);
    dispatch_queue_t globalDispatchQueueBackground = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0);
    
    
    // 第一个参数：指定要变更执行优先级的Dispatch Queue
    // 第二个参数：与要使用的执行优先级相同优先级的Global Dispatch Queue
    dispatch_set_target_queue(mySerialDispatchQueue, globalDispatchQueueBackground);
    
    
    // 变更优先级后，首次执行
    dispatch_async(mySerialDispatchQueue, ^{
        
        NSLog(@"变更优先级后，首次执行 : %@", [[NSThread currentThread] name]);
    });
}


#pragma mark - System Queue -> Main / Global

- (void)systemDispatchQueue
{
    // 获取主线程序列
    dispatch_queue_t mainDispatchQueue = dispatch_get_main_queue();
    
    // 获取全局序列
    dispatch_queue_t globalDispatchQueueHigh = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0);
    dispatch_queue_t globalDispatchQueueDefault = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_queue_t globalDispatchQueueLow = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_LOW, 0);
    dispatch_queue_t globalDispatchQueueBackground = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0);
    
    
    // 在默认优先级的Global Dispatch Queue执行耗时操作
    dispatch_async(globalDispatchQueueDefault, ^{
        
        NSLog(@"执行耗时操作...");
        
        // 在Main Dispatch Queue中执行block
        dispatch_async(mainDispatchQueue, ^{
            NSLog(@"主线程中执行处理...");
        });
        
    });
    
}



#pragma mark - Serial(顺序执行) / Concurrent(并行执行)

// 线性执行序列
// 多个线程更新相同资源导致数据竞争时，使用SerialDispatchQueue
// 生成个数仅限所必须的数量：更新数据库时，1个表生成一个Serial Dispatch Queue
// 更新文件时，1个文件或是可以分割的1个文件块生成一个Serial Dispatch Queue
- (void)serialDispatchQueue
{
    __block int count = 0;
    dispatch_queue_t mySerialQueue = dispatch_queue_create("com.wdy-test.myserialqueue", NULL);
    dispatch_async(mySerialQueue, ^{
        NSLog(@"block - 1  -> %zd", count++);
    });
    dispatch_async(mySerialQueue, ^{
        NSLog(@"block - 2  -> %zd", count++);
    });
    dispatch_async(mySerialQueue, ^{
        NSLog(@"block - 3  -> %zd", count++);
    });
    dispatch_async(mySerialQueue, ^{
        NSLog(@"block - 4  -> %zd", count++);
    });
    dispatch_async(mySerialQueue, ^{
        NSLog(@"block - 5  -> %zd", count++);
    });
}

// 并行执行序列
// 并行执行不发生数据竞争等问题的处理时，使用该序列
- (void)concurrentDispatchQueue
{
    dispatch_queue_t myConcurrentQueue = dispatch_queue_create("com.wdy-test.myserialqueue", DISPATCH_QUEUE_CONCURRENT);
    dispatch_async(myConcurrentQueue, ^{
        NSLog(@"block - 1");
    });
    dispatch_async(myConcurrentQueue, ^{
        NSLog(@"block - 2");
    });
    dispatch_async(myConcurrentQueue, ^{
        NSLog(@"block - 3");
    });
    dispatch_async(myConcurrentQueue, ^{
        NSLog(@"block - 4");
    });
    dispatch_async(myConcurrentQueue, ^{
        NSLog(@"block - 5");
    });
    
}


@end

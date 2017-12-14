//
//  WDMeCacheClearCell.m
//  frame-bsbdj
//
//  Created by WangDongya on 2017/12/7.
//  Copyright © 2017年 example. All rights reserved.
//

#import "WDMeCacheClearCell.h"
#import "NSString+WDExtension.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import <SVProgressHUD/SVProgressHUD.h>


#define WDDefaultFilePath [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES).lastObject stringByAppendingPathComponent:@"CustomPath"]

@implementation WDMeCacheClearCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        // 获取SDImage中的图片缓存
        UIActivityIndicatorView *loadingView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
        [loadingView startAnimating];
        self.accessoryView = loadingView;
        self.textLabel.text = @"清除缓存(计算中...)";
        self.textLabel.textColor = [UIColor blackColor];
        self.userInteractionEnabled = NO;
        
        __weak typeof(self) weakSelf = self;
        // 异步计算
        dispatch_async(dispatch_get_global_queue(0, 0), ^{
#warning 休眠3秒
            [NSThread sleepForTimeInterval:3];
            
            // 耗时操作---开始
            unsigned long long size = WDDefaultFilePath.fileSize;
            size += [SDImageCache sharedImageCache].getSize;
            // 耗时操作---结束
            // 判断当前Cell是否被销毁
            if (weakSelf == nil) {return ;}
            
            NSString *sizeText = nil;
            if (size >= pow(10, 9)) {
                sizeText = [NSString stringWithFormat:@"%.2fGB", size / pow(10, 9)];
            } else if (size >= pow(10, 6)) {
                sizeText = [NSString stringWithFormat:@"%.2fMB", size / pow(10, 6)];
            } else if (size >= pow(10, 3)) {
                sizeText = [NSString stringWithFormat:@"%.2fKB", size / pow(10, 3)];
            } else {
                sizeText = [NSString stringWithFormat:@"%zdB", size];
            }
            
            NSString *sizeResult = [NSString stringWithFormat:@"清除缓存(%@)", sizeText];
            dispatch_async(dispatch_get_main_queue(), ^{
                // 改变文字
                weakSelf.textLabel.text = sizeResult;
                // 去掉loadingView
                weakSelf.accessoryView = nil;
                // 添加箭头
                weakSelf.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
                // 可点击
                weakSelf.userInteractionEnabled = YES;
                // 点击手势
                [weakSelf addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:weakSelf action:@selector(clearCache)]];
            });
        });
        
    }
    return self;
}

- (void)clearCache
{
    // 显示指示器
    [SVProgressHUD setDefaultStyle:SVProgressHUDStyleLight];
    [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeBlack];
    [SVProgressHUD setForegroundColor:[UIColor redColor]];
    [SVProgressHUD showWithStatus:@"正在清除..."];
    
    // 清除缓存
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        // 1. 清除SDWebImage产生的缓存
        [[SDImageCache sharedImageCache] clearDiskOnCompletion:^{
#warning 休眠3秒
            [NSThread sleepForTimeInterval:3];
            // 2. 清除自定义缓存文件
            dispatch_async(dispatch_get_global_queue(0, 0), ^{
                NSFileManager *manager = [NSFileManager defaultManager];
                // 清除文件夹，及其内容
                [manager removeItemAtPath:WDDefaultFilePath error:nil];
                // 再次创建目录
                [manager createDirectoryAtPath:WDDefaultFilePath withIntermediateDirectories:YES attributes:nil error:nil];
                // 3. 进入主线程
                dispatch_async(dispatch_get_main_queue(), ^{
                    // 改变文字
                    self.textLabel.text = @"清除缓存(0B)";
                    // 隐藏SVProgressHUD
                    [SVProgressHUD dismiss];
                });
            });
        }];
    });
}

// 当cell重新显示到界面上时，会重新调用一次该方法
-(void)layoutSubviews
{
    [super layoutSubviews];
    UIActivityIndicatorView *loading = (UIActivityIndicatorView *)[self accessoryView];
    [loading startAnimating];
}


@end

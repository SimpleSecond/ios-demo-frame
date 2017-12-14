//
//  WDSettingViewController.m
//  frame-bsbdj
//
//  Created by WangDongya on 2017/12/7.
//  Copyright © 2017年 example. All rights reserved.
//

#import "WDSettingViewController.h"
#import <SDWebImage/SDImageCache.h>
#import "WDMeCacheClearCell.h"
#import "WDMeSettingCell.h"
#import "WDMeOtherCell.h"

@interface WDSettingViewController ()

@end

@implementation WDSettingViewController

static NSString * const ID_CLEAR_CACHE = @"clear_cell";
static NSString * const ID_SETTING = @"setting_cell";
static NSString * const ID_OTHER = @"other_cell";

- (instancetype)init
{
    return [self initWithStyle:UITableViewStyleGrouped];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.navigationItem setTitle:@"设置"];
    [self.tableView setContentInset:UIEdgeInsetsMake(WDMargin - 35, 0, 0, 0)];
    
    // 注册Cell
    [self.tableView registerClass:[WDMeCacheClearCell class] forCellReuseIdentifier:ID_CLEAR_CACHE];
    [self.tableView registerClass:[WDMeSettingCell class] forCellReuseIdentifier:ID_SETTING];
    [self.tableView registerClass:[WDMeOtherCell class] forCellReuseIdentifier:ID_OTHER];
}

//- (void)getCacheSize1
//{
//    //
//    NSUInteger size = 0;
//    // 获取缓存路径
//    NSString *cachesPath = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES).lastObject;
//    NSString *dirPath = [cachesPath stringByAppendingPathComponent:@""];
//
//    // 文件管理者
//    NSFileManager *manager = [NSFileManager defaultManager];
//
//    // 获取文件夹的大小 == 获取文件夹中所有文件的总和
//
//    for (NSString *subpath in [manager enumeratorAtPath:dirPath]) {
//        // 全路径
//        NSString *fullSubpath = [dirPath stringByAppendingPathComponent:subpath];
//        // 文件属性
//        NSDictionary *attrs = [manager attributesOfItemAtPath:fullSubpath error:nil];
//        // 累加大小
//        // size += [attrs[NSFileSize] unsignedIntegerValue];
//        // size += attrs.fileSize;
//        size += [attrs fileSize];
//    }
//    NSLog(@"%zd", size);
//}
//
//- (void)getCacheSize2
//{
//    //
//    NSUInteger size = 0;
//    // 获取缓存路径
//    NSString *cachesPath = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES).lastObject;
//    NSString *dirPath = [cachesPath stringByAppendingPathComponent:@""];
//
//    // 文件管理者
//    NSFileManager *manager = [NSFileManager defaultManager];
//
//    // 获取文件夹的大小 == 获取文件夹中所有文件的总和
//    NSArray *subpaths = [manager subpathsAtPath:dirPath];
//    for (NSString *subpath in subpaths) {
//        // 全路径
//        NSString *fullSubpath = [dirPath stringByAppendingPathComponent:subpath];
//        // 文件属性
//        NSDictionary *attrs = [manager attributesOfItemAtPath:fullSubpath error:nil];
//        // 累加大小
//        // size += [attrs[NSFileSize] unsignedIntegerValue];
//        size += attrs.fileSize;
//    }
//    NSLog(@"%zd", size);
//}


#pragma mark - UITableViewDelegate/UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 5;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    // 第一组
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            return [tableView dequeueReusableCellWithIdentifier:ID_CLEAR_CACHE];
        } else {
            WDMeSettingCell *cell = [tableView dequeueReusableCellWithIdentifier:ID_SETTING];
            
            if (indexPath.row == 1) {
                cell.textLabel.text = @"检查更新";
            } else if (indexPath.row == 2) {
                cell.textLabel.text = @"给我们评分";
            } else if (indexPath.row == 3) {
                cell.textLabel.text = @"推送设置";
            } else if (indexPath.row == 4) {
                cell.textLabel.text = @"关于我们";
            }
            
            return cell;
        }
    } else {
        // 其他组
        WDMeOtherCell *cell = [tableView dequeueReusableCellWithIdentifier:ID_OTHER];
        return cell;
    }
}

@end

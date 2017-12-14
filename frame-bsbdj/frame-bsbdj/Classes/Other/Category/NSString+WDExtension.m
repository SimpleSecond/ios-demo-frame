//
//  NSString+WDExtension.m
//  frame-bsbdj
//
//  Created by WangDongya on 2017/12/7.
//  Copyright © 2017年 example. All rights reserved.
//

#import "NSString+WDExtension.h"

@implementation NSString (WDExtension)

// 方式一、
-(unsigned long long)fileSize
{
    // 总大小
    unsigned long long size = 0;
    // 文件管理者
    NSFileManager *manager = [NSFileManager defaultManager];
    // 文件属性
    NSDictionary *attrs = [manager attributesOfItemAtPath:self error:nil];
    
    BOOL directory = false;
    BOOL exists = [manager fileExistsAtPath:self isDirectory:&directory];
    
    // 如果文件不存在，则返回0
    if (!exists) {
        return size;
    }
    
    if (directory) {
        // 获得文件夹的大小 == 文件夹中所有文件的大小之和
        NSDirectoryEnumerator *enumerator = [manager enumeratorAtPath:self];
        for (NSString *subpath in enumerator) {
            // 全路径
            NSString *fullSubpath = [self stringByAppendingPathComponent:subpath];
            // 累加文件大小
            size += [[manager attributesOfItemAtPath:fullSubpath error:nil] fileSize];
        }
    } else {
        // 文件
        size = attrs.fileSize;
    }
    return size;
}
// 方式二、
//-(unsigned long long)fileSize
//{
//    // 总大小
//    unsigned long long size = 0;
//    // 文件管理者
//    NSFileManager *manager = [NSFileManager defaultManager];
//    // 文件属性
//    NSDictionary *attrs = [manager attributesOfItemAtPath:self error:nil];
//
//    if ([attrs.fileType isEqualToString:NSFileTypeDirectory]) {
//        // 获得文件夹的大小 == 文件夹中所有文件的大小之和
//        NSDirectoryEnumerator *enumerator = [manager enumeratorAtPath:self];
//        for (NSString *subpath in enumerator) {
//            // 全路径
//            NSString *fullSubpath = [self stringByAppendingPathComponent:subpath];
//            // 累加文件大小
//            size += [[manager attributesOfItemAtPath:fullSubpath error:nil] fileSize];
//        }
//    } else {
//        // 文件
//        size = attrs.fileSize;
//    }
//    return size;
//}

@end

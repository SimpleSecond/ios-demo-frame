//
//  WDUser.h
//  frame-bsbdj
//
//  Created by WangDongya on 2017/12/11.
//  Copyright © 2017年 example. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WDUser : NSObject
// 用户名
@property (nonatomic, copy) NSString *username;
// 头像
@property (nonatomic, copy) NSString *profile_image;
// 性别
@property (nonatomic, copy) NSString *sex;

@end

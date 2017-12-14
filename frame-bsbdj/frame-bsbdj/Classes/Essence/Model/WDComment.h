//
//  WDComment.h
//  frame-bsbdj
//
//  Created by WangDongya on 2017/12/11.
//  Copyright © 2017年 example. All rights reserved.
//

#import <Foundation/Foundation.h>

@class WDUser;

@interface WDComment : NSObject
// 内容
@property (nonatomic, copy) NSString *content;
// 发表评论的人
@property (nonatomic, strong) WDUser *user;

@end

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
// id
@property (nonatomic, copy) NSString *ID;
// 内容
@property (nonatomic, copy) NSString *content;
// 发表评论的人
@property (nonatomic, strong) WDUser *user;
// 被点赞数
@property (nonatomic, assign) NSInteger like_count;

// 音频文件的时长
@property (nonatomic, assign) NSInteger voicetime;
// 音频文件的路径
@property (nonatomic, copy) NSString *voiceuri;

@end

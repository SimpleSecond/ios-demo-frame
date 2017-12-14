//
//  WDTopic.h
//  frame-bsbdj
//
//  Created by WangDongya on 2017/12/9.
//  Copyright © 2017年 example. All rights reserved.
//

#import <Foundation/Foundation.h>


typedef NS_ENUM(NSUInteger, WDTopicType) {
    // 全部
    WDTopicTypeAll = 1,
    // 图片
    WDTopicTypePicture = 10,
    // 段子
    WDTopicTypeWord = 29,
    // 声音
    WDTopicTypeVoice = 31,
    // 视频
    WDTopicTypeVideo = 41
};


@interface WDTopic : NSObject

// 计算cell的高度
@property (nonatomic, assign) CGFloat cellHeight;

// 用户名字
@property (nonatomic, copy) NSString *name;
// 用户头像
@property (nonatomic, copy) NSString *profile_image;
// 帖子文字内容
@property (nonatomic, copy) NSString *text;
// 帖子审核通过时间
@property (nonatomic, copy) NSString *created_at;
// 顶数量
@property (nonatomic, assign) NSInteger ding;
// 踩数量
@property (nonatomic, assign) NSInteger cai;
// 转发、分享数量
@property (nonatomic, assign) NSInteger repost;
// 评论数量
@property (nonatomic, assign) NSInteger comment;

// 帖子类型
@property (nonatomic, assign) WDTopicType type;

// 图片真实宽度和高度
@property (nonatomic, assign) CGFloat width;
@property (nonatomic, assign) CGFloat height;

// 小图、中图、大图、是否为gif图片
@property (nonatomic, copy) NSString *small_image;
@property (nonatomic, copy) NSString *middle_image;
@property (nonatomic, copy) NSString *large_image;
@property (nonatomic, assign) BOOL is_gif;


// 音视频时长，及播放次数
@property (nonatomic, assign) NSInteger voicetime;
@property (nonatomic, assign) NSInteger videotime;
@property (nonatomic, assign) NSInteger playcount;


// 中间内容的frame
@property (nonatomic, assign) CGRect contentFrame;
// 是否为超长图片
@property (nonatomic, assign, getter=isBigPicture) BOOL bigPicture;

@end

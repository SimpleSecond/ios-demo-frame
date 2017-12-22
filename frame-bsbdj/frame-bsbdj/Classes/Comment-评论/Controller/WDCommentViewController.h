//
//  WDCommentViewController.h
//  frame-bsbdj
//
//  Created by WangDongya on 2017/12/21.
//  Copyright © 2017年 example. All rights reserved.
//

#import <UIKit/UIKit.h>

@class WDTopic;
@interface WDCommentViewController : UIViewController

// 帖子模型数据
@property (nonatomic, strong) WDTopic *topic;

@end

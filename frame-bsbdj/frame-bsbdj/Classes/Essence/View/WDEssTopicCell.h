//
//  WDEssTopicCell.h
//  frame-bsbdj
//
//  Created by WangDongya on 2017/12/11.
//  Copyright © 2017年 example. All rights reserved.
//

#import <UIKit/UIKit.h>

@class WDTopic;
@interface WDEssTopicCell : UITableViewCell

/** 帖子模型 */
@property (nonatomic, strong) WDTopic *topic;

@end

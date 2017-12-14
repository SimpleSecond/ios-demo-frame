//
//  WDEssTopicVoiceView.m
//  frame-bsbdj
//
//  Created by WangDongya on 2017/12/11.
//  Copyright © 2017年 example. All rights reserved.
//

#import "WDEssTopicVoiceView.h"
#import "WDTopic.h"
#import <SDWebImage/UIImageView+WebCache.h>

@interface WDEssTopicVoiceView ()
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) IBOutlet UILabel *playCountLabel;


@end

@implementation WDEssTopicVoiceView

-(void)awakeFromNib
{
    self.autoresizingMask = UIViewAutoresizingNone;
    [super awakeFromNib];
}


- (void)setTopic:(WDTopic *)topic
{
    _topic = topic;
    
    [self.imageView sd_setImageWithURL:[NSURL URLWithString:topic.large_image]];
    self.playCountLabel.text = [NSString stringWithFormat:@"%zd播放",topic.playcount];
    
    NSInteger minute = topic.videotime / 60;
    NSInteger second = topic.videotime % 60;
    
    // %04zd - 占据4位,空出来的位用0来填补
    self.timeLabel.text = [NSString stringWithFormat:@"%02zd:%02zd", minute, second];
}


@end

//
//  WDEssTopicCell.m
//  frame-bsbdj
//
//  Created by WangDongya on 2017/12/11.
//  Copyright © 2017年 example. All rights reserved.
//

#import "WDEssTopicCell.h"
#import "WDTopic.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import "WDEssTopicPictureView.h"
#import "WDEssTopicVideoView.h"
#import "WDEssTopicVoiceView.h"


@interface WDEssTopicCell()
@property (weak, nonatomic) IBOutlet UIImageView *profileImageView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) IBOutlet UIButton *dingBtn;
@property (weak, nonatomic) IBOutlet UIButton *caiBtn;
@property (weak, nonatomic) IBOutlet UIButton *shareBtn;
@property (weak, nonatomic) IBOutlet UIButton *commentBtn;
@property (weak, nonatomic) IBOutlet UILabel *content;


@property (nonatomic, strong) WDEssTopicPictureView *pictureView;
@property (nonatomic, strong) WDEssTopicVideoView *videoView;
@property (nonatomic, strong) WDEssTopicVoiceView *voiceView;

@end


@implementation WDEssTopicCell

#pragma mark - 懒加载
-(WDEssTopicPictureView *)pictureView
{
    if (!_pictureView) {
        WDEssTopicPictureView *pictureView = [WDEssTopicPictureView viewFromXib];
        [self addSubview:pictureView];
        _pictureView = pictureView;
    }
    return _pictureView;
}
-(WDEssTopicVideoView *)videoView
{
    if (!_videoView) {
        WDEssTopicVideoView *videoView = [WDEssTopicVideoView viewFromXib];
        [self addSubview:videoView];
        _videoView = videoView;
    }
    return _videoView;
}
-(WDEssTopicVoiceView *)voiceView
{
    if (!_voiceView) {
        WDEssTopicVoiceView *voiceView = [WDEssTopicVoiceView viewFromXib];
        [self addSubview:voiceView];
        _voiceView = voiceView;
    }
    return _voiceView;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    //self.contentView.wd_bottom = 10;
    self.backgroundView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"mainCellBackground"]];
}

- (void)setFrame:(CGRect)frame
{
    frame.size.height -= WDMargin;
    frame.origin.y += WDMargin;
//    frame.origin.x += WDMargin;
//    frame.size.width -= WDMargin * 2;
    
    [super setFrame:frame];
}

- (void)setTopic:(WDTopic *)topic
{
    _topic = topic;
    
    [self.profileImageView sd_setImageWithURL:[NSURL URLWithString:topic.profile_image] placeholderImage:[UIImage imageNamed:@"defaultUserIcon"]];
    self.nameLabel.text = _topic.name;
    self.timeLabel.text = _topic.created_at;
    self.content.text = _topic.text;
    
    [self setupButton:self.dingBtn number:topic.ding placeholder:@"顶"];
    [self setupButton:self.caiBtn number:topic.cai placeholder:@"踩"];
    [self setupButton:self.shareBtn number:topic.repost placeholder:@"分享"];
    [self setupButton:self.commentBtn number:topic.comment placeholder:@"评论"];
    
    
    // 最热评论
    
    
    // 中间内容
    if (topic.type == WDTopicTypePicture) {
        self.pictureView.hidden = NO;
        self.videoView.hidden = YES;
        self.voiceView.hidden = YES;
        self.pictureView.frame = topic.contentFrame;
        self.pictureView.topic = topic;
    } else if (topic.type == WDTopicTypeVideo) {
        self.pictureView.hidden = YES;
        self.videoView.hidden = NO;
        self.voiceView.hidden = YES;
        self.videoView.frame = topic.contentFrame;
        self.videoView.topic = topic;
    } else if (topic.type == WDTopicTypeVoice) {
        self.pictureView.hidden = YES;
        self.videoView.hidden = YES;
        self.voiceView.hidden = NO;
        self.voiceView.frame = topic.contentFrame;
        self.voiceView.topic = topic;
    } else if (topic.type == WDTopicTypeWord) { // 段子
        self.videoView.hidden = YES;
        self.voiceView.hidden = YES;
        self.pictureView.hidden = YES;
    }
}

- (void)setupButton:(UIButton *)button number:(NSInteger)number placeholder:(NSString *)placeholder
{
    if (number >= 10000) {
        [button setTitle:[NSString stringWithFormat:@"%.1f万", number / 10000.0] forState:UIControlStateNormal];
    } else if (number > 0) {
        [button setTitle:[NSString stringWithFormat:@"%zd", number] forState:UIControlStateNormal];
    } else {
        [button setTitle:placeholder forState:UIControlStateNormal];
    }
}

@end

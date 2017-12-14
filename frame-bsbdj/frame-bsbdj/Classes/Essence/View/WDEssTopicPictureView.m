//
//  WDEssTopicPictureView.m
//  frame-bsbdj
//
//  Created by WangDongya on 2017/12/11.
//  Copyright © 2017年 example. All rights reserved.
//

#import "WDEssTopicPictureView.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import "WDTopic.h"
#import <AFNetworking/AFNetworking.h>

@interface WDEssTopicPictureView ()
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UIImageView *gitView;
@property (weak, nonatomic) IBOutlet UIButton *seaLargeView;


@end

@implementation WDEssTopicPictureView

-(void)awakeFromNib
{
    self.autoresizingMask = UIViewAutoresizingNone;
    [super awakeFromNib];
}

- (void)setTopic:(WDTopic *)topic
{
    _topic = topic;
    
    AFNetworkReachabilityStatus status = [AFNetworkReachabilityManager manager].networkReachabilityStatus;
    
//    if (status == AFNetworkReachabilityStatusReachableViaWWAN) {
//        [self.imageView sd_setImageWithURL:[NSURL URLWithString:topic.small_image]];
//    } else if (status == AFNetworkReachabilityStatusReachableViaWiFi) {
//        [self.imageView sd_setImageWithURL:[NSURL URLWithString:topic.large_image]];
//    } else {
//        // 网络有问题时，需要将图片清理掉
//        // 注意：模拟器的网络判断也走这里（模拟器不区分wifi和手机网络）
//        self.imageView.image = nil;
//    }
    [self.imageView sd_setImageWithURL:[NSURL URLWithString:topic.large_image]];
    
    
    
    // 判断是否为gif图片
    self.gitView.hidden = !topic.is_gif;
    
    // 判断是否是大图
    if (topic.bigPicture) {
        self.seaLargeView.hidden = NO;
        self.imageView.contentMode = UIViewContentModeTop;
        self.imageView.clipsToBounds = YES;
    } else {
        self.seaLargeView.hidden = YES;
        self.imageView.contentMode = UIViewContentModeScaleAspectFill;
        self.imageView.clipsToBounds = NO;
    }
    
}

@end

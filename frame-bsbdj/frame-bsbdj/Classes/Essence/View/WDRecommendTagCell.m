//
//  WDRecommendTagCell.m
//  frame-bsbdj
//
//  Created by WangDongya on 2017/12/21.
//  Copyright © 2017年 example. All rights reserved.
//

#import "WDRecommendTagCell.h"
#import "WDRecommendTag.h"


@interface WDRecommendTagCell ()
@property (weak, nonatomic) IBOutlet UIImageView *imageListView;
@property (weak, nonatomic) IBOutlet UILabel *themeNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *subNumberLabel;


@end

@implementation WDRecommendTagCell

- (void)setRecommendTag:(WDRecommendTag *)recommendTag
{
    _recommendTag = recommendTag;
    
    // 头像
    [self.imageListView wd_setupHeader:recommendTag.image_list];
    // 名字
    self.themeNameLabel.text = recommendTag.theme_name;
    // 订阅数
    if (recommendTag.sub_number >= 10000) {
        self.subNumberLabel.text = [NSString stringWithFormat:@"%.1f万人订阅", recommendTag.sub_number / 10000.0];
    } else {
        self.subNumberLabel.text = [NSString stringWithFormat:@"%zd人订阅", recommendTag.sub_number];
    }
}


// 重写setFrame:方法，监听设置cell的frame的过程
- (void)setFrame:(CGRect)frame
{
    frame.size.height -= 1;
    [super setFrame:frame];
}

@end

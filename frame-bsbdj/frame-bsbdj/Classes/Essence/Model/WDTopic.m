//
//  WDTopic.m
//  frame-bsbdj
//
//  Created by WangDongya on 2017/12/9.
//  Copyright © 2017年 example. All rights reserved.
//

#import "WDTopic.h"

@implementation WDTopic

static NSDateFormatter *fmt_;
static NSCalendar *calendar_;

// 在第一次使用WDTopic类时调用1次
+ (void)initialize
{
    fmt_ = [[NSDateFormatter alloc] init];
    calendar_ = [NSCalendar wd_calendar];
}

-(NSString *)created_at
{
    // 获得发帖日期
    fmt_.dateFormat = @"yyyy-MM-dd HH:mm:ss";
    NSDate *createAtDate = [fmt_ dateFromString:_created_at];
    
    // 判断是否是今年
    if (createAtDate.wd_isThisYear) {
        if (createAtDate.wd_isToday) { // 是今天
            // 手机当前时间
            NSDate *nowDate = [NSDate date];
            NSCalendarUnit unit = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond;
            NSDateComponents *cmps = [calendar_ components:unit fromDate:createAtDate toDate:nowDate options:0];
            if (cmps.hour >= 1) { // 时间间隔 >= 1小时
                return [NSString stringWithFormat:@"%zd小时前", cmps.hour];
            } else if (cmps.minute >= 1) { // 1小时 > 时间间隔 >= 1分钟
                return [NSString stringWithFormat:@"%zd分钟前", cmps.minute];
            } else { // 1分钟 > 分钟
                return @"刚刚";
            }
        } else if (createAtDate.wd_isYesterday) { // 是昨天
            fmt_.dateFormat = @"昨天 HH:mm:ss";
            return [fmt_ stringFromDate:createAtDate];
        } else {  // 其他
            fmt_.dateFormat = @"MM-dd HH:mm:ss";
            return [fmt_ stringFromDate:createAtDate];
        }
    } else {
        // 非今年
        return _created_at;
    }
}

-(CGFloat)cellHeight
{
    // 如果高度已经存在，则直接返回高度
    if (_cellHeight) return _cellHeight;
    
    // 计算cell的高度
    
    // 1. 顶部高度
    _cellHeight = 50;
    
    // 2. 文字高度
    CGFloat textMaxW = SCREEN_WIDTH - 2*WDMargin;
    CGSize textMaxSize = CGSizeMake(textMaxW, MAXFLOAT);
    CGSize textSize = [self.text boundingRectWithSize:textMaxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName: [UIFont systemFontOfSize:15]} context:nil].size;
    _cellHeight += textSize.height + WDMargin * 2;
    
    // 3. 中间的内容
    if (self.type != WDTopicTypeWord) {
        CGFloat contentH = textMaxW * self.height / self.width;
        
        // 判断是否为超长图片
        if (contentH >= SCREEN_HEIGHT) {
            // 将超长图片的高度设置为200
            contentH = 200;
            self.bigPicture = YES;
        }
        
        // 中间视图的大小。这里cellHeight就是中间内容的y值
        self.contentFrame = CGRectMake(WDMargin, _cellHeight, textMaxW, contentH);
        
        // 累加中间内容高度
        _cellHeight += contentH + WDMargin;
    }
    
    // 4. 最热评论
    
    // 5. 底部高度 - 工具条
    _cellHeight += 35 + WDMargin;
    
    return _cellHeight;
}

@end

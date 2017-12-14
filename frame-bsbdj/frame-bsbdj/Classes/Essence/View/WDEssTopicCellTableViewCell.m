//
//  WDEssTopicCellTableViewCell.m
//  frame-bsbdj
//
//  Created by WangDongya on 2017/12/9.
//  Copyright © 2017年 example. All rights reserved.
//

#import "WDEssTopicCellTableViewCell.h"

@implementation WDEssTopicCellTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    NSDate *date = [NSDate date];
    NSDateFormatter *format = [[NSDateFormatter alloc] init];
    format.dateFormat = @"yyyy-MM-dd HH:mm:ss";
    
    date = [format dateFromString:@"2017-12-09 14:23:33"];
    
#define iOS(version) ([UIDevice currentDevice].systemVersion.doubleValue >= (version))
    
    // NSCalendar 中适配
    NSCalendar *calendar = nil;
    // 1. 根据是否含有类方法
    if ([NSCalendar respondsToSelector:@selector(calendarWithIdentifier:)]) {
        // 如果含有该类方法
        calendar = [NSCalendar calendarWithIdentifier:NSCalendarIdentifierChinese];
    } else {
        calendar = [NSCalendar currentCalendar];
    }
    // 2. 根据系统版本适配
    if (iOS(8.0)) {
        calendar = [NSCalendar calendarWithIdentifier:NSCalendarIdentifierChinese];
    } else {
        calendar = [NSCalendar currentCalendar];
    }
    
    // 日期对象是否是今天
    [calendar isDateInToday:[format dateFromString:@"2017-12-09 13:33:33"]];
    
    //    NSUInteger year = [calendar component:NSCalendarUnitYear fromDate:date];
    //    NSUInteger month = [calendar component:NSCalendarUnitMonth fromDate:date];
    //    NSUInteger hour = [calendar component:NSCalendarUnitHour fromDate:date];
    //    NSUInteger minute = [calendar component:NSCalendarUnitMinute fromDate:date];
    //    NSUInteger second = [calendar component:NSCalendarUnitNanosecond fromDate:date];
    
    //    NSDateComponents *components = [calendar components:(NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitHour|NSCalendarUnitMinute|NSCalendarUnitNanosecond) fromDate:date];
    //    components.year;components.month; components.hour; components.minute;
    
    // 返回两个时间间隔多少秒
    [date timeIntervalSinceDate:nil];
    
    
    // 获得日期间的间隔
    //    NSCalendarUnit unit = NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitDay|NSCalendarUnitHour|NSCalendarUnitMinute|NSCalendarUnitNanosecond;
    //    NSDateComponents *compare = [calendar components:unit fromDate:date toDate:nil options:0];
    
    
    // 日期时间：刚刚、10分钟前、5小时前、昨天 09:10:05、11-20 09:45:32、2016-01-11 08：34：21
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end

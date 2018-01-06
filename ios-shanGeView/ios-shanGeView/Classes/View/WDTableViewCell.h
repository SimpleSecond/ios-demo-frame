//
//  WDTableViewCell.h
//  ios-shanGeView
//
//  Created by WangDongya on 2017/12/26.
//  Copyright © 2017年 example. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WDGridLayoutView.h"

@interface WDTableViewCell : UITableViewCell

@property (nonatomic, strong) WDGridLayoutView *layoutView;
@property (nonatomic, strong) NSString *jsonStr;


@end

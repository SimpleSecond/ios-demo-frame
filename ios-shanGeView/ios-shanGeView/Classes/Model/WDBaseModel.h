//
//  WDBaseModel.h
//  ios-shanGeView
//
//  Created by WangDongya on 2017/12/26.
//  Copyright © 2017年 example. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WDBaseModel : NSObject
@property (nonatomic, strong) NSArray *images;
@property (nonatomic, strong) NSArray *children;
@property (nonatomic, assign) double height;
@property (nonatomic, copy) NSString *orientation;
@property (nonatomic, copy) NSString *image;
@property (nonatomic, assign) double weight;


@end

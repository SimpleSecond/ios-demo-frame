//
//  ChooseGoodsViewController.h
//  tbCart
//
//  Created by WangDongya on 2018/1/12.
//  Copyright © 2018年 wdy-test. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, EnterType) {
    FirstEnterType = 0,
    SecondEnterType
};

typedef void(^ChooseCallback) (void);


@interface ChooseGoodsViewController : UIViewController

@property (nonatomic, assign) CGFloat price;
@property (nonatomic, copy) ChooseCallback callback;
@property (nonatomic, assign) EnterType enterType;

@end

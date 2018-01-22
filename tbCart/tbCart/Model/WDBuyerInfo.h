//
//  WDBuyerInfo.h
//  tbCart
//
//  Created by WangDongya on 2018/1/18.
//  Copyright © 2018年 wdy-test. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WDBuyerInfo : NSObject

@property (nonatomic,copy) NSString *buyer_id;
@property (nonatomic,copy) NSString *last_update_ts;
@property (nonatomic,copy) NSString *nick_name;
@property (nonatomic,copy) NSString *user_avatar;
@property (nonatomic,strong) NSMutableArray *prod_list;

// 买手左侧按钮是否选中
@property (nonatomic,assign) BOOL buyerIsChoosed;

// 买手下面商品是否全部编辑状态
@property (nonatomic,assign) BOOL buyerIsEditing;

@end

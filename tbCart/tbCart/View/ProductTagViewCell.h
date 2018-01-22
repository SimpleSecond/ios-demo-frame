//
//  ProductTagViewCell.h
//  tbCart
//
//  Created by WangDongya on 2018/1/15.
//  Copyright © 2018年 wdy-test. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <SKTagView/SKTagView.h>

@interface ProductTagViewCell : UITableViewCell

@property (nonatomic, strong) UILabel *leftTitleLabel;
@property (nonatomic, strong) SKTagView *tagView;


@end

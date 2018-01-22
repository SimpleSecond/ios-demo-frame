//
//  ChooseGoodsViewController.m
//  tbCart
//
//  Created by WangDongya on 2018/1/12.
//  Copyright © 2018年 wdy-test. All rights reserved.
//

#import "ChooseGoodsViewController.h"
#import "ProductTagViewCell.h"
#import "ProductCountViewCell.h"

#import "UITableView+FDTemplateLayoutCell.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import <Masonry/Masonry.h>

@interface ChooseGoodsViewController () <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UIView *panelView;
@property (nonatomic, strong) UIImageView *imageView;
@property (nonatomic, strong) UILabel *priceLabel;
@property (nonatomic, strong) UILabel *chooseLabel;
@property (nonatomic, strong) UIButton *confirmBtn;
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *dataSource;

@property (nonatomic, assign) NSInteger idx1;
@property (nonatomic, assign) NSInteger idx2;

@end

@implementation ChooseGoodsViewController

#pragma mark - 懒加载
-(UIView *)panelView
{
    if (!_panelView) {
        _panelView = [[UIView alloc] init];
    }
    return _panelView;
}

-(UIImageView *)imageView
{
    if (!_imageView) {
        _imageView = [[UIImageView alloc] init];
        _imageView.layer.cornerRadius = 5.0f;
        _imageView.clipsToBounds = YES;
    }
    return _imageView;
}

-(UILabel *)priceLabel
{
    if (!_priceLabel) {
        _priceLabel = [[UILabel alloc] init];
        _priceLabel.font = [UIFont boldSystemFontOfSize:18];
        _priceLabel.text = @"￥256";
    }
    return _priceLabel;
}

-(UILabel *)chooseLabel
{
    if (!_chooseLabel) {
        _chooseLabel = [[UILabel alloc] init];
        _chooseLabel.font = [UIFont systemFontOfSize:12];
        _chooseLabel.text = @"已选";
    }
    return _chooseLabel;
}

-(UIButton *)confirmBtn
{
    if (!_confirmBtn) {
        _confirmBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_confirmBtn addTarget:self action:@selector(confirmClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _confirmBtn;
}

- (UITableView *)tableView
{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.tableFooterView = [UIView new];
        [_tableView registerClass:[ProductTagViewCell class] forCellReuseIdentifier:NSStringFromClass([ProductTagViewCell class])];
        [_tableView registerClass:[ProductCountViewCell class] forCellReuseIdentifier:NSStringFromClass([ProductCountViewCell class])];
    }
    return _tableView;
}

- (NSMutableArray *)dataSource
{
    if (_dataSource == nil) {
        _dataSource = [[NSMutableArray alloc] initWithArray:@[@{@"颜色":@[@"红色",@"蓝色",@"藏青色",@"超级无敌屎黄色",@"超级鲜艳绿油油",@"白色",@"黑色",@"图图图图图色"]},@{@"尺码":@[@"L",@"M",@"X",@"XXXL",@"XXXXXXXXL",@"超级无敌大",@"超级无敌小",@"真的小道没朋友,那你买个P啊",@"地表最强",@"真的小道没朋友",@"大到没朋友，那么胖，别买了"]}]];
    }
    return _dataSource;
}

#pragma mark - System

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    UIViewController *parent = [self.view containingViewController];
    if ([parent respondsToSelector:@selector(dismissSemiModalView)]) {
        [parent dismissSemiModalView];
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupPanel];
    [self setupImageView];
    [self setupConfirmBtn];
    [self setupTableView];
    [self setupPriceLabel];
    [self setupChooseLabel];
    
    if (self.enterType == FirstEnterType) {
        [self.confirmBtn setTitle:@"去购物车" forState:UIControlStateNormal];
    } else {
        [self.confirmBtn setTitle:@"确定" forState:UIControlStateNormal];
    }
}

#pragma mark - Event
- (void)confirmClick:(UIButton *)sender
{
    UIViewController * parent = [self.view containingViewController];
    if ([parent respondsToSelector:@selector(dismissSemiModalView)]) {
        [parent dismissSemiModalView];
    }
    if (self.enterType == FirstEnterType)
    {
        self.callback();
    }
}


#pragma mark - setup

- (void)setupPanel
{
    [self.view addSubview:self.panelView];
    [self.panelView setBackgroundColor:[UIColor whiteColor]];
    // 添加约束
    [self.panelView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.view);
        make.trailing.equalTo(self.view);
        make.bottom.equalTo(self.view);
        
        make.height.mas_equalTo(500);
    }];
}

- (void)setupImageView
{
    [self.panelView addSubview:self.imageView];
    [self.imageView sd_setImageWithURL:[NSURL URLWithString:@"http://p3.wmpic.me/article/2016/07/08/1467959558_eOMTgkCd.jpg"] placeholderImage:nil completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        if (image && cacheType == SDImageCacheTypeNone) {
            self.imageView.alpha = 0;
            [UIView animateWithDuration:1.0 animations:^{
                self.imageView.alpha = 1.0f;
            }];
        } else {
            self.imageView.alpha = 1.0f;
        }
    }];
    
    [self.imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.trailing.equalTo(self.panelView).offset(-5);
        make.top.equalTo(self.panelView).offset(-50);
        
        make.height.mas_equalTo(150);
        make.width.mas_equalTo(150);
    }];
}

- (void)setupConfirmBtn
{
    [self.panelView addSubview:self.confirmBtn];
    
    [self.confirmBtn setBackgroundColor:[UIColor redColor]];
    
    [self.confirmBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.panelView).offset(10);
        make.trailing.equalTo(self.panelView).offset(-10);
        make.bottom.equalTo(self.panelView).offset(-5);
        
        make.height.mas_equalTo(40);
        
    }];
}

- (void)setupTableView
{
    [self.panelView addSubview:self.tableView];
    
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.panelView);
        make.trailing.equalTo(self.panelView);
        make.top.equalTo(self.imageView.mas_bottom).offset(10);
        make.bottom.equalTo(self.confirmBtn.mas_top).offset(-10);
    }];
}

- (void)setupPriceLabel
{
    [self.panelView addSubview:self.priceLabel];
    
    [self.priceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.panelView).offset(10);
        make.top.equalTo(self.panelView).offset(8);
    }];
}

- (void)setupChooseLabel
{
    [self.panelView addSubview:self.chooseLabel];
    
    [self.chooseLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.panelView).offset(10);
        make.trailing.equalTo(self.imageView.mas_leading).offset(-20);
        make.top.equalTo(self.priceLabel.mas_bottom).offset(8);
    }];
}

- (void)configTagCell:(ProductTagViewCell *)cell indexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row < self.dataSource.count) {
        UIColor *selectedColor = [UIColor colorWithRed:255.0/255.0 green:174.0/255.0 blue:1.0/255.0 alpha:1.0];
        
        cell.leftTitleLabel.text = [self.dataSource[indexPath.row] allKeys][0];
        
        [cell.tagView removeAllTags];
        // 非常重要
        cell.tagView.preferredMaxLayoutWidth = [UIScreen mainScreen].bounds.size.width - 70;
        cell.tagView.padding = UIEdgeInsetsMake(5, 10, 5, 10);
        cell.tagView.lineSpacing = 20;
        cell.tagView.interitemSpacing = 11;
        
        // 循环添加标签
        NSArray *arr = [self.dataSource[indexPath.row] allValues][0];
        [arr enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            SKTag *tag = [[SKTag alloc] initWithText:arr[idx]];
            tag.font = [UIFont boldSystemFontOfSize:13];
            
            //
            tag.padding = UIEdgeInsetsMake(5, 5, 5, 5);
            tag.cornerRadius = 5;
            tag.borderWidth = 0;
            // 第一个选择项
            if (indexPath.row == 0) {
                if (idx == self.idx1) {
                    tag.textColor = selectedColor;
                    tag.bgColor = [UIColor colorWithRed:arc4random()%256/255.0 green:arc4random()%256/255.0 blue:arc4random()%256/255.0 alpha:1];
                }
            } else {  // 第二个选择项
                if (idx == self.idx2) {
                    tag.textColor = selectedColor;
                    tag.bgColor = [UIColor colorWithRed:arc4random()%256/255.0 green:arc4random()%256/255.0 blue:arc4random()%256/255.0 alpha:1];
                }
            }
            [cell.tagView addTag:tag];
        }];
        
        // 每个标签的点击事件
        cell.tagView.didTapTagAtIndex = ^(NSUInteger index) {
            if (indexPath.row == 0) {
                self.idx1 = index;
            } else {
                self.idx2 = index;
            }
            NSLog(@"点击了第%ld行，第%ld个",indexPath.row, index);
            
            self.chooseLabel.text = [NSString stringWithFormat:@"%@:%@,%@:%@",[self.dataSource[0] allKeys][0],[self.dataSource[0] allValues][0][self.idx1],[self.dataSource[1] allKeys][0],[self.dataSource[1] allValues][0][self.idx2]];
            [self.tableView reloadData];
        };
    }
}


#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataSource.count + 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    // 数量Cell
    if (indexPath.row == self.dataSource.count) {
        NSString *ID = NSStringFromClass([ProductCountViewCell class]);
        ProductCountViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
        
        if (!cell) {
            cell = [[ProductCountViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
        }
        
        return cell;
    }
    
    // 选项Cell
    
    NSString *ID = NSStringFromClass([ProductTagViewCell class]);
    ProductTagViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    
    if (!cell) {
        cell = [[ProductTagViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    
    [self configTagCell:cell indexPath:indexPath];
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == self.dataSource.count) {
        // 数量cell时，固定为50高度
        return 50;
    }
    CGFloat height = [tableView fd_heightForCellWithIdentifier:NSStringFromClass([ProductTagViewCell class]) cacheByIndexPath:indexPath configuration:^(ProductTagViewCell * cell) {
        [self configTagCell:cell indexPath:indexPath];
    }];
    return height;
}

@end

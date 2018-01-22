//
//  ShoppingCartViewController.m
//  tbCart
//
//  Created by WangDongya on 2018/1/12.
//  Copyright © 2018年 wdy-test. All rights reserved.
//

#import "ShoppingCartViewController.h"
#import "ChooseGoodsViewController.h"
#import "ShoppingCartCell.h"
#import "ShoppingCartHeaderCell.h"
#import "AllModels.h"
#import "WDRequestHelper.h"
#import "RelatedProductCell.h"
#import "RelatedHeaderReusableView.h"

#import <JTSImageViewController/JTSImageInfo.h>
#import <JTSImageViewController/JTSImageViewController.h>
#import "UITableView+FDTemplateLayoutCell.h"
#import <MJRefresh/MJRefresh.h>
#import <Masonry/Masonry.h>
#import <SDWebImage/UIImageView+WebCache.h>

@interface ShoppingCartViewController () <UITableViewDelegate, UITableViewDataSource,
UICollectionViewDataSource, UICollectionViewDelegateFlowLayout,
ShoppingCartCellDelegate, ShoppingCartHeaderCellDelegate>

// 注意：UICollectionViewDelegateFlowLayout包含了UICollectionViewDelegate


//
@property (nonatomic, strong) ChooseGoodsViewController *chooseVC;

// 购买物品表
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *buyerList;
@property (nonatomic, strong) UIButton *rightBtn;
// 由于代理问题衍生出的，已经选择单个或者批量的数组装Cell
@property (nonatomic, strong) NSMutableArray *tempCellArray;


@property (nonatomic, strong) UIView *bottomView;
@property (nonatomic, strong) UIButton *allSelectedBtn;
// 底部统计View（normal）
@property (nonatomic, strong) UIView *normalBottomRightView;
@property (nonatomic, strong) UIButton *accountBtn;
@property (nonatomic, strong) UILabel *totalPriceLabel;
// 底部全局编辑控件（edit）
@property (nonatomic, strong) UIView *editBottomRightView;
@property (nonatomic, strong) UIButton *bottomDeleteBtn;
@property (nonatomic, strong) UIButton *editBaby;
@property (nonatomic, strong) UIButton *storeBtn;


// footerView
@property (nonatomic, strong) UIView *underFooterView;
// 相关产品的推荐Collection
@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) NSMutableArray *relatedProducts;



@end

@implementation ShoppingCartViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.view setBackgroundColor:[UIColor whiteColor]];
    
    // 添加导航部分
    [self setupNavi];
    // 设置底部
    [self setupBottomPanelView];
    // 设置中间tableView
    [self setupTableView];
}

#pragma mark - 设置tableview
- (void)setupTableView
{
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view);
        make.left.equalTo(self.view);
        make.right.equalTo(self.view);
        make.bottom.equalTo(self.bottomView.mas_top);
    }];
    
    // 添加刷新header
    MJRefreshNormalHeader *header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(refreshData)];
    header.stateLabel.hidden = YES;
    header.lastUpdatedTimeLabel.hidden = YES;
    self.tableView.mj_header = header;
    
    // 开始刷新
    [self.tableView.mj_header beginRefreshing];
}

#pragma mark - Event（事件）

- (void)refreshData
{
    self.totalPriceLabel.text = @"合计￥0.00";
    self.allSelectedBtn.selected = NO;
    self.rightBtn.selected = NO;
    
    __weak typeof(self) weakSelf = self;
    // 请求购物车数据
    [[WDRequestHelper sharedInstance] requestShoppingCartInfo:^(id obj, NSError *error) {
        // buyer array
        [weakSelf.buyerList removeAllObjects];
        weakSelf.buyerList = (NSMutableArray *)obj;
        [weakSelf.tableView reloadData];
        
        [weakSelf.tableView.mj_header endRefreshing];
        
        if (![[WDRequestHelper sharedInstance] isEmptyArray:weakSelf.buyerList]) {
            weakSelf.rightBtn.enabled = YES;
        }
    }];
    
    // 请求相关商品数据
    [[WDRequestHelper sharedInstance] requestMoreRecommandInfo:^(id obj, NSError *error) {
        [weakSelf.relatedProducts removeAllObjects];
        weakSelf.relatedProducts = [[NSMutableArray alloc] initWithArray:(NSArray *)obj];

        [weakSelf.collectionView reloadData];

        // 设置大小
        weakSelf.underFooterView.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, weakSelf.collectionView.collectionViewLayout.collectionViewContentSize.height);
        weakSelf.tableView.tableFooterView = weakSelf.underFooterView;
        
        NSLog(@"collection view height : %.f", weakSelf.collectionView.collectionViewLayout.collectionViewContentSize.height);
    }];
}

// 编辑全部产品
- (void)clickAllEdit:(UIButton *)btn
{
    btn.selected = !btn.selected;
    for (WDBuyerInfo *buyer in self.buyerList) {
        buyer.buyerIsEditing = btn.selected;
    }
    [self.tableView reloadData];
    self.editBottomRightView.hidden = !btn.selected;
}

// 底部全选
- (void)clickAllProductSelected:(UIButton *)sender {
    
    sender.selected = !sender.selected;
    for (WDBuyerInfo *buyer in self.buyerList) {
        buyer.buyerIsChoosed = sender.selected;
        for (WDProductInfo *product in buyer.prod_list) {
            product.productIsChoosed = buyer.buyerIsChoosed;
        }
    }
    [self.tableView reloadData];
    
    CGFloat totalPrice = [self countTotalPrice];
    self.totalPriceLabel.text = [NSString stringWithFormat:@"合计￥%.2f",totalPrice];
    [self.accountBtn setTitle:[NSString stringWithFormat:@"结算(%ld)",[self countTotalSelectedNumber]] forState:UIControlStateNormal];
    
}


#pragma mark - 设置导航部分
- (void)setupNavi
{
    // 添加标题
    self.title = @"购物车";
    // 添加编辑按钮
    [self.rightBtn addTarget:self action:@selector(clickAllEdit:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *barBtn = [[UIBarButtonItem alloc] initWithCustomView:self.rightBtn];
    self.navigationItem.rightBarButtonItem = barBtn;
}

#pragma mark - 设置底部编辑部分

- (void)setupBottomPanelView
{
    [self.view addSubview:self.bottomView];
    [self.bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view);
        make.bottom.equalTo(self.view);
        make.right.equalTo(self.view);
        make.height.mas_equalTo(50);
    }];
    
    [self.bottomView addSubview:self.allSelectedBtn];
    [self.allSelectedBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.bottomView).offset(20);
        make.centerY.equalTo(self.bottomView);
        
        make.width.mas_equalTo(70);
    }];
    
    // 底部结算部分
    [self.bottomView addSubview:self.normalBottomRightView];
    [self.normalBottomRightView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.bottomView);
        make.top.equalTo(self.bottomView);
        make.bottom.equalTo(self.bottomView);
        
        make.width.equalTo(self.bottomView).multipliedBy(0.75);
    }];
    [self.normalBottomRightView addSubview:self.accountBtn];
    [self.accountBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.normalBottomRightView);
        make.bottom.equalTo(self.normalBottomRightView);
        make.right.equalTo(self.normalBottomRightView);
    }];
    [self.normalBottomRightView addSubview:self.totalPriceLabel];
    [self.totalPriceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.normalBottomRightView);
        make.bottom.equalTo(self.normalBottomRightView);
        make.left.equalTo(self.normalBottomRightView);
        
        make.right.equalTo(self.accountBtn.mas_left).offset(-5);
        make.width.equalTo(self.accountBtn).multipliedBy(2.5);
    }];
    [self.normalBottomRightView setHidden:NO];
    
    // 底部编辑部分
    [self.bottomView addSubview:self.editBottomRightView];
    [self.editBottomRightView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.bottomView);
        make.top.equalTo(self.bottomView);
        make.bottom.equalTo(self.bottomView);
        
        make.width.equalTo(self.bottomView).multipliedBy(0.6);
    }];
    [self.editBottomRightView addSubview:self.bottomDeleteBtn];
    [self.bottomDeleteBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.editBottomRightView);
        make.bottom.equalTo(self.editBottomRightView);
        make.right.equalTo(self.editBottomRightView);
    }];
    [self.editBottomRightView addSubview:self.editBaby];
    [self.editBaby mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.editBottomRightView);
        make.left.equalTo(self.editBottomRightView);
        make.bottom.equalTo(self.editBottomRightView);

        make.width.equalTo(self.bottomDeleteBtn);
    }];
    [self.editBottomRightView addSubview:self.storeBtn];
    [self.storeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.editBottomRightView);
        make.bottom.equalTo(self.editBottomRightView);
        
        make.leading.equalTo(self.editBaby.mas_trailing).offset(1);
        make.trailing.equalTo(self.bottomDeleteBtn.mas_leading).offset(-1);
        
        make.width.equalTo(self.bottomDeleteBtn);
    }];
    
    [self.editBottomRightView setHidden:YES];
}


#pragma mark -

- (BOOL)isAllProductChoosed
{
    if ([[WDRequestHelper sharedInstance] isEmptyArray:self.buyerList]) {
        return NO;
    }
    NSInteger count = 0;
    for (WDBuyerInfo *buyer in self.buyerList) {
        if (buyer.buyerIsChoosed) {
            count++;
        }
    }
    
    return (count == self.buyerList.count);
}

- (NSInteger)countTotalSelectedNumber
{
    NSInteger count = 0;
    for (WDBuyerInfo *buyer in self.buyerList) {
        for (WDProductInfo *product in buyer.prod_list) {
            if (product.productIsChoosed) {
                count ++;
            }
        }
    }
    
    return count;
}

- (CGFloat)countTotalPrice
{
    CGFloat totalPrice = 0.0;
    for (WDBuyerInfo *buyer in self.buyerList) {
        if (buyer.buyerIsChoosed) {
            for (WDProductInfo *product in buyer.prod_list) {
                totalPrice += product.order_price * product.count;
            }
        } else {
            for (WDProductInfo *product in buyer.prod_list) {
                if (product.productIsChoosed) {
                    totalPrice += product.order_price * product.count;
                }
            }
        }
    }
    
    return totalPrice;
}


#pragma mark -  ShoppingCartCellDelegate
// 点击单个商品选择按钮回调
- (void)productSelected:(ShoppingCartCell *)cell isSelected:(BOOL)choosed
{
    NSIndexPath *indexPath = [self.tableView indexPathForCell:cell];
    WDBuyerInfo *buyer = self.buyerList[indexPath.section];
    WDProductInfo *product = buyer.prod_list[indexPath.row];
    product.productIsChoosed = !product.productIsChoosed;
    
    // 当点击单个的时候，判断是否该买手下面的商品是否全部选中
    __block NSInteger count = 0;
    [buyer.prod_list enumerateObjectsUsingBlock:^(WDProductInfo * obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if (obj.productIsChoosed) {
            count++;
        }
    }];
    
    if (count == buyer.prod_list.count) {
        buyer.buyerIsChoosed = YES;
    } else {
        buyer.buyerIsChoosed = NO;
    }
    
    [self.tableView reloadData];
    // 每次点击投影统计底部的按钮是否全选
    self.allSelectedBtn.selected = [self isAllProductChoosed];
    
    [self.accountBtn setTitle:[NSString stringWithFormat:@"结算(%ld)", [self countTotalSelectedNumber]] forState:UIControlStateNormal];
    self.totalPriceLabel.text = [NSString stringWithFormat:@"合计￥%.2f", [self countTotalPrice]];
}
// 点击垃圾桶删除
- (void)productGarbageClick:(ShoppingCartCell *)cell
{
    [self.tempCellArray removeAllObjects];
    [self.tempCellArray addObject:cell];
    
    UIAlertController *alertVC = [UIAlertController alertControllerWithTitle:@"确定删除？" message:@"" preferredStyle:UIAlertControllerStyleAlert];
    [alertVC addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
    }]];
    [alertVC addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        // 单个删除
    }]];
}
// 商品添加或减少回调
- (void)plusOrMinusCount:(ShoppingCartCell *)cell tag:(NSInteger)tag
{
    NSIndexPath *indexpath = [self.tableView indexPathForCell:cell];
    WDBuyerInfo *buyer = self.buyerList[indexpath.section];
    WDProductInfo *product = buyer.prod_list[indexpath.row];
    
    if (tag == 555) {
        if (product.count <= 1) {
            
        } else {
            product.count --;
        }
    } else if (tag == 666) {
        product.count++;
    }
    
    self.totalPriceLabel.text = [NSString stringWithFormat:@"合计￥%.2f", [self countTotalPrice]];
    [self.tableView reloadData];
}
// 点击编辑规格按钮下拉回调
- (void)clickEditingDetailInfo:(ShoppingCartCell *)cell
{
    // 编辑对应的商品信息
    self.chooseVC = nil;
    self.chooseVC = [[ChooseGoodsViewController alloc] init];
    self.chooseVC.enterType = SecondEnterType;
    self.chooseVC.price = 9999.99f;
    [self.navigationController presentSemiViewController:self.chooseVC
                                             withOptions:@{KNSemiModalOptionKeys.pushParentBack:@(YES),
                                                           KNSemiModalOptionKeys.animationDuration:@(0.6),
                                                           KNSemiModalOptionKeys.shadowOpacity:@(0.3),
                                                           KNSemiModalOptionKeys.backgroundView: [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"background_01"]]
                                                           }];
}
// 点击图片回调到主页显示
- (void)clickProductIMG:(ShoppingCartCell *)cell
{
    NSIndexPath *indexPath = [self.tableView indexPathForCell:cell];
    WDBuyerInfo *buyer = self.buyerList[indexPath.section];
    WDProductInfo *product = buyer.prod_list[indexPath.row];
    
    JTSImageInfo *imageInfo = [[JTSImageInfo alloc] init];
    imageInfo.imageURL = [NSURL URLWithString:product.image];
    JTSImageViewController *imageVC = [[JTSImageViewController alloc] initWithImageInfo:imageInfo mode:JTSImageViewControllerMode_Image backgroundStyle:JTSImageViewControllerBackgroundOption_Scaled];
    [imageVC showFromViewController:self transition:JTSImageViewControllerTransition_FromOffscreen];
}


#pragma mark -  ShoppingCartHeaderCellDelegate
// 点击buyer选择按钮回调
- (void)buyerSelected:(NSInteger)sectionIndex
{
    WDBuyerInfo *buyer = self.buyerList[sectionIndex];
    buyer.buyerIsChoosed = !buyer.buyerIsChoosed;
    [buyer.prod_list enumerateObjectsUsingBlock:^(WDProductInfo *obj, NSUInteger idx, BOOL * _Nonnull stop) {
        obj.productIsChoosed = buyer.buyerIsChoosed;
    }];
    [self.tableView reloadData];
    
    // 每次点击投影统计底部的按钮是否全选
    self.allSelectedBtn.selected = [self isAllProductChoosed];
    
    [self.accountBtn setTitle:[NSString stringWithFormat:@"结算(%ld)", [self countTotalSelectedNumber]] forState:UIControlStateNormal];
    self.totalPriceLabel.text = [NSString stringWithFormat:@"合计￥%.2f", [self countTotalPrice]];
}
// 点击buyer编辑按钮的回调
- (void)buyerEditingSelected:(NSInteger)sectionIndex
{
    WDBuyerInfo *buy = self.buyerList[sectionIndex];
    buy.buyerIsEditing = !buy.buyerIsEditing;
    [self.tableView reloadData];
}


#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.buyerList.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    WDBuyerInfo *buyer = self.buyerList[section];
    return buyer.prod_list.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *ID = NSStringFromClass([ShoppingCartCell class]);
    ShoppingCartCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (!cell) {
        cell = [[ShoppingCartCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    
    cell.delegate = self;
    [self configCell:cell indexPath:indexPath];
    
    return cell;
}

// tableView的sectionHeader加载数据
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    WDBuyerInfo *buyer = self.buyerList[section];
    ShoppingCartHeaderCell *header = [tableView dequeueReusableHeaderFooterViewWithIdentifier:NSStringFromClass([ShoppingCartHeaderCell class])];
    
    if (!header) {
        header = [[ShoppingCartHeaderCell alloc] initWithReuseIdentifier:NSStringFromClass([ShoppingCartHeaderCell class])];
    }
    
    [header.buyerImageView sd_setImageWithURL:[NSURL URLWithString:buyer.user_avatar]];
    header.headerSelectedBtn.selected = buyer.buyerIsChoosed;  // 买手是否需要勾选字段
    header.buyerNameLabel.text = buyer.nick_name;
    header.sectionIndex = section;
    header.editSectionHeaderBtn.selected = buyer.buyerIsEditing;
    
    if (self.rightBtn.selected) {
        header.editSectionHeaderBtn.hidden = YES;
    } else {
        header.editSectionHeaderBtn.hidden = NO;
    }
    
    header.delegate = self;
    
    return header;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    WDBuyerInfo *buyer = self.buyerList[indexPath.section];
    if (buyer.buyerIsEditing) {
        return 100;
    } else {
        CGFloat height = [tableView fd_heightForCellWithIdentifier:NSStringFromClass([ShoppingCartCell class]) configuration:^(ShoppingCartCell * cell) {
            [self configCell:cell indexPath:indexPath];
        }];
        return height >= 100 ? height : 100;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 50;
}

// 组装cell
- (void)configCell:(ShoppingCartCell *)cell indexPath:(NSIndexPath *)indexPath
{
    WDBuyerInfo *buyer = self.buyerList[indexPath.section];
    WDProductInfo *product = buyer.prod_list[indexPath.row];
    cell.leftChooseBtn.selected = product.productIsChoosed; // 商品是否被选中
    
    __weak typeof(cell) weakCell = cell;
    [cell.productImageView sd_setImageWithURL:[NSURL URLWithString:product.image] completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
        
        if (image && cacheType == SDImageCacheTypeNone) {
            weakCell.productImageView.alpha = 0;
            [UIView animateWithDuration:1.0 animations:^{
                weakCell.productImageView.alpha = 1.0f;
            }];
        } else {
            weakCell.productImageView.alpha = 1.0f;
        }
    }];
    
    cell.titleLabel.text = product.title;
    if ([[WDRequestHelper sharedInstance] isEmptyArray:product.model_detail]) {
        cell.sizeDetailLabel.text = @"";
        cell.editDetailView.hidden = YES;
    } else {
        cell.editDetailView.hidden = NO;
        cell.sizeDetailLabel.text = @"这里测试规格数据这里测试规格数据这里测试规格数据这里测试规格数据这里测试规格数据这里测试规格数据这里测试规格数据";
        cell.editDetailTitleLabel.text = @"点击我修改规格";
    }
    
    cell.priceLabel.attributedText = [[WDRequestHelper sharedInstance] recombinePrice:product.cn_price orderPrice:product.order_price];
    cell.countLabel.text = [NSString stringWithFormat:@"x%ld", product.count];
    cell.editCountLabel.text = [NSString stringWithFormat:@"%ld", product.count];
    
    // 正常模式下面，非编辑
    if (!buyer.buyerIsEditing) {
        cell.normalBackView.hidden = NO;
        cell.editBackView.hidden = YES;
    } else {
        cell.normalBackView.hidden = YES;
        cell.editBackView.hidden = NO;
    }
}

#pragma mark - UICollectionViewDataSource

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    NSLog(@"numberOfSectionsInCollectionView");
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.relatedProducts.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    // [collectionView dequeueReusableCellWithReuseIdentifier:@"" forIndexPath:indexPath];
    WDSingleProduct *product = self.relatedProducts[indexPath.item];
    RelatedProductCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([RelatedProductCell class]) forIndexPath:indexPath];
    
    __weak typeof(cell) weakCell = cell;
    [cell.imageView sd_setImageWithURL:[NSURL URLWithString:product.img] completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
        if (image && cacheType == SDImageCacheTypeNone) {
            weakCell.imageView.alpha = 0.0f;
            [UIView animateWithDuration:1.0f animations:^{
                weakCell.imageView.alpha = 1.0f;
            }];
        } else {
            weakCell.imageView.alpha = 1.0f;
        }
    }];
    
    cell.priceLabel.attributedText = [[WDRequestHelper sharedInstance] recombinePrice:product.cn_price orderPrice:product.order_price];
    cell.nameLabel.text = product.title;
    cell.contryLabel.text = product.user_id;
    
    return cell;
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"******-----------");
    // 如果是section头部
    if ([kind isEqualToString:UICollectionElementKindSectionHeader]) {
        RelatedHeaderReusableView *headerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:NSStringFromClass([RelatedHeaderReusableView class]) forIndexPath:indexPath];
//        [headerView setBackgroundColor:[UIColor redColor]];
        return headerView;
    }
    // 如果是section的footer部分
    else if ([kind isEqualToString:UICollectionElementKindSectionFooter]) {
        
    }
    
    return nil;
}




#pragma mark - UICollectionViewDelegateFlowLayout

// Item的大小
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    CGFloat width = ([UIScreen mainScreen].bounds.size.width - 30.0) / 2.0;
    CGFloat height = 250;
    return CGSizeMake(width, height);
}

//
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section
{
    return 10;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section
{
    return 10;
}

// Section内容缩进的边距
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(10, 10, 10, 10);
}

// SectionHeader的大小
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section
{
    NSLog(@"referenceSizeForHeaderInSection");
    return CGSizeMake([UIScreen mainScreen].bounds.size.width, 50);
}

#pragma mark - UICollectionViewDelegate



#pragma mark - 懒加载

- (UITableView *)tableView
{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        
        [_tableView registerClass:[ShoppingCartCell class] forCellReuseIdentifier:NSStringFromClass([ShoppingCartCell class])];
        [_tableView registerClass:[ShoppingCartHeaderCell class] forHeaderFooterViewReuseIdentifier:NSStringFromClass([ShoppingCartHeaderCell class])];
    }
    return _tableView;
}

- (UIButton *)rightBtn
{
    if (!_rightBtn) {
        _rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_rightBtn setFrame:CGRectMake(0, 0, 40, 40)];
        [_rightBtn setTitle:@"编辑" forState:UIControlStateNormal];
        [_rightBtn setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
        [_rightBtn setTitle:@"完成" forState:UIControlStateSelected];
        [_rightBtn setTitleColor:[UIColor blueColor] forState:UIControlStateSelected];
        // 不可用状态
        [_rightBtn setTitle:@"编辑" forState:UIControlStateDisabled];
        [_rightBtn setTitleColor:[UIColor lightGrayColor] forState:UIControlStateDisabled];
    }
    return _rightBtn;
}

- (UIView *)bottomView
{
    if (!_bottomView) {
        _bottomView = [[UIView alloc] init];
    }
    return _bottomView;
}

- (UIButton *)allSelectedBtn
{
    if (!_allSelectedBtn) {
        _allSelectedBtn = [[UIButton alloc] init];
        [_allSelectedBtn setTitle:@"全选" forState:UIControlStateNormal];
        [_allSelectedBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [_allSelectedBtn.titleLabel setFont:[UIFont boldSystemFontOfSize:15]];
        [_allSelectedBtn setImage:[UIImage imageNamed:@"checkbox_0"] forState:UIControlStateNormal];
        [_allSelectedBtn setImage:[UIImage imageNamed:@"checkbox_1"] forState:UIControlStateSelected];
        
        [_allSelectedBtn addTarget:self action:@selector(clickAllProductSelected:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _allSelectedBtn;
}

- (UIView *)normalBottomRightView
{
    if (!_normalBottomRightView) {
        _normalBottomRightView = [[UIView alloc] init];
    }
    return _normalBottomRightView;
}

- (UIButton *)accountBtn
{
    if (!_accountBtn) {
        _accountBtn = [[UIButton alloc] init];
        [_accountBtn setTitle:@"结算(0)" forState:UIControlStateNormal];
        [_accountBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_accountBtn setBackgroundColor:[UIColor redColor]];
    }
    return _accountBtn;
}

- (UILabel *)totalPriceLabel
{
    if (!_totalPriceLabel) {
        _totalPriceLabel = [[UILabel alloc] init];
        _totalPriceLabel.text = @"￥9999.99";
        _totalPriceLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _totalPriceLabel;
}

- (UIView *)editBottomRightView
{
    if (!_editBottomRightView) {
        _editBottomRightView = [[UIView alloc] init];
    }
    return _editBottomRightView;
}

- (UIButton *)bottomDeleteBtn
{
    if (!_bottomDeleteBtn) {
        _bottomDeleteBtn = [[UIButton alloc] init];
        [_bottomDeleteBtn setTitle:@"删除选中" forState:UIControlStateNormal];
        [_bottomDeleteBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_bottomDeleteBtn setBackgroundColor:[UIColor colorWithRed:1 green:0 blue:0 alpha:1]];
        [_bottomDeleteBtn setTitleEdgeInsets:UIEdgeInsetsMake(0, 0, 0, 0)];
        [_bottomDeleteBtn setImageEdgeInsets:UIEdgeInsetsZero];
        [_bottomDeleteBtn.titleLabel setFont:[UIFont systemFontOfSize:15]];
    }
    return _bottomDeleteBtn;
}

-(UIButton *)editBaby
{
    if (!_editBaby) {
        _editBaby = [[UIButton alloc] init];
        [_editBaby setTitle:@"分享宝贝" forState:UIControlStateNormal];
        [_editBaby setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_editBaby setBackgroundColor:[UIColor colorWithRed:1 green:0 blue:0 alpha:0.5]];
        [_editBaby setTitleEdgeInsets:UIEdgeInsetsMake(0, 0, 0, 0)];
        [_editBaby setImageEdgeInsets:UIEdgeInsetsZero];
        [_editBaby.titleLabel setFont:[UIFont systemFontOfSize:15]];
    }
    return _editBaby;
}

- (UIButton *)storeBtn
{
    if (!_storeBtn) {
        _storeBtn = [[UIButton alloc] init];
        [_storeBtn setTitle:@"关注店铺" forState:UIControlStateNormal];
        [_storeBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_storeBtn setBackgroundColor:[UIColor colorWithRed:1 green:0 blue:0 alpha:0.5]];
        [_storeBtn setTitleEdgeInsets:UIEdgeInsetsMake(0, 0, 0, 0)];
        [_storeBtn setImageEdgeInsets:UIEdgeInsetsZero];
        [_storeBtn.titleLabel setFont:[UIFont systemFontOfSize:15]];
    }
    return _storeBtn;
}

- (NSMutableArray *)buyerList
{
    if (_buyerList == nil) {
        _buyerList = [[NSMutableArray alloc] init];
    }
    return _buyerList;
}

- (NSMutableArray *)tempCellArray
{
    if (_tempCellArray == nil) {
        _tempCellArray = [[NSMutableArray alloc] init];
    }
    return _tempCellArray;
}

- (NSMutableArray *)relatedProducts
{
    if (_relatedProducts == nil) {
        _relatedProducts = [[NSMutableArray alloc] init];
    }
    return _relatedProducts;
}

- (UIView *)underFooterView
{
    if (!_underFooterView) {
        _underFooterView = [[UIView alloc] init];
        [_underFooterView setBackgroundColor:[UIColor whiteColor]];
        
        [_underFooterView addSubview:self.collectionView];
        [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.leading.equalTo(_underFooterView);
            make.top.equalTo(_underFooterView);
            make.trailing.equalTo(_underFooterView);
            make.bottom.equalTo(_underFooterView);
        }];
    }
    return _underFooterView;
}

- (UICollectionView *)collectionView
{
    if (!_collectionView) {
        
        UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
        flowLayout.scrollDirection = UICollectionViewScrollDirectionVertical;
        
        CGRect frame = CGRectMake( 0, 0, [UIScreen mainScreen].bounds.size.width, 0);
        _collectionView = [[UICollectionView alloc] initWithFrame:frame collectionViewLayout:flowLayout];
        _collectionView.backgroundColor = [UIColor whiteColor];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        // 注册头部
        [_collectionView registerClass:[RelatedHeaderReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:NSStringFromClass([RelatedHeaderReusableView class])];
        // 注册Cell
        [_collectionView registerClass:[RelatedProductCell class] forCellWithReuseIdentifier:NSStringFromClass([RelatedProductCell class])];
    }
    return _collectionView;
}


@end

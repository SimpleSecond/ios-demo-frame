//
//  ViewController.m
//  tbCart
//
//  Created by WangDongya on 2018/1/9.
//  Copyright © 2018年 wdy-test. All rights reserved.
//

#import "ViewController.h"
#import "ChooseGoodsViewController.h"
#import "ShoppingCartViewController.h"
#import <Masonry/Masonry.h>
#import <WZLBadge/WZLBadgeImport.h>


@interface ViewController ()

@property (nonatomic, strong) UIImageView *shoppingCart;
@property (nonatomic, strong) ChooseGoodsViewController *chooseVC;

@end

@implementation ViewController

- (UIImageView *)shoppingCart
{
    if (!_shoppingCart) {
        _shoppingCart = [[UIImageView alloc] init];
        _shoppingCart.image = [UIImage imageNamed:@"shoppingCart"];
        _shoppingCart.badgeBgColor = [UIColor blueColor];
        _shoppingCart.badgeTextColor = [UIColor whiteColor];
        _shoppingCart.badgeFont = [UIFont systemFontOfSize:11];
        _shoppingCart.badgeMaximumBadgeNumber = 99;
        _shoppingCart.badgeCenterOffset = CGPointMake(20, 0);
        [_shoppingCart showBadgeWithStyle:WBadgeStyleNumber value:100 animationType:WBadgeAnimTypeScale];
    }
    return _shoppingCart;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.view addSubview:self.shoppingCart];
    [self.shoppingCart mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self.view);
        
        make.width.mas_equalTo(20);
        make.height.mas_equalTo(20);
    }];
    
    // 添加手势
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(show:)];
    [self.shoppingCart addGestureRecognizer:tap];
    self.shoppingCart.userInteractionEnabled = YES;
}

- (void)show:(UITapGestureRecognizer *)tap
{
    if (!self.chooseVC) {
        self.chooseVC = [[ChooseGoodsViewController alloc] init];
    }
    
    self.chooseVC.enterType = FirstEnterType;
    __weak typeof(self) weakself = self;
    self.chooseVC.callback = ^{
        NSLog(@"点击回调购物车...");
        // 下面一定要移除，不然控制器结构就乱了，基本逻辑层级已经写在上面了，这个效果其实是addChildVC来的，
        // 最后的展示是在window上的，一定要移除
        [weakself.chooseVC.view removeFromSuperview];
        [weakself.chooseVC removeFromParentViewController];
        weakself.chooseVC.view  = nil;
        weakself.chooseVC = nil;
        
        ShoppingCartViewController *shoppingCart = [ShoppingCartViewController new];
        [weakself.navigationController pushViewController:shoppingCart animated:YES];
    };
    self.chooseVC.price = 256.f;
    [self.navigationController presentSemiViewController:self.chooseVC
                                             withOptions:@{
                                                           KNSemiModalOptionKeys.pushParentBack:@(NO),
                                                           KNSemiModalOptionKeys.animationDuration:@(0.6),
                                                           KNSemiModalOptionKeys.shadowOpacity:@(0.3),
                                                           KNSemiModalOptionKeys.backgroundView:[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"background_01"]]
                                                           }];
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}


@end

//
//  WDEssenceViewController.m
//  frame-bsbdj
//
//  Created by WangDongya on 2017/12/5.
//  Copyright © 2017年 example. All rights reserved.
//

#import "WDEssenceViewController.h"
#import "WDEssTitleButton.h"
#import "WDEssAllController.h"
#import "WDEssVideoController.h"
#import "WDEssAudioController.h"
#import "WDEssPhotoController.h"
#import "WDEssEpisodeController.h"
#import "WDRecommenTagViewController.h"


@interface WDEssenceViewController () <UIScrollViewDelegate>

@property (nonatomic, strong) NSMutableArray *titleButtonArray;
@property (nonatomic, strong) WDEssTitleButton *selectedTitleButton;
@property (nonatomic, strong) UIView *indicatorView;
@property (nonatomic, strong) UIScrollView *contentScrollView;

@end

@implementation WDEssenceViewController

-(NSMutableArray *)titleButtonArray
{
    if (!_titleButtonArray) {
        _titleButtonArray = [NSMutableArray array];
    }
    return _titleButtonArray;
}

-(UIView *)indicatorView
{
    if (!_indicatorView) {
        _indicatorView = [[UIView alloc] init];
        _indicatorView.backgroundColor = [UIColor redColor];
    }
    return _indicatorView;
}

-(UIScrollView *)contentScrollView
{
    if (!_contentScrollView) {
        _contentScrollView = [[UIScrollView alloc] init];
        // 开启分页
        _contentScrollView.pagingEnabled = YES;
        // 隐藏横向和纵向指示器
        _contentScrollView.showsVerticalScrollIndicator = NO;
        _contentScrollView.showsHorizontalScrollIndicator = NO;
        // 设置代理
        _contentScrollView.delegate = self;
    }
    return _contentScrollView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    // 加载自控制器
    [self setupChildViewControllers];
    
    // 设置导航
    [self setupNav];
    // 设置内容容器
    [self setupContentScrollView];
    // 设置titleView
    [self setupTitleView];
    // 添加默认自控制区视图
    [self addChildVcView];
}

- (void)setupChildViewControllers
{
    WDEssAllController *allVc = [[WDEssAllController alloc] init];
    [self addChildViewController:allVc];
    WDEssVideoController *videoVc = [[WDEssVideoController alloc] init];
    [self addChildViewController:videoVc];
    WDEssPhotoController *photoVc = [[WDEssPhotoController alloc] init];
    [self addChildViewController:photoVc];
    WDEssAudioController *audioVc = [[WDEssAudioController alloc] init];
    [self addChildViewController:audioVc];
    WDEssEpisodeController *epiVc = [[WDEssEpisodeController alloc] init];
    [self addChildViewController:epiVc];
}

- (void)addChildVcView
{
    // 子控制器的索引
    NSUInteger index = self.contentScrollView.contentOffset.x / self.contentScrollView.wd_width;
    
    // 取出子控制器
    UIViewController *childVc = self.childViewControllers[index];
    if ([childVc isViewLoaded]) return;
    
    childVc.view.frame = self.contentScrollView.bounds;
    [self.contentScrollView addSubview:childVc.view];
}


-(void)setupContentScrollView
{
    // 禁止自动调整
    self.automaticallyAdjustsScrollViewInsets = NO;
    // 禁止自动调整
    self.contentScrollView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    
    // 设置contentScrollView的大小
    [self.contentScrollView setFrame:self.view.bounds];
    // 设置内容大小
    [self.contentScrollView setContentSize:CGSizeMake(SCREEN_WIDTH * 5, SCREEN_HEIGHT)];
    [self.view addSubview:self.contentScrollView];
}

-(void)setupTitleView
{
    UIView *titleView = [[UIView alloc] initWithFrame:CGRectMake(0, 64, SCREEN_WIDTH, 35)];
    titleView.backgroundColor = [[UIColor whiteColor] colorWithAlphaComponent:0.7];
    [self.view addSubview:titleView];
    
    // 循环添加titleView子视图
    NSArray *titles = @[@"全部", @"视频", @"图片", @"声音", @"段子"];
    NSUInteger count = titles.count;
    CGFloat titleW = titleView.wd_width / count;
    CGFloat titleH = titleView.wd_height;
    for (int i=0; i<count; i++) {
        WDEssTitleButton *btn = [WDEssTitleButton buttonWithType:UIButtonTypeCustom];
        [btn setTitle:titles[i] forState:UIControlStateNormal];
        btn.frame = CGRectMake(i*titleW, 0, titleW, titleH);
        // 添加点击事件
        [btn addTarget:self action:@selector(titleClick:) forControlEvents:UIControlEventTouchUpInside];
        
        // 如果是第一个，则需要设置选中状态
        if (i==0) {
            // 设置选中按钮
            btn.selected = YES;
            self.selectedTitleButton = btn;
            
            // 设置指示器
            [btn.titleLabel sizeToFit];
            self.indicatorView.frame = CGRectMake(0, titleH-2, btn.titleLabel.wd_width+10, 2);
            self.indicatorView.wd_centerX = btn.wd_centerX;
            [titleView addSubview:self.indicatorView];
            // 设置第一个自控制器视图的显示
            [self loadChildView];
        }
        [titleView addSubview:btn];
        [self.titleButtonArray addObject:btn];
    }
}

-(void)titleClick:(WDEssTitleButton *)sender
{
    // 选中按钮的切换
    self.selectedTitleButton.selected = NO;
    sender.selected = YES;
    self.selectedTitleButton = sender;
    // 动画移动指示下划线
    [UIView animateWithDuration:0.25 animations:^{
        self.indicatorView.wd_width = sender.titleLabel.wd_width + 10;
        self.indicatorView.wd_centerX = sender.wd_centerX;
    }];
    
    NSUInteger index = [self.titleButtonArray indexOfObject:sender];
    // scrollView 移动
    [self.contentScrollView scrollRectToVisible:CGRectMake(index*SCREEN_WIDTH, 0, SCREEN_WIDTH, SCREEN_HEIGHT) animated:YES];
}

// 加载子控制器的视图
-(void)loadChildView
{
    NSUInteger index = self.contentScrollView.contentOffset.x / self.contentScrollView.wd_width;
    // 加载视图
    UIViewController *viewController = self.childViewControllers[index];
    if (viewController.view.superview != nil) {
        return;
    }
    viewController.view.frame = self.contentScrollView.bounds;
    [self.contentScrollView addSubview:viewController.view];
}

-(void)setupNav
{
    // 标题
    self.navigationItem.titleView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"MainTitle"]];
    // 左边
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithImage:@"MainTagSubIcon" highImage:@"MainTagSubIconClick" target:self action:@selector(tagSubIconClick)];
}

- (void)tagSubIconClick
{
    // 进入推荐界面
    WDRecommenTagViewController *viewCtrl = [[WDRecommenTagViewController alloc] init];
    [self.navigationController pushViewController:viewCtrl animated:YES];
}

#pragma mark - UIScrollViewDelegate
// 通过代码滑动结束后，调用该方法
-(void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView
{
    [self loadChildView];
}
// 用户手动左右拖拽结束后，调用该方法
-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    NSUInteger index = scrollView.bounds.origin.x / self.contentScrollView.wd_width;
    // 点击按钮
    [self titleClick:self.titleButtonArray[index]];
    // 加载子视图
    [self loadChildView];
}

@end

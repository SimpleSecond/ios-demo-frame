//
//  WDYHomeController.m
//  frame-news
//
//  Created by WangDongya on 2017/11/28.
//  Copyright © 2017年 example. All rights reserved.
//

#import "WDYHomeController.h"
#import "WDYHotController.h"
#import "WDYTopController.h"
#import "WDYVideoController.h"
#import "WDYSocialController.h"
#import "WDYPhotoController.h"
#import "WDYScienceController.h"
#import "WDYCarController.h"
#import "WDYArmyController.h"


@interface WDYHomeController () <UIScrollViewDelegate>

@property (nonatomic, strong) UIScrollView *titleScrollView;   // 顶部title
@property (nonatomic, strong) UIScrollView *contentScrollView; // 底部内容

// 子控制器
@property (nonatomic, strong) NSMutableArray *childControllers;
// 控制器对应的标题(UILabel的集合)
@property (nonatomic, strong) NSMutableArray *titleArray;
// 选中的UILabel
@property (nonatomic, strong) UILabel *selectedTitle;


@end

@implementation WDYHomeController


- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view setBackgroundColor:[UIColor whiteColor]];
    // 设置标题
    [self setTitle:@"网易新闻"];
    // 加载视图，布局视图
    [self loadSubviews];
    // 加载子控制器，及对应的标题
    [self loadChildControllers];
    
    // 子控制器的添加，及标题的添加
    [self addSubControllers];
}

#pragma mark - 标题点击事件

- (void)titleTapGesture:(UITapGestureRecognizer *)tap
{
    // 选中Label
    UILabel *tapLabel = (UILabel *)tap.view;
    [self selectTitleLabel:tapLabel];
    
    // 将内容滚动到对应的位置
    NSUInteger index = tapLabel.tag;
    self.contentScrollView.contentOffset = CGPointMake(SCREEN_WIDTH * index, 0);
    
    // 添加对应的视图View
    [self showVC:index];
    
    // 将选中的Label居中
    [self setUpTitleCenter:tapLabel];
}

// 选中Label
- (void)selectTitleLabel:(UILabel *)label
{
    // 取消高亮
    self.selectedTitle.highlighted = NO;
    // 取消形变
    self.selectedTitle.transform = CGAffineTransformIdentity;
    // 取消颜色
    self.selectedTitle.textColor = [UIColor blackColor];
    
    label.highlighted = YES;
    label.transform = CGAffineTransformMakeScale(1.3, 1.3);
    self.selectedTitle = label;
    
}

// 居中Label
- (void)setUpTitleCenter:(UILabel *)centerLabel
{
    CGFloat labelCenterX = centerLabel.center.x;
    CGFloat contentWidth = self.titleScrollView.contentSize.width;
    CGFloat halfScreenWidth = SCREEN_WIDTH / 2;
    // 偏移量
    CGFloat offsetX = labelCenterX - halfScreenWidth;
    // 最小值
    if (offsetX < 0) {
        offsetX = 0;
    }
    // 最大值
    if (offsetX >= contentWidth - SCREEN_WIDTH) {
        offsetX = contentWidth - SCREEN_WIDTH;
    }
    // 滚动
    [self.titleScrollView setContentOffset:CGPointMake(offsetX, 0) animated:YES];
}

// 显示一个视图
- (void)showVC:(NSUInteger)index
{
    UIViewController *viewCtrl = (UIViewController *)self.childControllers[index];
    if (viewCtrl.isViewLoaded) {
        return;
    }
    [viewCtrl.view setFrame:CGRectMake(index * SCREEN_WIDTH, 0, self.contentScrollView.frame.size.width, self.contentScrollView.frame.size.height)];
    [self.contentScrollView addSubview:viewCtrl.view];
}

#pragma mark - UIScrollViewDelegate
-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    CGFloat curPage = scrollView.contentOffset.x / SCREEN_WIDTH;
    
    // 左边label
    NSInteger leftIndex = curPage;
    // 右边label
    NSInteger rightIndex = leftIndex + 1;
    //
    UILabel *leftLabel = self.titleArray[leftIndex];
    UILabel *rightLabel;
    if (rightIndex < self.titleArray.count - 1) {
        rightLabel = self.titleArray[rightIndex];
    }
    // 左右缩放比例
    CGFloat rightScale = curPage - leftIndex;
    CGFloat leftScale = 1 - rightScale;
    
    // 缩放
    leftLabel.transform = CGAffineTransformMakeScale(leftScale*0.3 + 1, leftScale*0.3 + 1);
    rightLabel.transform = CGAffineTransformMakeScale(rightScale*0.3 + 1, rightScale*0.3 + 1);
    
    // 颜色
    leftLabel.textColor = [UIColor colorWithRed:leftScale green:0 blue:0 alpha:1];
    rightLabel.textColor = [UIColor colorWithRed:rightScale green:0 blue:0 alpha:1];
    
}

-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    // 计算页码数
    NSUInteger pageNo = scrollView.contentOffset.x / SCREEN_WIDTH;
    
    // UILabel的改变
    UILabel *label = (UILabel *)self.titleArray[pageNo];
    [self selectTitleLabel:label];
    
    // 添加对应的视图View
    [self showVC:pageNo];
    
    // UILabel居中
    [self setUpTitleCenter:label];
}


#pragma mark - 视图初始化及子控制器的添加

- (UIScrollView *)titleScrollView
{
    if (!_titleScrollView) {
        _titleScrollView = [[UIScrollView alloc] init];
        _titleScrollView.showsHorizontalScrollIndicator = NO;
    }
    return _titleScrollView;
}
- (UIScrollView *)contentScrollView
{
    if (!_contentScrollView) {
        _contentScrollView = [[UIScrollView alloc] init];
        _contentScrollView.showsHorizontalScrollIndicator = NO;
        _contentScrollView.bounces = NO;
        _contentScrollView.pagingEnabled = YES;
        _contentScrollView.delegate = self;
    }
    return _contentScrollView;
}
- (NSMutableArray *)childControllers
{
    if (!_childControllers) {
        _childControllers = [NSMutableArray array];
    }
    return _childControllers;
}
- (NSMutableArray *)titleArray
{
    if (!_titleArray) {
        _titleArray = [NSMutableArray array];
    }
    return _titleArray;
}

- (void)loadSubviews
{
    // 标题
    [self.view addSubview:self.titleScrollView];
    [self.titleScrollView setBackgroundColor:[UIColor lightGrayColor]];
    // 内容
    [self.view addSubview:self.contentScrollView];
    
    // 调整布局()
    self.titleScrollView.frame = CGRectMake(0, 64, SCREEN_WIDTH, 50);
    self.contentScrollView.frame = CGRectMake(0, CGRectGetMaxY(self.titleScrollView.frame), SCREEN_WIDTH, SCREEN_HEIGHT - 50 - CGRectGetMaxY(self.titleScrollView.frame));
}

- (void)loadChildControllers
{
    WDYTopController *topCtrl = [[WDYTopController alloc] init];
    topCtrl.title = @"推荐";
    [self.childControllers addObject:topCtrl];
    WDYHotController *hotCtrl = [[WDYHotController alloc] init];
    hotCtrl.title = @"热点";
    [self.childControllers addObject:hotCtrl];
    WDYVideoController *videoCtrl = [[WDYVideoController alloc] init];
    videoCtrl.title = @"视频";
    [self.childControllers addObject:videoCtrl];
    WDYSocialController *socialCtrl = [[WDYSocialController alloc] init];
    socialCtrl.title = @"社会";
    [self.childControllers addObject:socialCtrl];
    WDYPhotoController *photoCtrl = [[WDYPhotoController alloc] init];
    photoCtrl.title = @"图片";
    [self.childControllers addObject:photoCtrl];
    WDYScienceController *scienceCtrl = [[WDYScienceController alloc] init];
    scienceCtrl.title = @"科技";
    [self.childControllers addObject:scienceCtrl];
    WDYCarController *carCtrl = [[WDYCarController alloc] init];
    carCtrl.title = @"汽车";
    [self.childControllers addObject:carCtrl];
    WDYArmyController *armyCtrl = [[WDYArmyController alloc] init];
    armyCtrl.title = @"军事";
    [self.childControllers addObject:armyCtrl];
}
- (void)addSubControllers
{
    // 为每个子控制器添加对应的UILabel
    CGFloat itemWidth = 100;
    NSUInteger count = self.childControllers.count;
    for (int i=0; i<count; i++) {
        UILabel *item = [[UILabel alloc] init];
        item.text = ((UIViewController *)self.childControllers[i]).title;
        item.textAlignment = NSTextAlignmentCenter;
        item.frame = CGRectMake(i*itemWidth, 0, itemWidth, 50);
        item.textColor = [UIColor blackColor];
        item.font = [UIFont boldSystemFontOfSize:15];
        item.highlightedTextColor = [UIColor redColor];
        item.userInteractionEnabled = YES;
        item.tag = i;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(titleTapGesture:)];
        [item addGestureRecognizer:tap];
        
        [self.titleScrollView addSubview:item];
        // 添加的集合中
        [self.titleArray addObject:item];
        
        if (i == 0) {
            [self titleTapGesture: tap];
        }
    }
    
    // 设置Scroll内容大小
    [self.titleScrollView setContentSize:CGSizeMake(count * itemWidth, 0)];
    [self.contentScrollView setContentSize:CGSizeMake(count * SCREEN_WIDTH, 0)];
    
    // 初始化时，默认选中第一个title
//    self.selectedTitle = (UILabel *)self.titleArray[0];
//    self.selectedTitle.highlighted = YES;
    // 初始化时，默认显示第一个控制器
    [self.contentScrollView addSubview:((UIViewController *)self.childControllers[0]).view];
}
@end

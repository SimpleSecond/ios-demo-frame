//
//  WDMeFooterView.m
//  frame-bsbdj
//
//  Created by WangDongya on 2017/12/7.
//  Copyright © 2017年 example. All rights reserved.
//

#import "WDMeFooterView.h"
#import <AFNetworking/AFNetworking.h>
#import <MJExtension/MJExtension.h>
#import "WDMeSquare.h"
#import "WDMeSquareButton.h"
#import "WDMeWebViewController.h"
#import <SafariServices/SafariServices.h>

@implementation WDMeFooterView

-(instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self loadDatas];
    }
    return self;
}


- (void)loadDatas
{
    // http://api.budejie.com/api/api_open.php?a=square&c=topic
    
    // 参数
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"a"] = @"square";
    params[@"c"] = @"topic";
    
    // 请求
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    // manager.securityPolicy.validatesDomainName = YES;
    [manager GET:@"http://api.budejie.com/api/api_open.php" parameters:params progress:^(NSProgress * _Nonnull downloadProgress) {
        // 进度
        WDLog(@"%zd  ->  %zd", downloadProgress.completedUnitCount, downloadProgress.totalUnitCount)
    } success:^(NSURLSessionDataTask * _Nonnull task, NSDictionary *  _Nullable responseObject) {
        NSArray *squareList = [WDMeSquare mj_objectArrayWithKeyValuesArray:responseObject[@"square_list"]];
        
        [self createSquares:squareList];
        // NSLog(@"%zd", squareList.count);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];
}

- (void)createSquares:(NSArray *)squareList
{
    // 方块格式
    NSUInteger count = squareList.count;
    
    // 方块尺寸
    int maxColsCount = 4;
    CGFloat buttonW = SCREEN_WIDTH / maxColsCount;
    CGFloat buttonH = buttonW;
    
    // 创建所有方块
    for (NSUInteger i=0; i<count; i++) {
        // i位置对应的模型数据
        WDMeSquare *square = squareList[i];
        
        // 创建按钮
        WDMeSquareButton *button = [WDMeSquareButton buttonWithType:UIButtonTypeCustom];
        [self addSubview:button];
        
        // 设置frame
        button.wd_x = (i%maxColsCount)*buttonW;
        button.wd_y = (i/maxColsCount)*buttonH;
        button.wd_width = buttonW;
        button.wd_height = buttonH;
        
        button.square = square;
        
        [button addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    
    self.wd_height = self.subviews.lastObject.wd_bottom;
    
    UITableView *tableView = (UITableView *)self.superview;
    tableView.tableFooterView = self;
    // 重新刷新数据，重新计算contentSize
    [tableView reloadData];
    // 去掉底部多出的部分
    // tableView.contentSize = CGSizeMake(0, self.wd_bottom); // 不靠谱的解决方案
}

- (void)buttonClick:(WDMeSquareButton *)btn
{
    
    WDMeSquare *square = btn.square;
    if ([square.url hasPrefix:@"http"]) {
        
        WDMeWebViewController *webVC = [[WDMeWebViewController alloc] init];
        webVC.urlStr = square.url;
        webVC.title = square.name;
        UITabBarController *tabVC = (UITabBarController *)self.window.rootViewController;
        UINavigationController *navVC = tabVC.selectedViewController;
        
        // 使用Safari浏览器
//        SFSafariViewController *safariVC = [[SFSafariViewController alloc] initWithURL:[NSURL URLWithString:square.url]];
//        [tabVC presentViewController:safariVC animated:YES completion:nil];
//        [navVC pushViewController:safariVC animated:YES];
        [navVC pushViewController:webVC animated:YES];
        
    } else if ([square.url hasPrefix:@"mod"]) {
        // 审帖 mod://BDJ_To_Check
        // 我的收藏 mod://BDJ_To_Mine@dest=2
        // 排行榜 mod://BDJ_To_RankingList
        // 我的帖子 mod://BDJ_To_Mine@dest=1
        // 搜索 mod://App_To_SearchUser
        // 百思会员 mod://BDJ_To_VipPay
        // 产品体验官 mod://App_To_ActivityDetail@id=42835
        // 头条新闻 mod://BDJ_To_360News
        // 联通免流量 mod://BDJ_To_FreeTraffic
        // 下载视频 mod://App_To_MyVideo
        // 美女直播 mod://BDJ_To_SixRooms
        // 热门小说 mod://BDJ_To_HuaXiReader
        // 随机穿越 mod://BDJ_To_Cate@cate=3#type=0
        // 动态视频桌面 mod://BDJ_To_WallPaper
        // 每日排行 mod://BDJ_To_RecentHot
        //
        NSLog(@"自定义mod协议");
        
    } else {
        NSLog(@"不是http或mod协议");
    }
    
}

@end

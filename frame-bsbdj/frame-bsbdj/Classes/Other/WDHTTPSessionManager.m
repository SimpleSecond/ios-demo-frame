//
//  WDHTTPSessionManager.m
//  frame-bsbdj
//
//  Created by WangDongya on 2017/12/21.
//  Copyright © 2017年 example. All rights reserved.
//

#import "WDHTTPSessionManager.h"

@implementation WDHTTPSessionManager

-(instancetype)initWithBaseURL:(NSURL *)url
{
    if (self = [super initWithBaseURL:url]) {
//        self.securityPolicy.validatesDomainName = NO;
//        self.responseSerializer = nil;
//        self.requestSerializer = nil;
    }
    return self;
}

@end

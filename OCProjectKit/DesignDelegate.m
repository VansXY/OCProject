//
//  DesignDelegate.m
//  OCProjectKit
//
//  Created by HXB-xiaoYang on 2018/5/15.
//Copyright © 2018年 VansXY. All rights reserved.
//

#import "DesignDelegate.h"

/// 设计模式的学习
@implementation DesignDelegate

static DesignDelegate *shareHandle = nil;

+ (DesignDelegate *)shareHandle {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        shareHandle = [[DesignDelegate alloc] init];
    });
    return shareHandle;
}




@end

//
//  XYKeyChainManager.m
//  OCProjectKit
//
//  Created by HXB-xiaoYang on 2018/3/29.
//Copyright © 2018年 VansXY. All rights reserved.
//

#import "XYKeyChainManager.h"

@implementation XYKeyChainManager

+ (XYKeyChainManager *)shareHandle {
    static XYKeyChainManager *shareHandle = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        shareHandle = [[XYKeyChainManager alloc] init];
        shareHandle.keyChain = [UICKeyChainStore keyChainStoreWithService:server];
    });
    return shareHandle;
}

- (NSString *)token {
    NSString *token = self.keyChain[@"token"];
    return token?:@"";
}


@end

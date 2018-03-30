//
//  XYKeyChainManager.h
//  OCProjectKit
//
//  Created by HXB-xiaoYang on 2018/3/29.
//Copyright © 2018年 VansXY. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UICKeyChainStore.h>

static NSString *const server = @"OCProject";

#define XYKeyChain [XYKeyChainManager shareHandle]

@interface XYKeyChainManager : NSObject

@property (nonatomic, strong) UICKeyChainStore *keyChain;
@property (nonatomic, strong) NSString *token;

+ (XYKeyChainManager *)shareHandle;



@end

//
//  XYNetworkManager.h
//  OCProjectKit
//
//  Created by HXB-xiaoYang on 2018/4/9.
//  Copyright © 2018年 VansXY. All rights reserved.
//

#import <Foundation/Foundation.h>
@class XYBaseRequest;

@interface XYNetworkManager : NSObject

+ (instancetype)sharedManager;

- (void)addRequest:(XYBaseRequest *)request;

- (void)addRequest:(XYBaseRequest *)request withHUD:(NSString *)content;

- (void)addRequestWithAnimation:(XYBaseRequest *)request;

@end

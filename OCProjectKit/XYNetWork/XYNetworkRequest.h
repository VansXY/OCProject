//
//  XYNetworkRequest.h
//  OCProjectKit
//
//  Created by HXB-xiaoYang on 2018/3/28.
//Copyright © 2018年 VansXY. All rights reserved.
//

#import <Foundation/Foundation.h>
@class XYBaseRequest;

typedef void (^RequestSuccessBlock)(id responseJsonObject);
typedef void (^RequestFailureBlock)(NSError *error);

@interface XYNetworkRequest : NSObject

@property (atomic, strong, readonly) NSURLSessionDataTask *task;

- (void)connectWithRequest:(XYBaseRequest *)request
                   success:(RequestSuccessBlock)success
                   failure:(RequestFailureBlock)failure;

- (void)tokenUpdateNotify:(XYBaseRequest *)request
              updateState:(BOOL)isSuccess;

@end

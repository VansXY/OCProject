//
//  XYNetworkManager.m
//  OCProjectKit
//
//  Created by HXB-xiaoYang on 2018/4/9.
//  Copyright © 2018年 VansXY. All rights reserved.
//

#import "XYNetworkManager.h"
#import "XYBaseRequest.h"
#import "XYBaseRequestManager.h"
#import "XYHudAlert.h"
#import "XYNetworkRequest.h"

@implementation XYNetworkManager

+ (instancetype)sharedManager {
    static XYNetworkManager *instance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[self alloc] init];
    });
    return instance;
}

- (void)addRequest:(XYBaseRequest *)request {
    NSString *hudContent = nil;
    if(request.showHud) {
        hudContent = request.hudShowContent;
    }
    [self addRequest:request HUDContent:hudContent];
}

- (void)addRequest:(XYBaseRequest *)request HUDContent:(NSString *)content {
    /// 如果是相同的请求，返回错误信息
    if([[XYBaseRequestManager sharedInstance] sameRequestInstance:request]){
        dispatch_async(dispatch_get_main_queue(), ^{
            if (request.failure) {
                request.failure(request, nil);
            }
        });
        return;
    }
    NSLog(@"%@", request.requestUrl);
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    
    // 适配重构前的HUD
    XYHudAlert *hud = nil;
    if (request.hudDelegate == nil) {
        hud = (content.length) ? [XYHudAlert new] : nil;
        [hud showAnimationWithText:content];
    } else {
        if(request.showHud) {
            [request showLoading:content];
        }
    }
    [self sendRequest:request];
}

- (void)addRequestWithAnimation:(XYBaseRequest *)request {
    if([[XYBaseRequestManager sharedInstance] sameRequestInstance:request]) {
        dispatch_async(dispatch_get_main_queue(), ^{
            if (request.failure) {
                request.failure(request, nil);
            }
        });
        return;
    }
    // 适配重构前的HUD
    XYHudAlert *hud = nil;
    if (request.hudDelegate == nil) {
        hud = [XYHudAlert new];
        [hud showAnimation];
    } else {
        if(request.showHud) {
            [request showLoading:nil];
        }
    }
    
    [self sendRequest:request];
}

- (void)sendRequest:(XYBaseRequest *)request {
    [[XYBaseRequestManager sharedInstance] addRequest:request];
    XYNetworkRequest *network = [[XYNetworkRequest alloc] init];
    [network connectWithRequest:request success:^(id responseJsonObject) {
        NSLog(@"responseJsonObject = %@", responseJsonObject);
    } failure:^(NSError *error) {
        NSLog(@"error = %@", error);
    }];
}

- (void)processRequest:(XYBaseRequest *)request responseJsonObject:(id)responseJsonObject HUDProgress:(XYHudAlert *)hud {
    if([[XYBaseRequestManager sharedInstance] deleteRequest:request]) {
        // 适配重构前的HUD
        if (request.hudDelegate == nil) {
            [hud hide];
        } else {
            if(request.showHud) {
                [request hideLoading];
            }
        }
        
        request.responseObject = responseJsonObject;
        [self callBackRequestSuccess:request];
    }
    
    [self clearRequestBlock:request];
}

- (void)processRequest:(XYBaseRequest *)request error:(NSError *)error  HUDProgress:(XYHudAlert *)hud {
    if([[XYBaseRequestManager sharedInstance] deleteRequest:request]) {
        // 适配重构前的HUD
        if (request.hudDelegate == nil) {
            [hud hide];
        } else {
            if(request.showHud) {
                [request hideLoading];
            }
        }
        request.error = error;
        [self callBackRequestFailure:request];
    }
    [self clearRequestBlock:request];
}

/**
 *  成功回调
 */
- (void)callBackRequestSuccess:(XYBaseRequest *)request {
    if (request.success) {
        if([request.hudDelegate respondsToSelector:@selector(erroStateCodeDeal:)]) {
            if([request.hudDelegate erroStateCodeDeal:request]) {
                if(request.failure) {
                    request.responseObject = nil;
//                    NSError *erro = [NSError errorWithDomain:@"" code:kHXBCode_AlreadyPopWindow userInfo:nil];
//                    request.failure(request, erro);
                    return;
                }
            } else {
                NSDictionary *responseDic = request.responseObject;
                NSString * codeValue = responseDic[@"status"];
                if(![codeValue isEqualToString:@"0"]) {
                    if(request.failure) {
//                        request.failure(request, [NSError errorWithDomain:@"" code:kHXBCode_CommonInterfaceErro userInfo:request.responseObject]);
                        return;
                    }
                }
            }
        } else {
//            if(request.isNewRequestWay) {
//                NSDictionary* responseDic = request.responseObject;
//                NSString* codeValue = [responseDic stringAtPath:@"status"];
//                if(![codeValue isEqualToString:@"0"]) {
//                    if(request.failure) {
//                        request.failure(request, [NSError errorWithDomain:@"" code:kHXBCode_CommonInterfaceErro userInfo:request.responseObject]);
//                        return;
//                    }
//                }
//            } else {
//                [self defaultMethodRequestSuccessWithRequest:request];
//            }
        }
        request.success(request,request.responseObject);
    }
}

/**
 *  失败回调
 */
- (void)callBackRequestFailure:(XYBaseRequest *)request
{
//    if (request.failure) {
//        if([request.hudDelegate respondsToSelector:@selector(erroResponseCodeDeal:)]) {
//            if([request.hudDelegate erroResponseCodeDeal:request]) {
//                NSError* erro = [NSError errorWithDomain:@"" code:kHXBCode_AlreadyPopWindow userInfo:nil];
//                request.failure(request, erro);
//                return;
//            }
//        }
//        else{
//            [self defaultMethodRequestFaulureWithRequest:request];
//        }
//        request.failure(request,request.error);
//    }
}

- (void)clearRequestBlock:(XYBaseRequest *)request {
    request.networkRequest = nil;
}

//---------------------------------在回调中默认执行方法，在扩展中重写--------------------------
- (void)defaultMethodRequestSuccessWithRequest:(XYBaseRequest *)request {
    
}

- (void)defaultMethodRequestFaulureWithRequest:(XYBaseRequest *)request {
}

@end

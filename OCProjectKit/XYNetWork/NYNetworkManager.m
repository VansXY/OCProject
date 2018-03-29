//
//  NYNetworkManager.m
//  NYNetwork
//
//  Created by 牛严 on 16/6/28.
//  Copyright © 2016年 NYNetwork. All rights reserved.
//

#import "NYNetworkManager.h"
#import "XYNetworkRequest.h"
#import "HxbHUDProgress.h"
//#import "HXBBaseRequestManager.h"

@implementation NYNetworkManager

+ (instancetype)sharedManager
{
    static NYNetworkManager *instance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[self alloc] init];
    });
    return instance;
}

- (void)addRequest:(XYBaseRequest *)request
{
    NSString* hudShowContent = nil;
    if(request.showHud) {
        hudShowContent = request.hudShowContent;
    }
    [self addRequest:request withHUD:hudShowContent];
}

- (void)addRequest:(XYBaseRequest *)request withHUD:(NSString *)content
{
//    if([[HXBBaseRequestManager sharedInstance] sameRequestInstance:request]){
//        dispatch_async(dispatch_get_main_queue(), ^{
//            if (request.failure) {
//                request.failure(request, nil);
//            }
//        });
//        return;
//    }
//
//    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
//
//    // 适配重构前的HUD
//    HxbHUDProgress *hud = nil;
//    if (request.hudDelegate == nil) {
//        hud = (content.length) ? [HxbHUDProgress new] : nil;
//        [hud showAnimationWithText:content];
//    }
//    else {
//        if(request.showHud) {
//           [request showLoading:content];
//        }
//    }
//    NSLog(@"%@",request.httpHeaderFields);
//
//    [[HXBBaseRequestManager sharedInstance] addRequest:request];
//    NYHTTPConnection *connection = [[NYHTTPConnection alloc]init];
//    [connection connectWithRequest:request success:^(NYHTTPConnection *connection, id responseJsonObject) {
//        [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
//        [self processConnection:connection withRequest:request responseJsonObject:responseJsonObject HUDProgress:hud];
//    } failure:^(NYHTTPConnection *connection, NSError *error) {
//
//        [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
//        [self processConnection:connection withRequest:request error:error HUDProgress:hud];
//    }];
}

- (void)addRequestWithAnimation:(XYBaseRequest *)request
{
//    if([[HXBBaseRequestManager sharedInstance] sameRequestInstance:request]){
//        dispatch_async(dispatch_get_main_queue(), ^{
//            if (request.failure) {
//                request.failure(request, nil);
//            }
//        });
//        return;
//    }
//    // 适配重构前的HUD
//    HxbHUDProgress *hud = nil;
//    if (request.hudDelegate == nil) {
//        hud = [HxbHUDProgress new];
//        [hud showAnimation];
//    }
//    else {
//        if(request.showHud) {
//            [request showLoading:nil];
//        }
//    }
//
//    [[HXBBaseRequestManager sharedInstance] addRequest:request];
//    NYHTTPConnection *connection = [[NYHTTPConnection alloc]init];
//    [connection connectWithRequest:request success:^(NYHTTPConnection *connection, id responseJsonObject) {
//        [self processConnection:connection withRequest:request responseJsonObject:responseJsonObject HUDProgress:hud];
//    } failure:^(NYHTTPConnection *connection, NSError *error) {
//        [self processConnection:connection withRequest:request error:error HUDProgress:hud];
//    }];
}

- (void)processConnection:(XYNetworkRequest *)connection withRequest:(XYBaseRequest *)request responseJsonObject:(id)responseJsonObject HUDProgress:(HxbHUDProgress*)hud
{
//    if([[HXBBaseRequestManager sharedInstance] deleteRequest:request]) {
//        // 适配重构前的HUD
//        if (request.hudDelegate == nil) {
//            [hud hide];
//        }
//        else {
//            if(request.showHud) {
//                [request hideLoading];
//            }
//        }
//
//        request.responseObject = responseJsonObject;
//        [self callBackRequestSuccess:request];
//    }
//
//    [self clearRequestBlock:request];
}

- (void)processConnection:(XYNetworkRequest *)connection withRequest:(XYBaseRequest *)request error:(NSError *)error  HUDProgress:(HxbHUDProgress*)hud
{
//    if([[HXBBaseRequestManager sharedInstance] deleteRequest:request]) {
//        // 适配重构前的HUD
//        if (request.hudDelegate == nil) {
//            [hud hide];
//        }
//        else {
//            if(request.showHud) {
//                [request hideLoading];
//            }
//        }
//        
//        request.error = error;
//        [self callBackRequestFailure:request];
//    }
//    
//    [self clearRequestBlock:request];
}

//--------------------------------------------回调--------------------------------------------
/**
 *  成功回调
 */
- (void)callBackRequestSuccess:(XYBaseRequest *)request
{
//    if (request.success) {
//        if([request.hudDelegate respondsToSelector:@selector(erroStateCodeDeal:)]) {
//            if([request.hudDelegate erroStateCodeDeal:request]) {
//                if(request.failure) {
//                    request.responseObject = nil;
//                    NSError* erro = [NSError errorWithDomain:@"" code:kHXBCode_AlreadyPopWindow userInfo:nil];
//                    request.failure(request, erro);
//                    return;
//                }
//            }
//            else{
//                NSDictionary* responseDic = request.responseObject;
//                NSString* codeValue = [responseDic stringAtPath:@"status"];
//                if(![codeValue isEqualToString:@"0"]) {
//                    if(request.failure) {
//                        request.failure(request, [NSError errorWithDomain:@"" code:kHXBCode_CommonInterfaceErro userInfo:request.responseObject]);
//                        return;
//                    }
//                }
//            }
//        }
//        else {
//            if(request.isNewRequestWay) {
//                NSDictionary* responseDic = request.responseObject;
//                NSString* codeValue = [responseDic stringAtPath:@"status"];
//                if(![codeValue isEqualToString:@"0"]) {
//                    if(request.failure) {
//                        request.failure(request, [NSError errorWithDomain:@"" code:kHXBCode_CommonInterfaceErro userInfo:request.responseObject]);
//                        return;
//                    }
//                }
//            }
//            else {
//                [self defaultMethodRequestSuccessWithRequest:request];
//            }
//        }
//        request.success(request,request.responseObject);
//    }
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
//           [self defaultMethodRequestFaulureWithRequest:request];
//        }
//        request.failure(request,request.error);
//    }
}

- (void)clearRequestBlock:(XYBaseRequest *)request
{
//    request.connection = nil;
}

//---------------------------------在回调中默认执行方法，在扩展中重写--------------------------
- (void)defaultMethodRequestSuccessWithRequest:(XYBaseRequest *)request {
    
}

- (void)defaultMethodRequestFaulureWithRequest:(XYBaseRequest *)request {
}

@end

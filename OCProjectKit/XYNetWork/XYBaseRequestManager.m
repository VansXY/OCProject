//
//  XYBaseRequestManager.m
//  OCProjectKit
//
//  Created by HXB-xiaoYang on 2018/4/9.
//  Copyright © 2018年 VansXY. All rights reserved.
//

#import "XYBaseRequestManager.h"
#import "XYBaseRequest.h"
#import "XYNetworkRequest.h"

@interface XYBaseRequestManager()
// 线程锁
@property (nonatomic, strong) NSConditionLock *conditionLock;
// request列表
@property (nonatomic, strong) NSMutableArray *requestList;
// 等待token获取结果的列表
@property (nonatomic, strong) NSMutableArray *waitTokenResultList;
@end

@implementation XYBaseRequestManager

+ (instancetype)sharedInstance {
    static XYBaseRequestManager *instance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[self alloc] init];
    });
    return instance;
}

- (instancetype)init {
    self = [super init];
    if (self) {
        _conditionLock = [[NSConditionLock alloc] init];
        _requestList = [NSMutableArray array];
        _waitTokenResultList = [NSMutableArray array];
    }
    return self;
}

//当前是否正在获取令牌
- (BOOL)isGettingToken {
    BOOL result = NO;
    [self.conditionLock lock];
    
    if (self.waitTokenResultList.count > 0) {
        result = YES;
    }
    [self.conditionLock unlock];
    return result;
}

//是否有正在进行的请求
- (BOOL)isHasSendingRequest {
    BOOL result = NO;
    [self.conditionLock lock];
    if (self.requestList.count > 0) {
        result = YES;
    }
    [self.conditionLock unlock];
    return result;
}

/**
 添加请求
 
 @param request 请求对象
 */
- (void)addRequest:(XYBaseRequest *)request {
    [self.conditionLock lock];
    
    if(request.hudDelegate) {
        for(XYBaseRequest *base in self.requestList) {
            if(![base defferRequest:request]) {//同一个请求
                [base cancelRequest];
                [self.requestList removeObject:base];
                [self.waitTokenResultList removeObject:base];
                break;
            }
        }
    }
    [self.requestList addObject:request];
    
    [self.conditionLock unlock];
}

/**
 当前是否存在相同的请求实例，如果存在，则请求不能发出
 
 @param request 请求对象
 @return 是否存在
 */
- (BOOL)sameRequestInstance:(XYBaseRequest *)request {
    BOOL result = NO;
    [self.conditionLock lock];
    
    for (XYBaseRequest *base in self.requestList) {
        if (base == request) {//同一个请求
            result = YES;
            break;
        }
    }
    [self.conditionLock unlock];
    return result;
}
/**
 删除请求
 
 @param request 请求对象
 @return 这个请求对象是否存在
 */
- (BOOL)deleteRequest:(XYBaseRequest *)request
{
    BOOL isFind = NO;
    
    [self.conditionLock lock];
    
    if ([self.requestList containsObject:request]) {
        isFind = YES;
        [self.requestList removeObject:request];
    }
    
    [self.conditionLock unlock];
    
    return isFind;
}

/**
 添加需要重新获取令牌的请求
 
 @param request 请求对象
 */
- (void)addTokenInvalidRequest:(XYBaseRequest *)request
{
    [self.conditionLock lock];
    
    [self.waitTokenResultList addObject:request];
    
    [self.conditionLock unlock];
}

/**
 
 发送刷新令牌后的通知
 
 @param isSuccess 令牌是否成功刷新
 */
- (void)sendFreshTokenNotify:(BOOL)isSuccess
{
    [self.conditionLock lock];
    
    for(XYBaseRequest *base in self.waitTokenResultList) {
        [base.networkRequest tokenUpdateNotify:base updateState:isSuccess];
    }
    [self.waitTokenResultList removeAllObjects];
    
    [self.conditionLock unlock];
}

/**
 取消发送者发出的所有请求
 
 @param sender 请求发送者
 */
- (void)cancelRequest:(id)sender
{
    [self.conditionLock lock];
    
    for(XYBaseRequest *base in self.requestList) {
        if(base.hudDelegate && base.hudDelegate == sender) {
            [base cancelRequest];
        }
    }
    
    [self.conditionLock unlock];
}

/**
 sender是否正在发送请求
 
 @param sender 请求发送者
 */
- (BOOL)isSendingRequest:(id)sender
{
    BOOL result = NO;
    
    [self.conditionLock lock];
    
    for(XYBaseRequest *base in self.requestList) {
        if(base.hudDelegate && base.hudDelegate == sender) {
            result = YES;
            break;
        }
    }
    
    [self.conditionLock unlock];
    
    return result;
}

@end

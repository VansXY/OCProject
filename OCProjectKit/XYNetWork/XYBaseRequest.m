//
//  XYBaseRequest.m
//  OCProjectKit
//
//  Created by HXB-xiaoYang on 2018/3/28.
//Copyright © 2018年 VansXY. All rights reserved.
//

#import "XYBaseRequest.h"
#import "SGInfoAlert.h"
#import "XYNetworkRequest.h"
#import "XYNetworkManager.h"

@implementation XYBaseRequest

- (instancetype)init {
    if (self = [super init]) {
        _requestMethod = XYRequestMethodGet;
        _timeoutInterval = 20;
    }
    return  self;
}

- (instancetype)initWithDelegate:(id<HXBRequestHudDelegate>)delegate {
    self = [self init];
    if (self) {
        self.hudDelegate = delegate;
    }
    return self;
}

- (NSDictionary *)requestHeader {
    if (!_requestHeader) {
        _requestHeader = @{};
    }
    return _requestHeader;
}

- (NSString*)hudShowContent {
    if(!_hudShowContent) {
        _hudShowContent = @"加载中...";
    }
    return _hudShowContent;
}


/**
 比较是否是同一个请求
 
 @param request 比较对象
 @return YES：不同；反之。
 */
- (BOOL)defferRequest:(XYBaseRequest*)request {
    if([self.requestUrl isEqualToString:request.requestUrl] && self.hudDelegate==request.hudDelegate && [self.requestParams isEqual:request.requestParams]) {
        return NO;
    }
    return YES;
}

/**
 显示加载框
 
 @param hudContent 显示的文本内容
 */
- (void)showLoading:(NSString*)hudContent {
    if([self.hudDelegate respondsToSelector:@selector(showProgress:)]){
        [self.hudDelegate showProgress:hudContent];
    }
}

/**
 隐藏加载框
 
 */
- (void)hideLoading {
    if([self.hudDelegate respondsToSelector:@selector(hideProgress)]){
        [self.hudDelegate hideProgress];
    }
}
/**
 显示提示文本
 
 @param content 提示内容
 */
- (void)showToast:(NSString*)content {
    if([self.hudDelegate respondsToSelector:@selector(showToast:)]){
        [self.hudDelegate showToast:content];
    }
}

/**
 请求数据
 
 @param success 成功回调
 @param failure 失败回调
 */
- (void)loadData:(SuccessBlock)success failure:(FailureBlock)failure {
#ifdef DEBUG
    if([UIApplication sharedApplication].keyWindow) {
        [SGInfoAlert showInfo:[NSString stringWithFormat:@"请求接口：%@", self.requestUrl] bgColor:[UIColor blackColor].CGColor inView:[UIApplication sharedApplication].keyWindow vertical:0.3];
    }
#endif
    self.success = success;
    self.failure = failure;
    [[XYNetworkManager sharedManager] addRequest:self];
}

/**
 取消请求
 */
- (void)cancelRequest {
    [self.networkRequest.task cancel];
}



@end

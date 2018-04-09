//
//  XYNetworkRequest.m
//  OCProjectKit
//
//  Created by HXB-xiaoYang on 2018/3/28.
//Copyright © 2018年 VansXY. All rights reserved.
//

#import "XYNetworkRequest.h"
#import "XYNetWorkConfig.h"
#import "XYBaseRequest.h"

#define Config [XYNetWorkConfig shareInstance]

@interface XYNetworkRequest ()

@property (atomic, strong, readwrite) NSURLSessionDataTask *task;

@property (nonatomic, copy) RequestSuccessBlock success;

@property (nonatomic, copy) RequestFailureBlock failure;

@property (nonatomic, copy) NSString* requestToken;

@end

@implementation XYNetworkRequest

- (void)connectWithRequest:(XYBaseRequest *)request
                   success:(RequestSuccessBlock)success
                   failure:(RequestFailureBlock)failure {
    self.success = success;
    self.failure = failure;
    
    //现在的初始化代码
    NSURLSessionConfiguration *config = [NSURLSessionConfiguration ephemeralSessionConfiguration];
    AFHTTPSessionManager *manager = [[AFHTTPSessionManager alloc] initWithSessionConfiguration:config];
    
    //-------------------------------------------request----------------------------------------
    // 超时
    manager.requestSerializer.timeoutInterval = request.timeoutInterval > 0 ? request.timeoutInterval : [XYNetWorkConfig shareInstance].defaultTimeOutInterval;
    
    // cookie
    [manager.requestSerializer setHTTPShouldHandleCookies:NO];
    
    // 请求头
    NSDictionary *headers = [self headerFieldsValueWithRequest:request];
    [headers enumerateKeysAndObjectsUsingBlock:^(id field, id value, BOOL * __unused stop) {
        [manager.requestSerializer setValue:value forHTTPHeaderField:field];
    }];
    
    // statusCode contentType
    manager.responseSerializer.acceptableStatusCodes = Config.defaultAcceptableStatusCodes;
    manager.responseSerializer.acceptableContentTypes = Config.defaultAcceptableContentTypes;
    
    // URL
    NSString *urlString = @"";
    if (request.baseRequestUrl.length) {
        urlString = [NSURL URLWithString:request.requestUrl relativeToURL:[NSURL URLWithString:request.baseRequestUrl]].absoluteString;
    } else {
        urlString = [NSURL URLWithString:request.requestUrl relativeToURL:[NSURL URLWithString:Config.baseUrl]].absoluteString;
    }
    // 参数
    NSDictionary *parameters = request.requestParams;
    // 设置回调
    void (^successBlock)(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) = ^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [self setResponseWithRequest:request task:task responseObj:responseObject error:nil];
        [self requestHandleSuccess:request responseObject:responseObject];
    };
    
    void (^failureBlock)(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) = ^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [self setResponseWithRequest:request task:task responseObj:nil error:error];
        [self requestHandleFailure:request error:error];
    };
    
    NSURLSessionDataTask *task = nil;
    switch (request.requestMethod) {
        case XYRequestMethodGet: { task = [manager GET:urlString parameters:parameters progress:nil success:successBlock failure:failureBlock]; break; }
        case XYRequestMethodPost: { task = [manager POST:urlString parameters:parameters progress:nil success:successBlock failure:failureBlock]; break; }
        case XYRequestMethodPut: { task = [manager PUT:urlString parameters:parameters success:successBlock failure:failureBlock]; break; }
        case XYRequestMethodDelete: { task = [manager DELETE:urlString parameters:parameters success:successBlock failure:failureBlock]; break; }
    }
//    self.requestToken = KeyChain.token;
    self.task = task;
    request.networkRequest = self;
}

- (void)requestHandleSuccess:(XYBaseRequest *)request responseObject:(id)object {
    if (self.success) {
        self.success(object);
    }
}

- (void)requestHandleFailure:(XYBaseRequest *)request error:(NSError *)error
{
    NSInteger responseCode = [self responseCode:self.task];
    if ([self checkSingleLogin:responseCode]) {
        [self processSingleLoginWithRequest:request];
    } else {
        if (self.failure) {
            self.failure(error);
        }
    }
    
}

#pragma mark - Helper
/// 请求头字段配置
- (NSDictionary *)headerFieldsValueWithRequest:(XYBaseRequest *)request {
    NSMutableDictionary *headers = [Config.requestHeader mutableCopy];
    
    [request.requestHeader enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
        [headers setObject:obj forKey:key];
    }];
    return headers;
}

/// 设置请求的 Response 信息
- (void)setResponseWithRequest:(XYBaseRequest *)request
                          task:(NSURLSessionDataTask *)task
                   responseObj:(NSDictionary *)responseObj
                         error:(NSError *)error {
    request.responseStatusCode = [self responseCode:task];
    request.requestHeader = [self allHeaderFields:task];
    request.responseObject = responseObj;
    request.error = error;
}


- (NSInteger)responseCode:(NSURLSessionDataTask *)task {
    return ((NSHTTPURLResponse *)task.response).statusCode;
}

- (NSDictionary *)allHeaderFields:(NSURLSessionDataTask *)task {
    return ((NSHTTPURLResponse *)task.response).allHeaderFields;
}

#pragma mark - Single Login
/// 检查是否进行单点处理
- (BOOL)checkSingleLogin:(NSInteger)responseCode {
    return YES;
}

/// 单点登录处理
- (void)processSingleLoginWithRequest:(XYBaseRequest *)request {
//    if(![self.requestToken isEqualToString:KeyChain.token]) {
//        //令牌已经被更新过, 重发请求
//        dispatch_async(dispatch_get_main_queue(), ^{
//            [self connectWithRequest:request success:self.success failure:self.failure];
//        });
//    } else {
//        if(![HXBBaseRequestManager sharedInstance].isGettingToken) {
//            //当前没有正在获取令牌的请求
//
//            [KeyChain removeToken];
//            [self refreshAccessToken:^(NSString *token) {
//                BOOL result = NO;
//                if (token) {
//                    KeyChain.token = token;
//                    result = YES;
//
//                }
//                [[HXBBaseRequestManager sharedInstance] sendFreshTokenNotify:result];
//            }];
//        }
//
//        [[HXBBaseRequestManager sharedInstance] addTokenInvalidRequest:request];
//    }
    
}

- (void)tokenUpdateNotify:(XYBaseRequest *)request
              updateState:(BOOL)isSuccess {
    if (isSuccess) {
        dispatch_async(dispatch_get_main_queue(), ^{
//            [self processTokenInvidate];
            
//            if ([HXBRootVCManager manager].mainTabbarVC.selectedViewController.childViewControllers.count > 1) {
//                if (self.failure) {
//                    request.error = [NSError errorWithDomain:request.error.domain code:kHXBCode_Enum_ConnectionTimeOut userInfo:@{@"message":@"连接超时"}];
//                    self.failure(request.connection, nil);
//                }
//            } else {
//                [self connectWithRequest:request success:self.success failure:self.failure];
//            }
        });
    } else {
        if (self.failure) {
//            request.error = [NSError errorWithDomain:request.error.domain code:kHXBCode_Enum_ConnectionTimeOut userInfo:@{@"message":@"连接超时"}];
//
//            self.failure(request.connection, request.error);
        }
    }
}

/// 重新请求token
- (void)refreshAccessToken:(void(^)(NSString *token))refresh{
//    NSString *tokenURLString = [NSString stringWithFormat:@"%@%@",Config.baseUrl,TOKENURL];
//    NSURL *tokenURL =[NSURL URLWithString:tokenURLString];
//    NSURLRequest *request = [NSURLRequest requestWithURL:tokenURL];
//
//    NSURLSession *session = [NSURLSession sharedSession];
//    NSURLSessionDataTask *task = [session dataTaskWithRequest:request
//                                            completionHandler:
//                                  ^(NSData *data, NSURLResponse *response, NSError *error) {
//                                      if (!data) {
//                                          refresh(nil);
//                                          return ;
//                                      }
//                                      NSDictionary *dict = [[NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil] objectForKey:@"data"];
//                                      HXBTokenModel *model = [HXBTokenModel yy_modelWithJSON:dict];
//                                      refresh(model.token);
//                                  }];
//    [task resume];
}

@end

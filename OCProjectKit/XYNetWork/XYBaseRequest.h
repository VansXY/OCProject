//
//  XYBaseRequest.h
//  OCProjectKit
//
//  Created by HXB-xiaoYang on 2018/3/28.
//Copyright © 2018年 VansXY. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HXBRequestHudDelegate.h"
@class XYBaseRequest;
@class XYNetworkRequest;

///status
static NSString *const kResponseStatus          = @"status";
///message
static NSString *const kResponseMessage         = @"message";
///data
static NSString *const kResponseData            = @"data";
///errorData
static NSString *const kResponseErrorData       = @"errorData";

typedef NS_ENUM(NSInteger, XYRequestMethod){
    XYRequestMethodGet = 0,
    XYRequestMethodPost,
    XYRequestMethodPut,
    XYRequestMethodDelete,
};

typedef void (^SuccessBlock)(XYBaseRequest *request, id responseObject);
typedef void (^FailureBlock)(XYBaseRequest *request, NSError *error);

@interface XYBaseRequest : NSObject

#pragma mark --- request
@property (nonatomic, strong) XYNetworkRequest *networkRequest;
/// 请求方法 Get/Post， 默认是Get
@property (nonatomic, assign) XYRequestMethod requestMethod;
/// baseUrl之后的请求Url
@property (nonatomic, copy) NSString *requestUrl;
/// baseUrl，如http://api.hoomxb.com
@property (nonatomic, copy) NSString *baseRequestUrl;
/// 请求参数字典
@property (nonatomic, strong) id requestParams;
/// 向请求头中添加的附加信息，除token、version等公共信息
@property (nonatomic, copy) NSDictionary *requestHeader;
/// 请求超时时间， 默认是20秒
@property (nonatomic, assign) NSTimeInterval timeoutInterval;
/// 是否显示加载框
@property (nonatomic, assign) BOOL showHud;
/// 加载框上显示的文本
@property (nonatomic, copy) NSString* hudShowContent;
/// 委托
@property (nonatomic, weak) id<HXBRequestHudDelegate> hudDelegate;


#pragma mark --- response
/// 响应状态码
@property (nonatomic, assign) NSInteger responseStatusCode;
/// 响应头
@property (nonatomic, copy) NSDictionary *responseHeader;
/// 回调成功内容
@property (nonatomic, strong) id responseObject;
/// 回调失败错误
@property (nonatomic, strong) NSError *error;
/// 响应出错信息
@property (nonatomic, copy) NSString *responseErrorMessage;

#pragma mark --- callback
/// 返回成功回调
@property (nonatomic, copy) SuccessBlock success;
/// 返回失败回调
@property (nonatomic, copy) FailureBlock failure;


- (instancetype)initWithDelegate:(id<HXBRequestHudDelegate>)delegate;

/**
 比较是否是同一个请求
 
 @param request 比较对象
 @return YES：不同；反之。
 */
- (BOOL)defferRequest:(XYBaseRequest*)request;

/**
 显示加载框
 
 @param hudContent 显示的文本内容
 */
- (void)showLoading:(NSString*)hudContent;

/**
 隐藏加载框
 
 */
- (void)hideLoading;

/**
 显示提示文本
 
 @param content 提示内容
 */
- (void)showToast:(NSString*)content;

/**
 请求数据
 
 @param success 成功回调
 @param failure 失败回调
 */
- (void)loadData:(SuccessBlock)success failure:(FailureBlock)failure;

/**
 取消请求
 */
- (void)cancelRequest;


@end

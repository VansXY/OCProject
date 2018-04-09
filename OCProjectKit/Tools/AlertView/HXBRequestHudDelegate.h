//
//  HXBRequestHudDelegate.h
//  hoomxb
//
//  Created by lxz on 2017/12/5.
//  Copyright © 2017年 hoomsun-miniX. All rights reserved.
//

#import <Foundation/Foundation.h>

@class XYBaseRequest;

@protocol HXBRequestHudDelegate <NSObject>

#pragma mark 弹框显示HXBRequestHudDelegate
- (void)showProgress:(NSString*)hudContent;
- (void)showToast:(NSString *)toast;
- (void)hideProgress;

#pragma mark 错误码处理
/**
 错误的状态码处理

 @param request 请求对象
 @return 是否已经做了处理
 */
- (BOOL)erroStateCodeDeal:(XYBaseRequest *)request;

/**
 错误的响应码处理
 
 @param request 请求对象
 @return 是否已经做了处理
 */
- (BOOL)erroResponseCodeDeal:(XYBaseRequest *)request;
@end

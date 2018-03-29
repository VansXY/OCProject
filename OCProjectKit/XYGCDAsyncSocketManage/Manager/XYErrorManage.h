//
//  XYErrorManage.h
//  OCProjectKit
//
//  Created by HXB-xiaoYang on 2018/3/20.
//Copyright © 2018年 VansXY. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface XYErrorManage : NSObject

/// 服务器错误
#define kServer_Request_TimeOut                 @"请求超时"
#define kServer_Request_Param_Error             @"入参错误"
#define kServer_Request_Error                   @"请求失败"
#define kServer_Request_User_Updates            @"用户状态丢失"
#define kServer_Request_Token_Faild             @"Token 失效"


/// SDK内定义错误信息
#define kSocket_Network_Disconnected            @"网络断开"
#define kSocket_Local_Request_TimeOut           @"本地请求超时"
#define kSocket_Json_Error                      @"JSON 解析错误"
#define kSocket_Local_Param_Error               @"本地入参错误"


/**
 根据错误码返回错误信息

 @param errorCode 错误码
 @return 错误信息
 */
+ (NSError *)errorWithErrorCode:(NSInteger)errorCode;






@end

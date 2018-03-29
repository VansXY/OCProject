//
//  XYErrorManage.m
//  OCProjectKit
//
//  Created by HXB-xiaoYang on 2018/3/20.
//Copyright © 2018年 VansXY. All rights reserved.
//

#import "XYErrorManage.h"

@implementation XYErrorManage

/**
 根据错误码返回错误信息
 
 @param errorCode 错误码
 @return 错误信息
 */
+ (NSError *)errorWithErrorCode:(NSInteger)errorCode {
    NSString *errorMessage;
    
    switch (errorCode) {
        case 1:
            errorMessage = kServer_Request_Error;
            errorCode = 1001;
            break;
        case 2:
            errorMessage = kServer_Request_Param_Error;
            errorCode = 1002;
            break;
        case 3:
            errorMessage = kServer_Request_TimeOut;
            errorCode = 1003;
            break;
        case 4:
            errorMessage = kServer_Request_User_Updates;
            errorCode = 1004;
            break;
        case 1005:
            errorMessage = kServer_Request_Token_Faild;
            break;
        case 2001:
            errorMessage = kSocket_Network_Disconnected;
            break;
        case 2002:
            errorMessage = kSocket_Local_Request_TimeOut;
            break;
        case 2004:
            errorMessage = kSocket_Json_Error;
            break;
        case 2003:
            errorMessage = kSocket_Local_Param_Error;
            break;
        default:
            break;
    }
    
    return [NSError errorWithDomain:NSURLErrorDomain
                               code:errorCode
                           userInfo:@{NSLocalizedDescriptionKey: errorMessage}];
}


@end

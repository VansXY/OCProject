//
//  VasnXY_CodeNumber.h
//  ProjectKit
//
//  Created by HXB-xiaoYang on 2017/12/6.
//Copyright © 2017年 VansXY. All rights reserved.
//

#import <Foundation/Foundation.h>


/**
 code 码
 */
typedef enum : NSUInteger {
    // 成功
    VansXY_Enum_Success = 0,
    ///普通错误状态码
    VansXY_Enum_Error = 1,
    //服务器错误
    VansXY_Enum_NoServerFaile = 500,
    //连接超时
    VansXY_Enum_ConnectionTimeOut = -2009,
    
} VansXY_Enum;



@interface VasnXY_CodeNumber : NSObject

@end

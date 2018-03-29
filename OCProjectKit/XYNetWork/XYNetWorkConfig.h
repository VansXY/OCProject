//
//  XYNetWorkConfig.h
//  OCProjectKit
//
//  Created by HXB-xiaoYang on 2018/3/27.
//Copyright © 2018年 VansXY. All rights reserved.
//


#import <Foundation/Foundation.h>
#import "NetWorkTokenManager.h"

/// 网络配置类

@interface XYNetWorkConfig : NSObject

//基本地址
@property (nonatomic, copy) NSString *baseUrl;
//app版本号
@property (nonatomic, copy) NSString *version;
//请求超时时间
@property (nonatomic, assign) NSTimeInterval defaultTimeOutInterval;
//默认接受的状态码
@property (nonatomic, strong) NSIndexSet *defaultAcceptableStatusCodes;
//默认接受的文本格式
@property (nonatomic, strong) NSSet *defaultAcceptableContentTypes;
//请求头添加的内容，根据token和version生成，无法直接设置
@property (nonatomic, strong, readonly) NSDictionary *requestHeader;

+ (XYNetWorkConfig *)shareInstance;

@end

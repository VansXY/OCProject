//
//  XYNetWorkConfig.m
//  OCProjectKit
//
//  Created by HXB-xiaoYang on 2018/3/27.
//Copyright © 2018年 VansXY. All rights reserved.
//

#import "XYNetWorkConfig.h"
#import "VansXYTools.h"
#import <AdSupport/AdSupport.h>

@interface XYNetWorkConfig ()

//设置请求头
@property (nonatomic, strong, readwrite) NSDictionary *requestHeader;
//设备系统号
@property (nonatomic, strong) NSString *systemVersion;
//用户信息
@property (nonatomic, strong) NSString *userAgent;
//token
@property (nonatomic, strong) NetWorkTokenManager *tokenManager;
@end

@implementation XYNetWorkConfig

+ (XYNetWorkConfig *)shareInstance {
    static XYNetWorkConfig *config = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        config = [[self alloc] init];
        [config startMonitoringNetwork];
    });
    return config;
}

- (instancetype) init {
    self = [super init];
    if (self) {
        self.systemVersion = [[UIDevice currentDevice] systemVersion] ?: @"";
        self.version = [[[NSBundle mainBundle]infoDictionary]objectForKey:@"CFBundleShortVersionString"] ?: @"";
        self.userAgent = [NSString stringWithFormat:@"%@/IOS %@/v%@ iphone" ,[VansXYTools deviceVersion], self.systemVersion, self.version] ?: @"";
        _requestHeader = @{};
        self.baseUrl = @"";
        self.defaultAcceptableStatusCodes = [NSIndexSet indexSetWithIndexesInRange:NSMakeRange(200, 100)];
        self.defaultAcceptableContentTypes = [NSSet setWithObjects:@"text/json", @"text/javascript", @"application/json",@"application/x-www-form-urlencoded",nil];
    }
    return self;
}

// 根据网络开关socket
- (void)startMonitoringNetwork {
    AFNetworkReachabilityManager *networkManager = [AFNetworkReachabilityManager sharedManager];
    [networkManager startMonitoring];
    [networkManager setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        switch (status) {
            case AFNetworkReachabilityStatusReachableViaWWAN:
                
                break;
            case AFNetworkReachabilityStatusReachableViaWiFi:
                
                break;
                
            case AFNetworkReachabilityStatusNotReachable:
            case AFNetworkReachabilityStatusUnknown:
                
                break;
                
            default:
                break;
        }
    }];
}

#pragma mark --- setter/getter
- (NSDictionary *)requestHeader {
    if (!_requestHeader) {
        _requestHeader = @{
                           @"token": _tokenManager.token,
                           @"X-Hxb-User-Agent": self.userAgent,
                           @"IDFA": [[[ASIdentifierManager sharedManager] advertisingIdentifier] UUIDString],
                           @"X-Request-Id": [[[UIDevice currentDevice] identifierForVendor] UUIDString],
                           @"X-Hxb-Auth-Timestamp": [self nowDate]
                           };
    }
    return _requestHeader;
}

- (NSString *)nowDate {
    NSTimeInterval nowtime = [[NSDate date] timeIntervalSince1970] * 1000;
    long long theTime = [[NSNumber numberWithDouble:nowtime] longLongValue];
    return [NSString stringWithFormat:@"%llu",theTime];
}
@end

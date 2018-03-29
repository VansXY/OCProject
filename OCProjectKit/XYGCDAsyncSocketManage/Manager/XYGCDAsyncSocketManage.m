//
//  XYGCDAsyncSocketManage.m
//  OCProjectKit
//
//  Created by HXB-xiaoYang on 2018/3/20.
//Copyright © 2018年 VansXY. All rights reserved.
//

#import "XYGCDAsyncSocketManage.h"
#import "GCDAsyncSocket.h"
#import "AFNetworkReachabilityManager.h"
#import "XYErrorManage.h"
#import "XYSocketManege.h"
#import "GCKeyChainManager.h"
#import "SocketRequestModel.h"

/**
 *  默认通信协议版本号
 */
static NSUInteger PROTOCOL_VERSION = 7;

@interface XYGCDAsyncSocketManage ()<GCDAsyncSocketDelegate>

@property (nonatomic, copy) NSString *socketAuthAppraisalChannel;  // socket验证通道，支持多通道
@property (nonatomic, strong) NSMutableDictionary *requestParam;
@property (nonatomic, strong) XYSocketManege *socketManage;
@property (nonatomic, assign) NSTimeInterval interval;  //服务器与本地时间的差值
@property (nonatomic, strong, nonnull) XYConnectConfig *connectConfig;

@end

@implementation XYGCDAsyncSocketManage

- (instancetype)init {
    if (self = [super init]) {
        self.socketManage = [XYSocketManege sharedInstance];
        self.requestParam = [NSMutableDictionary dictionary];
        [self startMonitoringNetwork];
    }
    return self;
}
/**
 单例
 
 @return 单例对象
 */
+ (XYGCDAsyncSocketManage *_Nullable)shareInstance {
    static XYGCDAsyncSocketManage *manage = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manage = [[XYGCDAsyncSocketManage alloc] init];
    });
    return manage;
}


/**
 socket初始化
 
 @param config  socket配置参数
 */
- (void)createSocketWithConfig:(nonnull XYConnectConfig *)config {
    if (!config.token.length || !config.channels.length || !config.host.length) {
        return;
    }
    self.connectConfig = config;
    self.socketAuthAppraisalChannel = config.channels;
    [GCKeyChainManager sharedInstance].token = config.token;
    [self.socketManage changeHost:config.host port:config.port];
    PROTOCOL_VERSION = config.socketVersion;
    
    [self.socketManage connectSocketWithDelegate:self];
}


/**
 socket重连
 
 @param token   建连时的令牌
 @param channel 建连时的通道
 */
- (void)createSocketWithToken:(nonnull NSString *)token channel:(nonnull NSString *)channel {
    if (!token || !channel) {
        return;
    }
    self.socketAuthAppraisalChannel = channel;
    [GCKeyChainManager sharedInstance].token = token;
    [self.socketManage changeHost:@"online socket address" port:7070];
    
    [self.socketManage connectSocketWithDelegate:self];
    
}


/**
 socket断开连接
 */
- (void)disconnectSocket {
    [self.socketManage disconnectSocket];
}

/**
 向服务器发送数据
 
 @param body        请求体
 @param callback    结果返回
 */
- (void)socketWriteDataWithRequestBody:(nonnull NSDictionary *)body
                            completion:(nullable socketReturnBlock)callback {
    // 未连接
    NSLog(@"--------%ld", self.socketManage.connectStatus);
    if (self.socketManage.connectStatus == -1) {
        if (callback) {
            callback([XYErrorManage errorWithErrorCode:2003], nil);
        }
        return;
    }
    // 根据时间戳创建唯一识别请求ID
    NSString *requestId = [self createRequestID];
    if (callback) {
        [self.requestParam setObject:callback forKey:requestId];
    }
    
    // 创建请求体
    SocketRequestModel *model = [[SocketRequestModel alloc] init];
    model.version = PROTOCOL_VERSION;
    model.reqType = 2;
    model.reqId = [self createRequestID];
    model.requestChannel = self.socketAuthAppraisalChannel;
    
    model.body =
    @{ @"token": [GCKeyChainManager sharedInstance].token ?: @"",
       @"endpoint": @"ios" };
     [self.socketManage socketWriteData:[model socketModelToJSONString]];
}

#pragma mark - GCDAsyncSocketDelegate

- (void)socket:(GCDAsyncSocket *)socket didConnectToHost:(NSString *)host port:(UInt16)port {
    SocketRequestModel *socketModel = [[SocketRequestModel alloc] init];
    socketModel.version = PROTOCOL_VERSION;
    socketModel.reqType = 2;
    socketModel.reqId = [self createRequestID];
    socketModel.requestChannel = self.socketAuthAppraisalChannel;
    
    socketModel.body =@{ @"token": [GCKeyChainManager sharedInstance].token ?: @"",
                         @"endpoint": @"ios" };
    
    [self.socketManage socketWriteData:[socketModel socketModelToJSONString]];
    
    NSLog(@"socket:%p didConnectToHost:%@ port:%hu", socket, host, port);
    NSLog(@"Cool, I'm connected! That was easy.");
}

- (void)socketDidDisconnect:(GCDAsyncSocket *)socket withError:(NSError *)err {
    SocketRequestModel *socketModel = [[SocketRequestModel alloc] init];
    socketModel.version = PROTOCOL_VERSION;
    socketModel.reqType = 2;
    socketModel.reqId = [self createRequestID];
    socketModel.requestChannel = self.socketAuthAppraisalChannel;
    socketModel.body = @{@"token": [GCKeyChainManager sharedInstance].token == nil ? @"" : [GCKeyChainManager sharedInstance].token,
                         @"endpoint": @"ios"};
    
    NSString *requestBody = [socketModel socketModelToJSONString];
    
    [self.socketManage socketDidDisconectBeginSendReconnect:requestBody];
    NSLog(@"socketDidDisconnect:%p withError: %@", socket, err);
}


- (void)socket:(GCDAsyncSocket *)sock didReadData:(NSData *)data withTag:(long)tag {
    NSString *jsonString = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    jsonString = [jsonString stringByReplacingOccurrencesOfString:@"\r\n" withString:@""];
    NSData *jsonData = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
    
    NSError *jsonError;
    NSDictionary *json = [NSJSONSerialization JSONObjectWithData:jsonData options:kNilOptions error:&jsonError];
    NSLog(@"socket - receive data %@", json);
    
    if (jsonError) {
        [self.socketManage socketBeginReadData];
        NSLog(@"json 解析错误: --- error %@", jsonError);
        return;
    }
    
    NSInteger requestType = [json[@"reqType"] integerValue];
    NSInteger errorCode = [json[@"status"] integerValue];
    // fixme
    NSDictionary *body = @{};
    NSString *requestID = json[@"reqId"];
    NSString *requestChannel = nil;
    if ([[json allKeys] containsObject:@"requestChannel"]) {
        requestChannel = json[@"requestChannel"];
    }
    
    socketReturnBlock didReadBlock = self.requestParam[requestID];
    
    if (errorCode != 0) {
        NSError *error = [XYErrorManage errorWithErrorCode:errorCode];
        if (requestType == 2 &&
            [self.socketDelegate respondsToSelector:@selector(connectionAuthAppraisalFailedWithErorr:)]) {
            [self.socketDelegate connectionAuthAppraisalFailedWithErorr:[XYErrorManage errorWithErrorCode:1005]];
        }
        if (didReadBlock) {
            didReadBlock(error, body);
        }
        return;
    }
    
    switch (requestType) {
        case 1: {
            [self didConnectionAuthAppraisal];
            
            NSDictionary *systemTimeDic = [body mutableCopy];
            [self differenceOfLocalTimeAndServerTime:[systemTimeDic[@"system_time"] longLongValue]];
        } break;
        case 2: {
            [self.socketManage resetBeatCount];
        } break;
        case 7: {
            if (didReadBlock) {
                didReadBlock(nil, body);
            }
        } break;
        default: {
            if ([self.socketDelegate respondsToSelector:@selector(socketReadedData:forType:)]) {
                [self.socketDelegate socketReadedData:body forType:requestType];
            }
        } break;
    }
    
    [self.socketManage socketBeginReadData];
}

#pragma mark-- private method
- (NSString *)createRequestID {
    NSInteger timeInterval = [NSDate date].timeIntervalSince1970 * 100000;
    NSString *randomRequestID = [NSString stringWithFormat:@"%ld%u", timeInterval, arc4random() % 100000];
    return randomRequestID;
}

- (void)differenceOfLocalTimeAndServerTime:(long long)serverTime {
    if (serverTime == 0) {
        self.interval = 0;
        return;
    }
    
    NSTimeInterval localTimeInterval = [NSDate date].timeIntervalSince1970 * 1000;
    self.interval = serverTime - localTimeInterval;
}

- (long long)simulateServerCreateTime {
    NSTimeInterval localTimeInterval = [NSDate date].timeIntervalSince1970 * 1000;
    localTimeInterval += 3600 * 8;
    localTimeInterval += self.interval;
    return localTimeInterval;
}

- (void)didConnectionAuthAppraisal {
    if ([self.socketDelegate respondsToSelector:@selector(socketDidConnect)]) {
        [self.socketDelegate socketDidConnect];
    }
    
    SocketRequestModel *socketModel = [[SocketRequestModel alloc] init];
    socketModel.version = PROTOCOL_VERSION;
    socketModel.reqType = 2;
    socketModel.user_mid = 0;
    
    NSString *beatBody = [NSString stringWithFormat:@"%@\r\n", [socketModel yy_modelToJSONString]];
    [self.socketManage socketDidConnectBeginSendBeat:beatBody];
}

// 根据网络开关socket
- (void)startMonitoringNetwork {
    AFNetworkReachabilityManager *networkManager = [AFNetworkReachabilityManager sharedManager];
    [networkManager startMonitoring];
    __weak __typeof(&*self) weakSelf = self;
    [networkManager setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        switch (status) {
            case AFNetworkReachabilityStatusNotReachable:
                if (weakSelf.socketManage.connectStatus != -1) {
                    [self disconnectSocket];
                }
                break;
                
            case AFNetworkReachabilityStatusReachableViaWWAN:
            case AFNetworkReachabilityStatusReachableViaWiFi:
                if (weakSelf.socketManage.connectStatus == -1) {
                    // 如果有网，但是socket没有连接，带着token，和通道进行重连
                    [self createSocketWithToken:[GCKeyChainManager sharedInstance].token
                                        channel:self.socketAuthAppraisalChannel];
                }
                break;
                
            default:
                break;
        }
    }];
}

#pragma mark - getter
- (XYSocketConnectStatus)connectStatus {
    return self.socketManage.connectStatus;
}
@end

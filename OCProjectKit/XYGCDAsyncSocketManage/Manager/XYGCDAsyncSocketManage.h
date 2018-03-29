//
//  XYGCDAsyncSocketManage.h
//  OCProjectKit
//
//  Created by HXB-xiaoYang on 2018/3/20.
//Copyright © 2018年 VansXY. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "XYConnectConfig.h"

/**
 socket 连接状态

 - XYSocketConnectStatusDisconnected:   // 未连接
 - XYSocketConnectStatusConnecting:     // 连接中
 - XYSocketConnectStatusConnected:      // 已连接
 */
typedef NS_ENUM(NSUInteger, XYSocketConnectStatus) {
    XYSocketConnectStatusDisconnected = -1,
    XYSocketConnectStatusConnecting = 0,
    XYSocketConnectStatusConnected = 1,
};

typedef void(^socketReturnBlock)(NSError * _Nullable error, id _Nullable data);

@protocol XYGCDAsyncSocketManageDelegate <NSObject>

@optional

/**
 监听到服务器发送过来的消息

 @param data 数据
 @param type 类型
 */
- (void)socketReadedData:(nullable id)data forType:(NSInteger)type;

/**
 连上时触发方法
 */
- (void)socketDidConnect;

/**
 建连时检测到token失效
 */
- (void)connectionAuthAppraisalFailedWithErorr:(nonnull NSError *)error;

@end


@interface XYGCDAsyncSocketManage : NSObject

// 连接状态
@property (nonatomic, assign, readonly) XYSocketConnectStatus connectStatus;

// 当前请求通道
@property (nonatomic, strong, nonnull) NSString *currentChannel;

// socket 回调
@property (nonatomic, weak, nullable) id <XYGCDAsyncSocketManageDelegate> socketDelegate;


/**
 单例

 @return 单例对象
 */
+ (XYGCDAsyncSocketManage *_Nullable)shareInstance;


/**
 socket初始化

 @param config  socket配置参数
 */
- (void)createSocketWithConfig:(nonnull XYConnectConfig *)config;


/**
 socket重连

 @param token   建连时的令牌
 @param channel 建连时的通道
 */
- (void)createSocketWithToken:(nonnull NSString *)token channel:(nonnull NSString *)channel;


/**
 socket断开连接
 */
- (void)disconnectSocket;

/**
 向服务器发送数据

 @param body        请求体
 @param callback    结果返回
 */
- (void)socketWriteDataWithRequestBody:(nonnull NSDictionary *)body
                            completion:(nullable socketReturnBlock)callback;
@end

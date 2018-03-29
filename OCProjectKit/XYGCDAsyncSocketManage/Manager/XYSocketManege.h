//
//  XYSocketManege.h
//  OCProjectKit
//
//  Created by HXB-xiaoYang on 2018/3/20.
//Copyright © 2018年 VansXY. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface XYSocketManege : NSObject

@property (nonatomic, assign) NSInteger connectStatus;      // 连接状态：1已连接，-1未连接，0连接中
@property (nonatomic, assign) NSInteger reconnectionCount;  // 建连失败重连次数

/**
 *  获取单例
 *
 *  @return 单例对象
 */
+ (nullable XYSocketManege *)sharedInstance;

/**
 连接 socket
 
 @param delegate      delegate
 */
- (void)connectSocketWithDelegate:(nonnull id)delegate;

/**
 *  socket 连接成功后发送心跳的操作
 */
- (void)socketDidConnectBeginSendBeat:(nonnull NSString *)beatBody;

/**
 *  socket 连接失败后重接的操作
 */
- (void)socketDidDisconectBeginSendReconnect:(nonnull NSString *)reconnectBody;

/**
 *  向服务器发送数据
 *
 *  @param data 数据
 */
- (void)socketWriteData:(nonnull NSString *)data;

/**
 *  socket 读取数据
 */
- (void)socketBeginReadData;

/**
 *  socket 主动断开连接
 */
- (void)disconnectSocket;

/**
 *  重设心跳次数
 */
- (void)resetBeatCount;

/**
 *  设置连接的host和port
 */
- (void)changeHost:(nullable NSString *)host port:(NSInteger)port;
@end

//
//  XYConnectConfig.h
//  OCProjectKit
//
//  Created by HXB-xiaoYang on 2018/3/20.
//Copyright © 2018年 VansXY. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface XYConnectConfig : NSObject

/**
 *  socket配置
 */
@property (nonatomic, copy) NSString *token;
/**
 *  建连时的通道
 */
@property (nonatomic, copy) NSString *channels;
/**
 *  当前使用的通道
 */
@property (nonatomic, copy) NSString *currentChannel;
/**
 *  通信地址
 */
@property (nonatomic, copy) NSString *host;
/**
 *  通信端口号
 */
@property (nonatomic, assign) uint16_t port;
/**
 *  通信协议版本号
 */
@property (nonatomic, assign) NSInteger socketVersion;

@end

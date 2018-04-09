//
//  WZHDeviceInformation.h
//  WZHEncapsulation
//
//  Created by 吳梓杭 on 2018/2/26.
//  Copyright © 2018年 吳梓杭. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WZHDeviceInformation : NSObject

/// 获取设备版本号
+ (NSString *)getDeviceName;

/// 获取iPhone名称
+ (NSString *)getiPhoneName;

/// 获取app版本号
+ (NSString *)getAPPVerion;

/// 获取电池电量
+ (CGFloat)getBatteryLevel;

/// 当前系统名称
+ (NSString *)getSystemName;

/// 当前系统版本号
+ (NSString *)getSystemVersion;

/// 通用唯一识别码UUID
+ (NSString *)getUUID;

/// 获取当前设备IP
+ (NSString *)getDeviceIPAdress;

/// 获取总内存大小
+ (long long)getTotalMemorySize;

/// 获取当前可用内存
+ (long long)getAvailableMemorySize;

/// 获取精准电池电量
+ (CGFloat)getCurrentBatteryLevel;

/// 获取电池当前的状态，共有4种状态
+ (NSString *) getBatteryState;

/// 获取当前语言
+ (NSString *)getDeviceLanguage;

/// APP中文名
+ (NSString *)appName;

/// 获取启动页图片
+ (UIImage *)launchImage;

/// 获取APP LOGO
+ (UIImage *)iconImage;

/// 获取缓存大小 单位为Mb
+ (CGFloat)caculateAppCacheSize;

/// 清除缓存
+ (void)clearAppCache:(void(^)(BOOL success))block;



@end

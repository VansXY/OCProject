//
//  NSString+VansXY_Number.h
//  ProjectKit
//
//  Created by HXB-xiaoYang on 2017/12/5.
//  Copyright © 2017年 VansXY. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (VansXY_Number)

// 保留两位有效数字
+(NSString *)keepTwoDigitValidNumbersWithDouble:(double)number;
// 整数
+ (NSString *)preservingIntegerNumbersWithDouble:(double)number;

// 保留两位有效数字 + 分隔符 + 元
+ (NSString *)number_getPerMilWithDouble:(double)number;
// 整数 + 分隔符 + 元
+ (NSString *)number_getPerMilWithIntegetNumber:(double)number;

// 保留两位有效数字 + 分隔符
+ (NSString *)number_getPerMilWithDouble_NoYuan:(double)number;
// 整数 + 分隔符
+ (NSString *)number_getPerMilWithIntegetNumber_NoYuan:(double)number;
@end

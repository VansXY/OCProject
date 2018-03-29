//
//  NSString+VansXY_Number.m
//  ProjectKit
//
//  Created by HXB-xiaoYang on 2017/12/5.
//  Copyright © 2017年 VansXY. All rights reserved.
//

#import "NSString+VansXY_Number.h"

@implementation NSString (VansXY_Number)

// 保留两位有效数字
+ (NSString *)keepTwoDigitValidNumbersWithDouble:(double)number {
    NSNumberFormatter *numberFormatter = [[NSNumberFormatter alloc] init];
    [numberFormatter setPositiveFormat:@"###,##0.00;"];
    NSString *formattedNumberString = [numberFormatter stringFromNumber:[NSNumber numberWithDouble:number]];
    return formattedNumberString;
}

// 整数
+ (NSString *)preservingIntegerNumbersWithDouble:(double)number {
    NSNumberFormatter *numberFormatter = [[NSNumberFormatter alloc] init];
    [numberFormatter setPositiveFormat:@"###,##0;"];
    NSString *formattedNumberString = [numberFormatter stringFromNumber:[NSNumber numberWithDouble:number]];
    return formattedNumberString;
}

// 保留两位有效数字 + 分隔符 + 元
+ (NSString *)number_getPerMilWithDouble:(double)number {
    return [NSString stringWithFormat:@"%@元", [self keepTwoDigitValidNumbersWithDouble: number]];
}

// 整数 + 分隔符 + 元
+ (NSString *)number_getPerMilWithIntegetNumber:(double)number {
    return [NSString stringWithFormat:@"%@元", [self preservingIntegerNumbersWithDouble: number]];
}

// 保留两位有效数字 + 分隔符
+ (NSString *)number_getPerMilWithDouble_NoYuan:(double)number {
    return [self keepTwoDigitValidNumbersWithDouble:number];
}

// 整数 + 分隔符
+ (NSString *)number_getPerMilWithIntegetNumber_NoYuan:(double)number {
    return [self preservingIntegerNumbersWithDouble:number];
}



@end

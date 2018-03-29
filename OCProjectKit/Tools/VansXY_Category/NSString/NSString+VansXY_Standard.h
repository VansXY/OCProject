//
//  NSString+Standard.h
//  ProjectKit
//
//  Created by HXB-xiaoYang on 2017/12/5.
//  Copyright © 2017年 VansXY. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIDevice.h>

@interface NSString (VansXY_Standard)

///获取app版本号
+(NSString*)getAppVersionNum;
// 获取手机版本号
+ (NSString *)getPhoneVersionNum;
// 获取手机型号
+ (NSString *)getDeviceModel;
// 判断是否有中文字符
+ (BOOL)isChinese:(NSString *)str;
// 判断字符串是否包含数字
+ (BOOL)isStringContainNumberWith:(NSString *)str;
// 判断字符串是否包含字母
+ (BOOL)isStringCOntainStringWith:(NSString *)str;
// 判断字符串是否包含特殊字符
+ (BOOL)isIncludeSpecialCharact: (NSString *)str;
// 验证身份证号是否合法
+ (BOOL)validateIDCardNumber:(NSString *)identityCard;
// 8-20位数字和字母组成 密码
+ (BOOL)checkPassWordWithString: (NSString *)str;
// 根据身份证号获取生日
+(NSString *)birthdayStrFromIdentityCard:(NSString *)numberStr;
// 限制UITextfield两位小数的输入
+ (BOOL)checkBothDecimalPlaces: (NSString *)str;
// 给字符串打默认掩码
+ (NSString *)maskString:(NSString *)originString withMaskString:(NSString *)maskString location:(NSUInteger)location length:(NSUInteger)length;
- (CGSize)caleFontSize:(UIFont *)font forMaxSize:(CGSize)maxSize lineBreakMode:(NSLineBreakMode)lineBreakMode;
@end

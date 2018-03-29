//
//  NSString+Standard.m
//  ProjectKit
//
//  Created by HXB-xiaoYang on 2017/12/5.
//  Copyright © 2017年 VansXY. All rights reserved.
//

#import "NSString+VansXY_Standard.h"
#import "sys/utsname.h"

@implementation NSString (VansXY_Standard)

// 获取app版本号
+ (NSString*)getAppVersionNum {
    NSDictionary *infoDictionary = [[NSBundle mainBundle] infoDictionary];
    NSString *app_Version = [infoDictionary objectForKey:@"CFBundleShortVersionString"];
    return app_Version;
}

// 获取手机版本号
+ (NSString *)getPhoneVersionNum {
    return  [[UIDevice currentDevice] systemVersion];
}

// 判断字符串是否包含数字
+ (BOOL)isStringContainNumberWith:(NSString *)str {
    NSRegularExpression *numberRegular = [NSRegularExpression regularExpressionWithPattern:@"[0-9]" options:NSRegularExpressionCaseInsensitive error:nil];
    NSInteger count = [numberRegular numberOfMatchesInString:str options:NSMatchingReportProgress range:NSMakeRange(0, str.length)];
    //count是str中包含[0-9]数字的个数，只要count>0，说明str中包含数字
    if (count > 0) {
        return YES;
    }
    return NO;
}
// 判断字符串是否包含字母
+ (BOOL)isStringCOntainStringWith:(NSString *)str {
    NSRegularExpression *numberRegular = [NSRegularExpression regularExpressionWithPattern:@"[A-Za-z]" options:NSRegularExpressionCaseInsensitive error:nil];
    NSInteger count = [numberRegular numberOfMatchesInString:str options:NSMatchingReportProgress range:NSMakeRange(0, str.length)];
    //count是str中包含[A-Za-z]字母的个数，只要count>0，说明str中包含字母
    if (count > 0) {
        return YES;
    }
    return NO;
}

// 判断是否有中文字符
+ (BOOL)isChinese:(NSString *)str {
    for(int i=0; i< [str length];i++){
        int a = [str characterAtIndex:i];
        if( a > 0x4e00 && a < 0x9fff)
        {
            return YES;
        }
    }
    return NO;
}

/// 判断字符串是否包含特殊字符
+ (BOOL)isIncludeSpecialCharact: (NSString *)str {
    //***需要过滤的特殊字符：~￥#&*<>《》()[]{}【】^@/￡¤￥|§¨「」『』￠￢￣~@#￥&*（）——+|《》$_€。
    NSRange urgentRange = [str rangeOfCharacterFromSet: [NSCharacterSet characterSetWithCharactersInString: @"~￥#&*<>《》()[]{}【】^@/￡¤￥|§¨「」『』￠￢￣~@#￥&*（）——+|《》$_€"]];
    if (urgentRange.location == NSNotFound)
    {
        return NO;
    }
    return YES;
}
// 验证身份证号是否合法
+ (BOOL)validateIDCardNumber:(NSString *)identityCard {
    BOOL flag;
    if (identityCard.length <= 0) {
        flag = NO;
        return flag;
    }
    
    NSString *regex2 = @"^(^[1-9]\\d{7}((0\\d)|(1[0-2]))(([0|1|2]\\d)|3[0-1])\\d{3}$)|(^[1-9]\\d{5}[1-9]\\d{3}((0\\d)|(1[0-2]))(([0|1|2]\\d)|3[0-1])((\\d{4})|\\d{3}[Xx])$)$";
    NSPredicate *identityCardPredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regex2];
    flag = [identityCardPredicate evaluateWithObject:identityCard];
    
    
    //如果通过该验证，说明身份证格式正确，但准确性还需计算
    if(flag) {
        
        if(identityCard.length==18) {
            
            //将前17位加权因子保存在数组里
            NSArray * idCardWiArray = @[@"7", @"9", @"10", @"5", @"8", @"4", @"2", @"1", @"6", @"3", @"7", @"9", @"10", @"5", @"8", @"4", @"2"];
            
            //这是除以11后，可能产生的11位余数、验证码，也保存成数组
            NSArray * idCardYArray = @[@"1", @"0", @"10", @"9", @"8", @"7", @"6", @"5", @"4", @"3", @"2"];
            
            //用来保存前17位各自乖以加权因子后的总和
            
            NSInteger idCardWiSum = 0;
            for(int i = 0;i < 17;i++) {
                NSInteger subStrIndex = [[identityCard substringWithRange:NSMakeRange(i, 1)] integerValue];
                NSInteger idCardWiIndex = [[idCardWiArray objectAtIndex:i] integerValue];
                
                idCardWiSum+= subStrIndex * idCardWiIndex;
                
            }
            
            //计算出校验码所在数组的位置
            NSInteger idCardMod=idCardWiSum%11;
            
            //得到最后一位身份证号码
            NSString * idCardLast= [identityCard substringWithRange:NSMakeRange(17, 1)];
            
            //如果等于2，则说明校验码是10，身份证号码最后一位应该是X
            if(idCardMod==2) {
                
                if([idCardLast isEqualToString:@"X"]||[idCardLast isEqualToString:@"x"]) {
                    return flag;
                } else {
                    flag =  NO;
                    return flag;
                }
            } else {
                //用计算出的验证码与最后一位身份证号码匹配，如果一致，说明通过，否则是无效的身份证号码
                if([idCardLast isEqualToString: [idCardYArray objectAtIndex:idCardMod]]) {
                    return flag;
                } else {
                    flag =  NO;
                    return flag;
                }
            }
        } else {
            flag =  NO;
            return flag;
        }
    } else {
        return flag;
    }
}

// 验证是密码 不包含中文与特殊字符，包括字母与数字
+ (BOOL)contentNumberAndChar_notContentChinessAndSpecialCharactWithStr: (NSString *)str{
    ///判断字符串是否包含数字
    BOOL isContentNumber = [NSString isStringContainNumberWith:str];
    ///判断是否有中文字符
    BOOL isContentChiness = [NSString isChinese:str];
    ///判断字符串是否包含特殊字符
    BOOL isContentSpecialCharact = [NSString isIncludeSpecialCharact:str];
    ///判断是否有字母
    BOOL isContentChar = [NSString isStringCOntainStringWith:str];
    
    return isContentNumber && (!isContentChiness) && (!isContentSpecialCharact) && isContentChar;
}

// 8-20位数字和字母组成 密码
+ (BOOL)checkPassWordWithString: (NSString *)str {
    if ([NSString isIncludeSpecialCharact:str]) return NO;
    //8-20位数字和字母组成
    NSString *regex = @"^(?![0-9]+$)(?![a-zA-Z]+$)[0-9A-Za-z]{8,20}$";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    if ([pred evaluateWithObject:str]) {
        return YES ;
    } else {
        return NO;
    }
}

// 限制UITextfield两位小数的输入
+ (BOOL)checkBothDecimalPlaces: (NSString *)str {
    NSString *regex = @"^\\-?([1-9]\\d*|0)(\\.\\d{0,2})?$";
    NSPredicate *predicte = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regex];
    return [predicte evaluateWithObject:str];
}

// 根据身份证号获取生日
+ (NSString *)birthdayStrFromIdentityCard:(NSString *)numberStr {
    NSMutableString *result = [NSMutableString stringWithCapacity:0];
    NSString *year = nil;
    NSString *month = nil;
    
    NSString *day = nil;
    if([numberStr length]<14)
        return result;
    
    year = [numberStr substringWithRange:NSMakeRange(6, 4)];
    month = [numberStr substringWithRange:NSMakeRange(10, 2)];
    day = [numberStr substringWithRange:NSMakeRange(12,2)];
    
    [result appendString:year];
    [result appendString:@"-"];
    [result appendString:month];
    [result appendString:@"-"];
    [result appendString:day];
    
    return result;
}

//给字符串打默认掩码
/*
    使用规则
    [NSString maskString:@"18911580767" withMaskString:@"*" location:3 length:4]
    打印：189****0767
 */
+ (NSString *)maskString:(NSString *)originString withMaskString:(NSString *)maskString location:(NSUInteger)location length:(NSUInteger)length {
    NSMutableString *finalMaskStr = [NSMutableString string];
    for (int i = 0; i < length; i++) {
        [finalMaskStr appendString:maskString];
    }
    return [originString stringByReplacingCharactersInRange:NSMakeRange(location, length) withString:finalMaskStr];
}

// 获取手机型号
+ (NSString *)getDeviceModel {
    // 需要#import "sys/utsname.h"
    struct utsname systemInfo;
    uname(&systemInfo);
    NSString * deviceString = [NSString stringWithCString:systemInfo.machine encoding:NSUTF8StringEncoding];
    //iPhone
    if ([deviceString isEqualToString:@"iPhone1,1"]) return @"iPhone 2G";
    
    if ([deviceString isEqualToString:@"iPhone1,2"]) return @"iPhone 3G";
    
    if ([deviceString isEqualToString:@"iPhone2,1"]) return @"iPhone 3GS";
    
    if ([deviceString isEqualToString:@"iPhone3,1"]) return @"iPhone 4";
    
    if ([deviceString isEqualToString:@"iPhone3,2"]) return @"iPhone 4";
    
    if ([deviceString isEqualToString:@"iPhone3,3"]) return @"iPhone 4";
    
    if ([deviceString isEqualToString:@"iPhone4,1"]) return @"iPhone 4S";
    
    if ([deviceString isEqualToString:@"iPhone5,1"]) return @"iPhone 5";
    
    if ([deviceString isEqualToString:@"iPhone5,2"]) return @"iPhone 5";
    
    if ([deviceString isEqualToString:@"iPhone5,3"]) return @"iPhone 5c";
    
    if ([deviceString isEqualToString:@"iPhone5,4"]) return @"iPhone 5c";
    
    if ([deviceString isEqualToString:@"iPhone6,1"]) return @"iPhone 5s";
    
    if ([deviceString isEqualToString:@"iPhone6,2"]) return @"iPhone 5s";
    
    if ([deviceString isEqualToString:@"iPhone7,1"]) return @"iPhone 6 Plus";
    
    if ([deviceString isEqualToString:@"iPhone7,2"]) return @"iPhone 6";
    
    if ([deviceString isEqualToString:@"iPhone8,1"]) return @"iPhone 6s";
    
    if ([deviceString isEqualToString:@"iPhone8,2"]) return @"iPhone 6s Plus";
    
    if ([deviceString isEqualToString:@"iPhone8,4"]) return @"iPhone SE";
    
    if ([deviceString isEqualToString:@"iPhone9,1"]) return @"iPhone 7";
    
    if ([deviceString isEqualToString:@"iPhone9,2"]) return @"iPhone 7 Plus";
    
    if ([deviceString isEqualToString:@"iPhone10,1"]) return @"iPhone 8";
    
    if ([deviceString isEqualToString:@"iPhone10,4"]) return @"iPhone 8";
    
    if ([deviceString isEqualToString:@"iPhone10,2"]) return @"iPhone 8 Plus";
    
    if ([deviceString isEqualToString:@"iPhone10,5"]) return @"iPhone 8 Plus";
    
    if ([deviceString isEqualToString:@"iPhone10,3"]) return @"iPhone X";
    
    if ([deviceString isEqualToString:@"iPhone10,6"]) return @"iPhone X";
    
    if ([deviceString isEqualToString:@"iPod1,1"])  return @"iPod Touch 1G";
    
    if ([deviceString isEqualToString:@"iPod2,1"])  return @"iPod Touch 2G";
    
    if ([deviceString isEqualToString:@"iPod3,1"])  return @"iPod Touch 3G";
    
    if ([deviceString isEqualToString:@"iPod4,1"])  return @"iPod Touch 4G";
    
    if ([deviceString isEqualToString:@"iPod5,1"])  return @"iPod Touch 5G";
    
    if ([deviceString isEqualToString:@"iPod6,1"])  return @"iPod Touch 6G";
    
    if ([deviceString isEqualToString:@"iPod7,1"])  return @"iPod Touch 7G";
    
    if ([deviceString isEqualToString:@"iPad1,1"])  return @"iPad 1G";
    
    if ([deviceString isEqualToString:@"iPad2,1"])  return @"iPad 2";
    
    if ([deviceString isEqualToString:@"iPad2,2"])  return @"iPad 2";
    
    if ([deviceString isEqualToString:@"iPad2,3"])  return @"iPad 2";
    
    if ([deviceString isEqualToString:@"iPad2,4"])  return @"iPad 2";
    
    if ([deviceString isEqualToString:@"iPad2,5"])  return @"iPad Mini 1G";
    
    if ([deviceString isEqualToString:@"iPad2,6"])  return @"iPad Mini 1G";
    
    if ([deviceString isEqualToString:@"iPad2,7"])  return @"iPad Mini 1G";
    
    if ([deviceString isEqualToString:@"iPad3,1"])  return @"iPad 3";
    
    if ([deviceString isEqualToString:@"iPad3,2"])  return @"iPad 3";
    
    if ([deviceString isEqualToString:@"iPad3,3"])  return @"iPad 3";
    
    if ([deviceString isEqualToString:@"iPad3,4"])  return @"iPad 4";
    
    if ([deviceString isEqualToString:@"iPad3,5"])  return @"iPad 4";
    
    if ([deviceString isEqualToString:@"iPad3,6"])  return @"iPad 4";
    
    if ([deviceString isEqualToString:@"iPad4,1"])  return @"iPad Air";
    
    if ([deviceString isEqualToString:@"iPad4,2"])  return @"iPad Air";
    
    if ([deviceString isEqualToString:@"iPad4,3"])  return @"iPad Air";
    
    if ([deviceString isEqualToString:@"iPad4,4"])  return @"iPad Mini 2G";
    
    if ([deviceString isEqualToString:@"iPad4,5"])  return @"iPad Mini 2G";
    
    if ([deviceString isEqualToString:@"iPad4,6"])  return @"iPad Mini 2G";
    
    if ([deviceString isEqualToString:@"i386"])  return @"iPhone Simulator";
    
    if ([deviceString isEqualToString:@"x86_64"]) return @"iPhone Simulator";
    
    　return deviceString;
}

- (CGSize)caleFontSize:(UIFont *)font forMaxSize:(CGSize)maxSize lineBreakMode:(NSLineBreakMode)lineBreakMode{
    CGSize properSize = CGSizeZero;
    int lineSpace = 0;
    if (self != nil && ![self isEqualToString:@""])
    {
        NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
        paragraphStyle.lineBreakMode = lineBreakMode;
        paragraphStyle.lineSpacing = lineSpace;
        NSDictionary *attributes = @{NSFontAttributeName:font, NSParagraphStyleAttributeName:paragraphStyle.copy};
        
        properSize = [self boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:attributes context:nil].size;
    }
    
    if([UIDevice currentDevice].systemVersion.intValue >= 7.0){
        if(properSize.height > 0){
            properSize.height += 1;
        }
    }
    return properSize;
}

@end

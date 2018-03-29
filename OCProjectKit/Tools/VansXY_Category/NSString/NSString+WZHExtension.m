
//
//  NSString+WZHExtension.m
//  WZHEncapsulation
//
//  Created by 吳梓杭 on 2018/2/27.
//  Copyright © 2018年 吳梓杭. All rights reserved.
//

#import "NSString+WZHExtension.h"
#import <CommonCrypto/CommonCrypto.h>
//#import "GTMBase64.h"


@implementation NSString (WZHExtension)


#pragma mark - 判断特殊字符

- (BOOL)isEmpty {
    if (self.length == 0 || [self isEqualToString:@"null"] ||[self isKindOfClass:[NSNull class]] || self==nil ||[self isEqual:[NSNull null]]) {
        return YES;
    }
    return NO;
}

- (BOOL)isInteger {
    NSScanner *scan = [NSScanner scannerWithString:self];
    int val;
    return [scan scanInt:&val] && [scan isAtEnd];
}

- (BOOL)isFloat {
    NSScanner *scan = [NSScanner scannerWithString:self];
    float val;
    return [scan scanFloat:&val] && [scan isAtEnd];
}

- (BOOL)isHasSpecialcharacters {
    NSString *englishNameRule = @"^[(A-Za-z0-9)*(\u4e00-\u9fa5)*(,|\\.|，|。|\\:|;|：|；|!|！|\\*|\\×|\\(|\\)|\\（|\\）|#|#|\\$|&#|\\$|&|\\^|@|&#|\\$|&|\\^|@|＠|＆|\\￥|\\……)*]+$";
    
    NSPredicate *englishpredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", englishNameRule];
    
    if ([englishpredicate evaluateWithObject:self] == YES) {
        return YES;
    } else {
        return NO;
        
    }
}

- (BOOL)isHasNumder {
    NSString *englishNameRule = @"[A-Za-z]{2,}|[\u4e00-\u9fa5]{1,}[A-Za-z]+$";
    NSString *chineseNameRule = @"^[\u4e00-\u9fa5]{2,}$";
    
    NSPredicate *englishpredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", englishNameRule];
    NSPredicate *chinesepredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", chineseNameRule];
    
    if ([englishpredicate evaluateWithObject:self] == YES||[chinesepredicate evaluateWithObject:self] == YES) {
        return YES;
    } else {
        return NO;
    }
    
}

#pragma mark - 沙盒路径

- (instancetype)cacheDirectories {
    return [[NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:[self lastPathComponent]];
}

- (instancetype)docDirectories {
    return [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:[self lastPathComponent]];
}

- (instancetype)tmpDirectories {
    return [NSTemporaryDirectory() stringByAppendingPathComponent:[self lastPathComponent]];
}

#pragma mark - Hash

#pragma mark - 散列函数
- (NSString *)md5String {
    const char *str = self.UTF8String;
    unsigned char buffer[CC_MD5_DIGEST_LENGTH];
    
    CC_MD5(str, (CC_LONG)strlen(str), buffer);
    
    return [self stringFromBytes:buffer length:CC_MD5_DIGEST_LENGTH];
}

- (NSString *)md5String_16 {
    // 提取32位MD5散列的中间16位
    NSString *md5_32=[self md5String];
    
    // 即9～25位
    return [[md5_32 substringToIndex:24] substringFromIndex:8];
}

- (NSString *)sha1String {
    const char *str = self.UTF8String;
    unsigned char buffer[CC_SHA1_DIGEST_LENGTH];
    
    CC_SHA1(str, (CC_LONG)strlen(str), buffer);
    
    return [self stringFromBytes:buffer length:CC_SHA1_DIGEST_LENGTH];
}

- (NSString *)sha256String {
    const char *str = self.UTF8String;
    
    unsigned char buffer[CC_SHA256_DIGEST_LENGTH];
    
    CC_SHA256(str, (CC_LONG)strlen(str), buffer);
    
    return [self stringFromBytes:buffer length:CC_SHA256_DIGEST_LENGTH];
}

- (NSString *)sha384String {
    const char *cstr = [self cStringUsingEncoding:NSUTF8StringEncoding];
    
    NSData *data = [NSData dataWithBytes:cstr length:self.length];
    
    uint8_t digest[CC_SHA384_DIGEST_LENGTH];
    
    CC_SHA1(data.bytes, (CC_LONG)data.length, digest);
    
    return [self stringFromBytes:digest length:CC_SHA384_DIGEST_LENGTH];
}

- (NSString *)sha512String {
    const char *str = self.UTF8String;
    
    unsigned char buffer[CC_SHA512_DIGEST_LENGTH];
    
    CC_SHA512(str, (CC_LONG)strlen(str), buffer);
    
    return [self stringFromBytes:buffer length:CC_SHA512_DIGEST_LENGTH];
}

#pragma mark - HMAC 散列函数
- (NSString *)hmacMD5StringWithKey:(NSString *)key {
    const char *keyData = key.UTF8String;
    const char *strData = self.UTF8String;
    unsigned char buffer[CC_MD5_DIGEST_LENGTH];
    
    CCHmac(kCCHmacAlgMD5, keyData, strlen(keyData), strData, strlen(strData), buffer);
    
    return [self stringFromBytes:buffer length:CC_MD5_DIGEST_LENGTH];
}

- (NSString *)hmacSHA1StringWithKey:(NSString *)key {
    const char *keyData = key.UTF8String;
    const char *strData = self.UTF8String;
    unsigned char buffer[CC_SHA1_DIGEST_LENGTH];
    
    CCHmac(kCCHmacAlgSHA1, keyData, strlen(keyData), strData, strlen(strData), buffer);
    
    return [self stringFromBytes:buffer length:CC_SHA1_DIGEST_LENGTH];
}

- (NSString *)hmacSHA256StringWithKey:(NSString *)key {
    const char *keyData = key.UTF8String;
    const char *strData = self.UTF8String;
    unsigned char buffer[CC_SHA256_DIGEST_LENGTH];
    
    CCHmac(kCCHmacAlgSHA256, keyData, strlen(keyData), strData, strlen(strData), buffer);
    
    return [self stringFromBytes:buffer length:CC_SHA256_DIGEST_LENGTH];
}

- (NSString *)hmacSHA512StringWithKey:(NSString *)key {
    const char *keyData = key.UTF8String;
    const char *strData = self.UTF8String;
    unsigned char buffer[CC_SHA512_DIGEST_LENGTH];
    
    CCHmac(kCCHmacAlgSHA512, keyData, strlen(keyData), strData, strlen(strData), buffer);
    
    return [self stringFromBytes:buffer length:CC_SHA512_DIGEST_LENGTH];
}

#pragma mark - 文件散列函数

#define FileHashDefaultChunkSizeForReadingData 4096

- (NSString *)fileMD5Hash {
    NSFileHandle *fp = [NSFileHandle fileHandleForReadingAtPath:self];
    if (fp == nil) {
        return nil;
    }
    
    CC_MD5_CTX hashCtx;
    CC_MD5_Init(&hashCtx);
    
    while (YES) {
        @autoreleasepool {
            NSData *data = [fp readDataOfLength:FileHashDefaultChunkSizeForReadingData];
            
            CC_MD5_Update(&hashCtx, data.bytes, (CC_LONG)data.length);
            
            if (data.length == 0) {
                break;
            }
        }
    }
    [fp closeFile];
    
    unsigned char buffer[CC_MD5_DIGEST_LENGTH];
    CC_MD5_Final(buffer, &hashCtx);
    
    return [self stringFromBytes:buffer length:CC_MD5_DIGEST_LENGTH];
}

- (NSString *)fileSHA1Hash {
    NSFileHandle *fp = [NSFileHandle fileHandleForReadingAtPath:self];
    if (fp == nil) {
        return nil;
    }
    
    CC_SHA1_CTX hashCtx;
    CC_SHA1_Init(&hashCtx);
    
    while (YES) {
        @autoreleasepool {
            NSData *data = [fp readDataOfLength:FileHashDefaultChunkSizeForReadingData];
            
            CC_SHA1_Update(&hashCtx, data.bytes, (CC_LONG)data.length);
            
            if (data.length == 0) {
                break;
            }
        }
    }
    [fp closeFile];
    
    unsigned char buffer[CC_SHA1_DIGEST_LENGTH];
    CC_SHA1_Final(buffer, &hashCtx);
    
    return [self stringFromBytes:buffer length:CC_SHA1_DIGEST_LENGTH];
}

- (NSString *)fileSHA256Hash {
    NSFileHandle *fp = [NSFileHandle fileHandleForReadingAtPath:self];
    if (fp == nil) {
        return nil;
    }
    
    CC_SHA256_CTX hashCtx;
    CC_SHA256_Init(&hashCtx);
    
    while (YES) {
        @autoreleasepool {
            NSData *data = [fp readDataOfLength:FileHashDefaultChunkSizeForReadingData];
            
            CC_SHA256_Update(&hashCtx, data.bytes, (CC_LONG)data.length);
            
            if (data.length == 0) {
                break;
            }
        }
    }
    [fp closeFile];
    
    unsigned char buffer[CC_SHA256_DIGEST_LENGTH];
    CC_SHA256_Final(buffer, &hashCtx);
    
    return [self stringFromBytes:buffer length:CC_SHA256_DIGEST_LENGTH];
}

- (NSString *)fileSHA512Hash {
    NSFileHandle *fp = [NSFileHandle fileHandleForReadingAtPath:self];
    if (fp == nil) {
        return nil;
    }
    
    CC_SHA512_CTX hashCtx;
    CC_SHA512_Init(&hashCtx);
    
    while (YES) {
        @autoreleasepool {
            NSData *data = [fp readDataOfLength:FileHashDefaultChunkSizeForReadingData];
            
            CC_SHA512_Update(&hashCtx, data.bytes, (CC_LONG)data.length);
            
            if (data.length == 0) {
                break;
            }
        }
    }
    [fp closeFile];
    
    unsigned char buffer[CC_SHA512_DIGEST_LENGTH];
    CC_SHA512_Final(buffer, &hashCtx);
    
    return [self stringFromBytes:buffer length:CC_SHA512_DIGEST_LENGTH];
}

#pragma mark - 助手方法
/**
 *  返回二进制 Bytes 流的字符串表示形式
 *
 *  @param bytes  二进制 Bytes 数组
 *  @param length 数组长度
 *
 *  @return 字符串表示形式
 */
- (NSString *)stringFromBytes:(unsigned char *)bytes length:(NSUInteger)length {
    NSMutableString *strM = [NSMutableString string];
    
    for (NSUInteger i = 0; i < length; i++) {
        [strM appendFormat:@"%02x", bytes[i]];
    }
    
    return [strM copy];
}

#pragma mark - 加密

//- (NSString *)base64Encode {
//    NSString *base64String = [GTMBase64 encodeBase64String:self];
//    return base64String;
//}

//- (NSString *)base64Decode {
//    NSString *base64String = [GTMBase64 decodeBase64String:self];
//    return base64String;
//}

//- (NSString *)encryptWithKey:(NSString *)key {
//    return [self encrypt:self encryptOrDecrypt:kCCEncrypt key:key];
//}
//
//- (NSString *)decryptWithKey:(NSString *)key {
//    return [self encrypt:self encryptOrDecrypt:kCCDecrypt key:key];
//}

/**
 *  加密或解密
 *
 *  @param sText            需要加密或解密的字符串
 *  @param encryptOperation kCCDecrypt 解密 kCCEncrypt 加密
 *  @param key              加密解密需要的key
 *
 *  @return 返回加密或解密之后得到的字符串
 */
//- (NSString *)encrypt:(NSString *)sText encryptOrDecrypt:(CCOperation)encryptOperation key:(NSString *)key {
//    const void *vplainText;
//    size_t plainTextBufferSize;
//
//    if (encryptOperation == kCCDecrypt) {
//        NSData *decryptData = [GTMBase64 decodeData:[sText dataUsingEncoding:NSUTF8StringEncoding]];
//        plainTextBufferSize = [decryptData length];
//        vplainText = [decryptData bytes];
//    } else {
//        NSData* encryptData = [sText dataUsingEncoding:NSUTF8StringEncoding];
//        plainTextBufferSize = [encryptData length];
//        vplainText = (const void *)[encryptData bytes];
//    }
//
//    CCCryptorStatus ccStatus;
//    uint8_t *bufferPtr = NULL;
//    size_t bufferPtrSize = 0;
//    size_t movedBytes = 0;
//
//    bufferPtrSize = (plainTextBufferSize + kCCBlockSize3DES) & ~(kCCBlockSize3DES - 1);
//    bufferPtr = malloc( bufferPtrSize * sizeof(uint8_t));
//    memset((void *)bufferPtr, 0x0, bufferPtrSize);
//
//    NSString *initVec = @"shuai";
//    const void *vkey = (const void *) [key UTF8String];
//    const void *vinitVec = (const void *) [initVec UTF8String];
//
//    ccStatus = CCCrypt(encryptOperation,
//                       kCCAlgorithm3DES,
//                       kCCOptionPKCS7Padding,
//                       vkey,
//                       kCCKeySize3DES,
//                       vinitVec,
//                       vplainText,
//                       plainTextBufferSize,
//                       (void *)bufferPtr,
//                       bufferPtrSize,
//                       &movedBytes);
//
//    NSString *result = nil;
//
//    if (encryptOperation == kCCDecrypt) {
//        result = [[NSString alloc] initWithData:[NSData dataWithBytes:(const void *)bufferPtr length:(NSUInteger)movedBytes] encoding:NSUTF8StringEncoding] ;
//    } else {
//        NSData *data = [NSData dataWithBytes:(const void *)bufferPtr length:(NSUInteger)movedBytes];
//        result = [GTMBase64 stringByEncodingData:data];
//    }
//
//    return result;
//}

#pragma mark - MIME

- (NSString *)mimeTypeForNetWorkRequest {
    NSURL *url = [NSURL fileURLWithPath:self];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    NSHTTPURLResponse *response = nil;
    [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:nil];
    return response.MIMEType;
}

- (NSString *)mimeTypeForFileAtPath {
    if (![[[NSFileManager alloc] init] fileExistsAtPath:self]) {
        return nil;
    }
    
    CFStringRef UTI = UTTypeCreatePreferredIdentifierForTag(kUTTagClassFilenameExtension, (__bridge CFStringRef)[self pathExtension], NULL);
    CFStringRef MIMEType = UTTypeCopyPreferredTagWithClass (UTI, kUTTagClassMIMEType);
    CFRelease(UTI);
    if (!MIMEType) {
        return @"application/octet-stream";
    }
    return (__bridge NSString *)(MIMEType);
}

#pragma mark - 时间字符串处理

- (NSDate *)dateValueWithTimeIntervalSince1970 {
    return [NSDate dateWithTimeIntervalSince1970:[self doubleValue]];
}

- (NSDate *)dateValueWithMillisecondsSince1970 {
    return [NSDate dateWithTimeIntervalSince1970:[self doubleValue] / 1000];
}

- (instancetype)timestampToTimeStringWithFormatString:(NSString *)formatString {
    // 时间戳转Date
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:[self doubleValue]];
    return [self timeStringFromDate:date formatString:formatString];
}

- (instancetype)timeStringFromDate:(NSDate *)date formatString:(NSString *) formatString {
    // 实例化时间格式工具
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    // 定义格式
    formatter.dateFormat = formatString;
    // 时间转化为字符串返回
    return [formatter stringFromDate:date];
}

#pragma mark - 实用工具
+ (NSString *)stringWithUUID {
    CFUUIDRef uuid = CFUUIDCreate(NULL);
    CFStringRef string = CFUUIDCreateString(NULL, uuid);
    CFRelease(uuid);
    return (__bridge_transfer NSString *)string;
}

+ (NSString*)getTimeAndRandomString {
    
    int iRandom = arc4random();
    if (iRandom < 0) {
        iRandom=-iRandom;
    }
    NSDateFormatter *tFormat=[[NSDateFormatter alloc] init];
    [tFormat setDateFormat:@"yyyyMMddHHmmss"];
    NSString *tResult=[NSString stringWithFormat:@"%@%d", [tFormat stringFromDate:[NSDate date]], iRandom];
    return tResult;
}

#pragma mark - 正则匹配
//金额判断
+ (BOOL)validateMoney:(NSString *)money {
    NSString *phoneRegex = @"^[0-9]+(\\.[0-9]{1,2})?$";
    NSPredicate *phoneTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",phoneRegex];
    return [phoneTest evaluateWithObject:money];
}

- (BOOL)isEmail {
    NSString *regex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    return [pred evaluateWithObject:self];
}

- (BOOL)isUrl {
    NSString *regex = @"http(s)?:\\/\\/([\\w-]+\\.)+[\\w-]+(\\/[\\w- .\\/?%&=]*)?";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    return [pred evaluateWithObject:self];
}


-(BOOL)isChineseIdentificationCard{
    if (self.length != 18) return NO;
    // 正则表达式判断基本 身份证号是否满足格式
    NSString *regex = @"^[1-9]\\d{5}[1-9]\\d{3}((0\\d)|(1[0-2]))(([0|1|2]\\d)|3[0-1])\\d{3}([0-9]|X)$";
    //  NSString *regex = @"^(^[1-9]\\d{7}((0\\d)|(1[0-2]))(([0|1|2]\\d)|3[0-1])\\d{3}$)|(^[1-9]\\d{5}[1-9]\\d{3}((0\\d)|(1[0-2]))(([0|1|2]\\d)|3[0-1])((\\d{4})|\\d{3}[Xx])$)$";
    NSPredicate *identityStringPredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regex];
    //如果通过该验证，说明身份证格式正确，但准确性还需计算
    if(![identityStringPredicate evaluateWithObject:self]) return NO;
    
    //** 开始进行校验 *//
    
    //将前17位加权因子保存在数组里
    NSArray *idCardWiArray = @[@"7", @"9", @"10", @"5", @"8", @"4", @"2", @"1", @"6", @"3", @"7", @"9", @"10", @"5", @"8", @"4", @"2"];
    //这是除以11后，可能产生的11位余数、验证码，也保存成数组
    NSArray *idCardYArray = @[@"1", @"0", @"10", @"9", @"8", @"7", @"6", @"5", @"4", @"3", @"2"];
    
    //用来保存前17位各自乖以加权因子后的总和
    NSInteger idCardWiSum = 0;
    for(int i = 0;i < 17;i++) {
        NSInteger subStrIndex = [[self substringWithRange:NSMakeRange(i, 1)] integerValue];
        NSInteger idCardWiIndex = [[idCardWiArray objectAtIndex:i] integerValue];
        idCardWiSum+= subStrIndex * idCardWiIndex;
    }
    
    //计算出校验码所在数组的位置
    NSInteger idCardMod=idCardWiSum%11;
    //得到最后一位身份证号码
    NSString *idCardLast= [self substringWithRange:NSMakeRange(17, 1)];
    //如果等于2，则说明校验码是10，身份证号码最后一位应该是X
    if(idCardMod==2) {
        if(![idCardLast isEqualToString:@"X"]||[idCardLast isEqualToString:@"x"]) {
            return NO;
        }
    }
    else{
        //用计算出的验证码与最后一位身份证号码匹配，如果一致，说明通过，否则是无效的身份证号码
        if(![idCardLast isEqualToString: [idCardYArray objectAtIndex:idCardMod]]) {
            return NO;
        }
    }
    return YES;
}

- (BOOL)isTelephone {
    /**
     * 手机号码:
     * 13[0-9], 14[5,7], 15[0, 1, 2, 3, 5, 6, 7, 8, 9], 17[0, 1, 6, 7, 8], 18[0-9]
     * 移动号段: 134,135,136,137,138,139,147,150,151,152,157,158,159,170,178,182,183,184,187,188
     * 联通号段: 130,131,132,145,155,156,170,171,175,176,185,186
     * 电信号段: 133,149,153,170,173,177,180,181,189
     */
    NSString *MOBILE = @"^1(3[0-9]|47|5[0-35-9]|8[025-9])\\d{8}$";
    /**
     * 中国移动：China Mobile
     * 134,135,136,137,138,139,147,150,151,152,157,158,159,170,178,182,183,184,187,188
     */
    NSString *CM = @"^((13[4-9])|(147)|(15[0-2,7-9])|(178)|(18[2-4,7-8]))\\d{8}|(1705)\\d{7}$";
    /**
     * 中国联通：China Unicom
     * 130,131,132,145,155,156,170,171,175,176,185,186
     */
    NSString *CU = @"^((13[0-2])|(145)|(15[5-6])|(176)|(18[5,6]))\\d{8}|(1709)\\d{7}$";
    /**
     * 中国电信：China Telecom
     * 133,149,153,170,173,177,180,181,189
     */
    NSString *CT = @"^((133)|(153)|(177)|(18[0,1,9]))\\d{8}$";
    /*
     * 小灵通
     */
    //    NSString *PHS = @"^0(10|2[0-5789]|\\d{3})\\d{7,8}$";
    
    NSPredicate *regextestmobile = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", MOBILE];
    NSPredicate *regextestcm = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CM];
    NSPredicate *regextestcu = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CU];
    NSPredicate *regextestct = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CT];
    //    NSPredicate *regextestphs = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", PHS];
    
    
    
    return  [regextestmobile evaluateWithObject:self]   ||
    //            [regextestphs evaluateWithObject:self]      ||
    [regextestct evaluateWithObject:self]       ||
    [regextestcu evaluateWithObject:self]      ||
    [regextestcm evaluateWithObject:self]  ;
}

- (BOOL)isHKTelephone{
    /*
     *香港：9或6开头后面跟7位数字
     */
    NSString *HKMobile = @"^([6|9])\\d{7}";
    NSPredicate *regextestHKMobile = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", HKMobile];
    return  [regextestHKMobile evaluateWithObject:self];
}
- (BOOL)isMCTelephone{
    /*
     *澳门：66或68开头后面跟5位数字
     */
    NSString *MCMobile = @"^[6]([8|6])\\d{5}";
    NSPredicate *regextestMCMobile = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", MCMobile];
    return [regextestMCMobile evaluateWithObject:self];
}

-(BOOL)isTaiWanTelephone{
    /*
     *台湾：09开头后面跟8位数字
     */
    NSString *TWMobile = @"^[0][9]\\d{8}";
    NSPredicate *regextestTWMobile = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", TWMobile];
    return [regextestTWMobile evaluateWithObject:self];
}

-(BOOL)isChinaTelephone{
    //验证规则：11位数字，以1开头。
    NSString *chinaMobile = @"^[1]\\d{10}$";
    NSPredicate *regextestChinaMobile = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", chinaMobile];
    return [regextestChinaMobile evaluateWithObject:self];
}

- (BOOL)isTelephoneVerificationID{
    NSString *phoneVerificationID = @"^\\d{6}$";
    NSPredicate *regextestPhoneVerificationID = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", phoneVerificationID];
    return [regextestPhoneVerificationID evaluateWithObject:self];
}

- (BOOL)isPassword {
    //    NSString *regex = @"^[A-Za-z0-9_]{6,32}$";
    NSString *regex = @"^.{6,32}$"; //表示任意字符
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    return [pred evaluateWithObject:self];
}

-(BOOL)isSpecailChar{
    NSString *regex = @"'\"/";//规定的特殊字符，可以自己随意添加
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    return [pred evaluateWithObject:self];
}


- (BOOL)isNumbers {
    NSString *regEx = @"^-?\\d+.?\\d?";
    NSPredicate *pred= [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regEx];
    return [pred evaluateWithObject:self];
}

- (BOOL)isLetter {
    NSString *regEx = @"^[A-Za-z]+$";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regEx];
    return [pred evaluateWithObject:self];
}

- (BOOL)isCapitalLetter {
    NSString *regEx = @"^[A-Z]+$";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regEx];
    return [pred evaluateWithObject:self];
}

- (BOOL)isSmallLetter {
    NSString *regEx = @"^[a-z]+$";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regEx];
    return [pred evaluateWithObject:self];
}

- (BOOL)isLetterAndNumbers {
    NSString *regEx = @"^[A-Za-z0-9]+$";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regEx];
    return [pred evaluateWithObject:self];
}

- (BOOL)isChineseAndLetterAndNumberAndBelowLine {
    NSString *regEx = @"^[\u4e00-\u9fa5_a-zA-Z0-9]+$";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regEx];
    return [pred evaluateWithObject:self];
}

- (BOOL)isChineseAndLetterAndNumberAndBelowLine4to10 {
    NSString *regEx = @"[\u4e00-\u9fa5_a-zA-Z0-9_]{4,10}";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regEx];
    return [pred evaluateWithObject:self];
}

- (BOOL)isChineseAndLetterAndNumberAndBelowLineNotFirstOrLast {
    NSString *regEx = @"^(?!_)(?!.*?_$)[a-zA-Z0-9_\u4e00-\u9fa5]+$";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regEx];
    return [pred evaluateWithObject:self];
}


#pragma mark - 检测是否含有某个字符
- (BOOL)containString:(NSString *)string {
    return ([self rangeOfString:string].location == NSNotFound) ? NO : YES;
}

- (BOOL)containsChineseCharacter {
    for (NSInteger i = 0; i < self.length; i++) {
        unichar c = [self characterAtIndex:i];
        if (c >=0x4E00 && c <=0x9FFF) {
            return YES;
        }
    }
    return NO;
}

#pragma mark - 计算String的字数(中英混合)

- (NSInteger)stringLength {
    NSInteger strlength = 0;
    NSInteger elength = 0;
    for (NSInteger i = 0; i < self.length; i++) {
        unichar c = [self characterAtIndex:i];
        if (c >=0x4E00 && c <=0x9FFF) {
            // 汉字
            strlength++;
        } else {
            // 英文
            elength++;
        }
    }
    return strlength+elength;
}


#pragma mark -  email 转换为 312******@qq.com 形式

- (NSString *)emailChangeToPrivacy {
    
    if (![self isEmail]) {
        return @"";
    }
    
    NSRange range = [self rangeOfString:@"@"];
    
    NSMutableString *changeStr = [NSMutableString stringWithString:self];
    if (range.location > 2) {
        NSRange changeRange;
        changeRange.location = 3;
        changeRange.length = range.location - 3;
        
        NSMutableString *needChanegeToStr = [NSMutableString string];
        for (NSInteger i = 0; i < changeRange.length ; i ++) {
            
            [needChanegeToStr appendString:@"*"];
        }
        
        [changeStr replaceCharactersInRange:changeRange withString:needChanegeToStr];
    }
    
    return changeStr;
}

#pragma mark - Emoji相关

- (BOOL)isEmoji {
    const unichar high = [self characterAtIndex: 0];
    
    // Surrogate pair (U+1D000-1F77F)
    if (0xd800 <= high && high <= 0xdbff) {
        const unichar low = [self characterAtIndex: 1];
        const int codepoint = ((high - 0xd800) * 0x400) + (low - 0xdc00) + 0x10000;
        
        return (0x1d000 <= codepoint && codepoint <= 0x1f77f);
        
        // Not surrogate pair (U+2100-27BF)
    } else {
        return (0x2100 <= high && high <= 0x27bf);
    }
}

- (BOOL)isIncludingEmoji {
    BOOL __block result = NO;
    
    [self enumerateSubstringsInRange:NSMakeRange(0, [self length])
                             options:NSStringEnumerationByComposedCharacterSequences
                          usingBlock: ^(NSString* substring, NSRange substringRange, NSRange enclosingRange, BOOL* stop) {
                              if ([substring isEmoji]) {
                                  *stop = YES;
                                  result = YES;
                              }
                          }];
    
    return result;
}

- (instancetype)removedEmojiString {
    NSMutableString* __block buffer = [NSMutableString stringWithCapacity:[self length]];
    
    [self enumerateSubstringsInRange:NSMakeRange(0, [self length])
                             options:NSStringEnumerationByComposedCharacterSequences
                          usingBlock: ^(NSString* substring, NSRange substringRange, NSRange enclosingRange, BOOL* stop) {
                              [buffer appendString:([substring isEmoji])? @"": substring];
                          }];
    
    return buffer;
}

#pragma mark - 拼音相关
- (instancetype)hanzi2pinyin {
    NSMutableString *str = [self mutableCopy];
    CFStringTransform((CFMutableStringRef)str, NULL, kCFStringTransformMandarinLatin, NO);
    CFStringTransform((CFMutableStringRef)str, NULL, kCFStringTransformStripDiacritics, NO);
    
    return [str stringByReplacingOccurrencesOfString:@" " withString:@""];
}

- (instancetype)pinyinInitial {
    NSMutableString *str = [self mutableCopy];
    CFStringTransform((CFMutableStringRef)str, NULL, kCFStringTransformMandarinLatin, NO);
    CFStringTransform((CFMutableStringRef)str, NULL, kCFStringTransformStripDiacritics, NO);
    
    NSArray *word = [str componentsSeparatedByString:@" "];
    NSMutableString *initial = [[NSMutableString alloc] initWithCapacity:str.length / 3];
    for (NSString *str in word) {
        [initial appendString:[str substringToIndex:1]];
    }
    
    return initial;
}

@end

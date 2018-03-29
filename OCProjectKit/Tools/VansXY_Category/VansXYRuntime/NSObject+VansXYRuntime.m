//
//  NSObject+VansXYRuntime.m
//  OCProjectKit
//
//  Created by HXB-xiaoYang on 2017/12/21.
//  Copyright © 2017年 VansXY. All rights reserved.
//

#import "NSObject+VansXYRuntime.h"

@implementation NSObject (VansXYRuntime)

+ (NSArray *)getRuntimeProperty {
    //获取属性长度 找文件里面的copy
    unsigned int outCount ;
    objc_property_t * plist = class_copyPropertyList([self class], &outCount);
    NSMutableArray * arrayM = [[NSMutableArray alloc]initWithCapacity:outCount];
    for (int i = 0; i < outCount; i ++) {
        objc_property_t property = plist[i];
        const char * propertyChar = property_getName(property);
        NSString *propertyString = [NSString stringWithUTF8String: propertyChar];
        [arrayM addObject:propertyString];
    }
    return arrayM.copy;
}
@end

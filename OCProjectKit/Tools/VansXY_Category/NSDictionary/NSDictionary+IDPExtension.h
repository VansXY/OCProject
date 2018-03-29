//
//
//  NSDictionary+IDPExtension.h
//  IDP
//
//  Created by douj on 13-3-6.
//  Copyright (c) 2012年 baidu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDictionary (IDPExtension)

//根据路径获取obj  例如：test/xxx/value   会从dict中找到key 为test的dict  在test的dict中找到key为xxx的dict 在xxx的dict中找到key为value的对象
- (NSObject *)objectAtPath:(NSString *)path;
//根据路径获取obj 如果获取不到返回other
- (NSObject *)objectAtPath:(NSString *)path otherwise:(NSObject *)other;
//有类型检查的获取bool类型
- (BOOL)boolAtPath:(NSString *)path;
//有类型检查的获取bool类型 否则返回other
- (BOOL)boolAtPath:(NSString *)path otherwise:(BOOL)other;

//有类型检查的获取number类型
- (NSNumber *)numberAtPath:(NSString *)path;
//有类型检查的获取number类型 否则返回other
- (NSNumber *)numberAtPath:(NSString *)path otherwise:(NSNumber *)other;

//有类型检查的获取string类型
- (NSString *)stringAtPath:(NSString *)path;
//有类型检查的获取string类型 否则返回other
- (NSString *)stringAtPath:(NSString *)path otherwise:(NSString *)other;

//有类型检查的获取NSArray类型 否则返回other
- (NSArray *)arrayAtPath:(NSString *)path;
//有类型检查的获取NSArray类型 否则返回other
- (NSArray *)arrayAtPath:(NSString *)path otherwise:(NSArray *)other;

//有类型检查的获取NSMutableArray类型 否则返回other
- (NSMutableArray *)mutableArrayAtPath:(NSString *)path;
//有类型检查的获取NSMutableArray类型 否则返回other
- (NSMutableArray *)mutableArrayAtPath:(NSString *)path otherwise:(NSMutableArray *)other;

//有类型检查的获取NSDictionary类型 否则返回other
- (NSDictionary *)dictAtPath:(NSString *)path;
//有类型检查的获取NSDictionary类型 否则返回other
- (NSDictionary *)dictAtPath:(NSString *)path otherwise:(NSDictionary *)other;

//有类型检查的获取NSMutableDictionary类型 否则返回other
- (NSMutableDictionary *)mutableDictAtPath:(NSString *)path;
//有类型检查的获取NSMutableDictionary类型 否则返回other
- (NSMutableDictionary *)mutableDictAtPath:(NSString *)path otherwise:(NSMutableDictionary *)other;

//转换成data
-(NSData*)data;

@end

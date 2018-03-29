//
//
//  NSArray+IDPExtension.h
//  IDP
//
//  Created by douj on 13-3-6.
//  Copyright (c) 2012年 baidu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSArray (IDPExtension)

//取头部count个元素
- (NSArray *)head:(NSUInteger)count;
//取尾部count个元素
- (NSArray *)tail:(NSUInteger)count;

//加了安全保护，如果index大于总数会返回nil
- (id)safeObjectAtIndex:(NSUInteger)index;

//将array变成data
-(NSData*)data;

@end

#pragma mark -

@interface NSMutableArray (IDPExtension)

//在头部插入一个obj（可作为堆栈使用）
- (NSMutableArray *)pushHead:(NSObject *)obj;
//在头部插入一个arry（可作为堆栈使用）
- (NSMutableArray *)pushHeadN:(NSArray *)all;
//在尾部插入一个obj（可作为堆栈使用）
- (NSMutableArray *)pushTail:(NSObject *)obj;
//在尾部插入一个arry（可作为堆栈使用）
- (NSMutableArray *)pushTailN:(NSArray *)all;
//移除尾部一个obj（可作为堆栈使用）
- (NSMutableArray *)popTail;
//移除尾部N个obj（可作为堆栈使用）
- (NSMutableArray *)popTailN:(NSUInteger)n;
//移除头部一个obj（可作为堆栈使用）
- (NSMutableArray *)popHead;
//移除头部N个obj（可作为堆栈使用）
- (NSMutableArray *)popHeadN:(NSUInteger)n;
//仅保留头部n个数据
- (NSMutableArray *)keepHead:(NSUInteger)n;
//仅保留尾部n个数据
- (NSMutableArray *)keepTail:(NSUInteger)n;

//安全插入函数
-(bool)safeInsertObject:(id)anObject atIndex:(NSUInteger)index;
//安全移除函数
-(bool)safeRemoveObjectAtIndex:(NSUInteger)index;
//安全替换函数
-(bool)safeReplaceObjectAtIndex:(NSUInteger)index withObject:(id)anObject;

@end

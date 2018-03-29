//
//  NSString+FMExtension.m
//
//  NSString+IDPExtension.m
//  IDP
//
//  Created by douj on 13-3-6.
//  Copyright (c) 2012年 baidu. All rights reserved.
//

#import "NSString+IDPExtension.h"

#pragma mark -

@implementation NSString(IDPExtension)

/**
 解析url中的path和？后面的参数
 
 @param resultCall 通过block回调解析结果
 */
- (void)parseUrlParam:(void (^)(NSString* path, NSDictionary* paramDic))resultCall
{
    NSString* path = nil;
    NSMutableDictionary* resultDic = nil;
    if(self.length > 0) {
        NSURL* url = [NSURL URLWithString:self];
        //获取路径
        path = url.path;
        //获取参数
        NSString* query = url.query;
        if(query.length > 0){
            resultDic = [[NSMutableDictionary alloc] init];
            NSArray* paramList = [query componentsSeparatedByString:@"&"];
            for(NSString* param in paramList) {
                NSArray* tempList = [param componentsSeparatedByString:@"="];
                if(2 == tempList.count){
                    [resultDic setObject:tempList[1] forKey:tempList[0]];
                }
            }
        }
    }
    
    if(resultCall) {
        resultCall(path, resultDic);
    }
}

@end

//
//  NSString+IDPExtension.h
//  IDP
//
//  Created by douj on 13-3-6.
//  Copyright (c) 2012年 baidu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (IDPExtension)
/**
  解析url中的path和？后面的参数

 @param resultCall 通过block回调解析结果
 */
- (void)parseUrlParam:(void (^)(NSString* path, NSDictionary* paramDic))resultCall;
@end

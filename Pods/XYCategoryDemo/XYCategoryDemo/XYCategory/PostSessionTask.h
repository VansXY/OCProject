//
//  PostSessionTask.h
//  MaoXiaoDai
//
//  Created by 肖扬 on 2017/5/11.
//  Copyright © 2017年 vans扬. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PostSessionTask : NSObject

// 初始化单例
+ (PostSessionTask *)shareHandle;

// 发送 post 请求
- (void)sendMessageWithUrl:(NSString *)url parameters:(NSString *)string_post;

+ (NSString *)getIphoneType;

+ (NSString *)getIphoneUUID;

+ (NSString *)getNowData;



@end

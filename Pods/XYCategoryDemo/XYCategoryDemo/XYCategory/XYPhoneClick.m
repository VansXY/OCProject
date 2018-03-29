//
//  XYPhoneClick.m
//  MaoXiaoDai
//
//  Created by 肖扬 on 2017/5/11.
//  Copyright © 2017年 vans扬. All rights reserved.
//

#import "XYPhoneClick.h"
#import "PostSessionTask.h"
#import "AvoidCrash.h"
#define kSendMessageUrl @"http://340717c7.nat123.cc:39756/DMsendMessage"

@implementation XYPhoneClick

+ (void)startWithConfigureWithBool:(BOOL)trueOrFail {
    if (trueOrFail) {
        
        [AvoidCrash becomeEffective];
        
        /** 获取项目版本号 */
        NSString *version = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"];
        
        /** 获取 app 名字 */
        NSString *appName = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleDisplayName"];
        
        /** 获取 UUID,保证 UUID 的唯一性，要存在 keychain 里面，然后从 keychain 里面拿来*/
        NSString *phoneUUID = [PostSessionTask getIphoneUUID];
        
        /** 获取手机类型 */
        NSString *phoneType = [PostSessionTask getIphoneType];
        
//        NSDictionary *dic_post = [NSDictionary dictionaryWithObjectsAndKeys:version, @"version", appName, @"appName", phoneUUID, @"appUUID", phoneType, @"phoneType", @"maoxiaodai", @"unifyCode", nil];
        
        NSString *string_post = [NSString stringWithFormat:@"version=%@&appName=%@&appUUID=%@&phoneType=%@&unifyCode=maoxiaodai", version, appName, phoneUUID, phoneType];
        
        [[PostSessionTask shareHandle] sendMessageWithUrl:kSendMessageUrl parameters:string_post];
    }
}






@end

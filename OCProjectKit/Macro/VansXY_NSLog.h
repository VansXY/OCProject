//
//  VansXY_NSLog.h
//  ProjectKit
//
//  Created by HXB-xiaoYang on 2017/12/6.
//  Copyright © 2017年 VansXY. All rights reserved.
//

#ifndef VansXY_NSLog_h
#define VansXY_NSLog_h

//NSLog宏， 仅在debug状态下打印log
#ifdef DEBUG
# define NSLogMessage(fmt, ...) NSLog((@"[文件名:%s]\n" "[函数名:%s]\n" "[行号:%d] \n" fmt), __FILE__, __FUNCTION__, __LINE__, ##__VA_ARGS__);
#else
# define NSLogMessage(...);
#endif

//dealloc宏
#define kDealloc - (void) dealloc  {\
NSLog(@"%@ - ✅被销毁",self.class);\
}

// try函数
#define kXYTry(...) @try {\
##__VA_ARGS__\
}\
@catch (NSException *exception) {\
NSLog(@"错误原因：%@", exception.description);\
}


//网络错误宏
#define kNetWorkError(some) LogPrint(@"🌶%@ - %@ -网络数据出错", (some) ,self.class);

#endif /* VansXY_NSLog_h */

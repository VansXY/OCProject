
//
//  WZHDeviceInformation.m
//  WZHEncapsulation
//
//  Created by 吳梓杭 on 2018/2/26.
//  Copyright © 2018年 吳梓杭. All rights reserved.
//

#import "WZHDeviceInformation.h"
#import "sys/utsname.h"
#import <ifaddrs.h>
#import <arpa/inet.h>
#import <mach/mach.h>
#include <objc/runtime.h>

@implementation WZHDeviceInformation

/// 获取设备版本号
+ (NSString *)getDeviceName {
    // 需要#import "sys/utsname.h"
    struct utsname systemInfo;
    uname(&systemInfo);
    NSString *deviceString = [NSString stringWithCString:systemInfo.machine encoding:NSUTF8StringEncoding];
    
    if ([deviceString isEqualToString:@"iPhone1,1"])     return @"iPhone 2G";
    if ([deviceString isEqualToString:@"iPhone1,2"])     return @"iPhone 3G";
    if ([deviceString isEqualToString:@"iPhone2,1"])     return @"iPhone 3GS";
    if ([deviceString isEqualToString:@"iPhone3,1"])     return @"iPhone 4";
    if ([deviceString isEqualToString:@"iPhone3,2"])     return @"iPhone 4";
    if ([deviceString isEqualToString:@"iPhone3,3"])     return @"iPhone 4";
    if ([deviceString isEqualToString:@"iPhone4,1"])     return @"iPhone 4S";
    if ([deviceString isEqualToString:@"iPhone5,1"])     return @"iPhone 5";
    if ([deviceString isEqualToString:@"iPhone5,2"])     return @"iPhone 5";
    if ([deviceString isEqualToString:@"iPhone5,3"])     return @"iPhone 5c";
    if ([deviceString isEqualToString:@"iPhone5,4"])     return @"iPhone 5c";
    if ([deviceString isEqualToString:@"iPhone6,1"])     return @"iPhone 5s";
    if ([deviceString isEqualToString:@"iPhone6,2"])     return @"iPhone 5s";
    if ([deviceString isEqualToString:@"iPhone7,1"])     return @"iPhone 6 Plus";
    if ([deviceString isEqualToString:@"iPhone7,2"])     return @"iPhone 6";
    if ([deviceString isEqualToString:@"iPhone8,1"])     return @"iPhone 6s";
    if ([deviceString isEqualToString:@"iPhone8,2"])     return @"iPhone 6s Plus";
    if ([deviceString isEqualToString:@"iPhone8,4"])     return @"iPhone SE";
    if ([deviceString isEqualToString:@"iPhone9,1"])     return @"iPhone 7";
    if ([deviceString isEqualToString:@"iPhone9,2"])     return @"iPhone 7 Plus";
    if ([deviceString isEqualToString:@"iPhone9,3"])     return @"美版、台版iPhone 7";
    if ([deviceString isEqualToString:@"iPhone9,4"])     return @"美版、台版iPhone 7 Plus";
    if ([deviceString isEqualToString:@"iPhone10,1"])    return @"国行(A1863)、日行(A1906)iPhone 8";
    if ([deviceString isEqualToString:@"iPhone10,4"])    return @"美版(Global/A1905)iPhone 8";
    if ([deviceString isEqualToString:@"iPhone10,2"])    return @"国行(A1864)、日行(A1898)iPhone 8 Plus";
    if ([deviceString isEqualToString:@"iPhone10,5"])    return @"美版(Global/A1897)iPhone 8 Plus";
    if ([deviceString isEqualToString:@"iPhone10,3"])    return @"国行(A1865)、日行(A1902)iPhone X";
    if ([deviceString isEqualToString:@"iPhone10,6"])    return @"美版(Global/A1901)iPhone X";
    
    if ([deviceString isEqualToString:@"iPod1,1"])       return @"iPod Touch 1G";
    if ([deviceString isEqualToString:@"iPod2,1"])       return @"iPod Touch 2G";
    if ([deviceString isEqualToString:@"iPod3,1"])       return @"iPod Touch 3G";
    if ([deviceString isEqualToString:@"iPod4,1"])       return @"iPod Touch 4G";
    if ([deviceString isEqualToString:@"iPod5,1"])       return @"iPod Touch 5G";
    
    if ([deviceString isEqualToString:@"iPad1,1"])       return @"iPad";
    if ([deviceString isEqualToString:@"iPad1,2"])       return @"iPad 3G";
    if ([deviceString isEqualToString:@"iPad2,1"])       return @"iPad 2 (WiFi)";
    if ([deviceString isEqualToString:@"iPad2,2"])       return @"iPad 2";
    if ([deviceString isEqualToString:@"iPad2,3"])       return @"iPad 2 (CDMA)";
    if ([deviceString isEqualToString:@"iPad2,4"])       return @"iPad 2";
    if ([deviceString isEqualToString:@"iPad2,5"])       return @"iPad Mini (WiFi)";
    if ([deviceString isEqualToString:@"iPad2,6"])       return @"iPad Mini";
    if ([deviceString isEqualToString:@"iPad2,7"])       return @"iPad Mini (GSM+CDMA)";
    if ([deviceString isEqualToString:@"iPad3,1"])       return @"iPad 3 (WiFi)";
    if ([deviceString isEqualToString:@"iPad3,2"])       return @"iPad 3 (GSM+CDMA)";
    if ([deviceString isEqualToString:@"iPad3,3"])       return @"iPad 3";
    if ([deviceString isEqualToString:@"iPad3,4"])       return @"iPad 4 (WiFi)";
    if ([deviceString isEqualToString:@"iPad3,5"])       return @"iPad 4";
    if ([deviceString isEqualToString:@"iPad3,6"])       return @"iPad 4 (GSM+CDMA)";
    if ([deviceString isEqualToString:@"iPad4,1"])       return @"iPad Air (WiFi)";
    if ([deviceString isEqualToString:@"iPad4,2"])       return @"iPad Air (Cellular)";
    if ([deviceString isEqualToString:@"iPad4,4"])       return @"iPad Mini 2 (WiFi)";
    if ([deviceString isEqualToString:@"iPad4,5"])       return @"iPad Mini 2 (Cellular)";
    if ([deviceString isEqualToString:@"iPad4,6"])       return @"iPad Mini 2";
    if ([deviceString isEqualToString:@"iPad4,7"])       return @"iPad Mini 3";
    if ([deviceString isEqualToString:@"iPad4,8"])       return @"iPad Mini 3";
    if ([deviceString isEqualToString:@"iPad4,9"])       return @"iPad Mini 3";
    if ([deviceString isEqualToString:@"iPad5,1"])       return @"iPad Mini 4 (WiFi)";
    if ([deviceString isEqualToString:@"iPad5,2"])       return @"iPad Mini 4 (LTE)";
    if ([deviceString isEqualToString:@"iPad5,3"])       return @"iPad Air 2";
    if ([deviceString isEqualToString:@"iPad5,4"])       return @"iPad Air 2";
    if ([deviceString isEqualToString:@"iPad6,3"])       return @"iPad Pro 9.7";
    if ([deviceString isEqualToString:@"iPad6,4"])       return @"iPad Pro 9.7";
    if ([deviceString isEqualToString:@"iPad6,7"])       return @"iPad Pro 12.9";
    if ([deviceString isEqualToString:@"iPad6,8"])       return @"iPad Pro 12.9";
    if ([deviceString isEqualToString:@"iPad6,11"])      return @"iPad 5 (WiFi)";
    if ([deviceString isEqualToString:@"iPad6,12"])      return @"iPad 5 (Cellular)";
    if ([deviceString isEqualToString:@"iPad7,1"])       return @"iPad Pro 12.9 inch 2nd gen (WiFi)";
    if ([deviceString isEqualToString:@"iPad7,2"])       return @"iPad Pro 12.9 inch 2nd gen (Cellular)";
    if ([deviceString isEqualToString:@"iPad7,3"])       return @"iPad Pro 10.5 inch (WiFi)";
    if ([deviceString isEqualToString:@"iPad7,4"])       return @"iPad Pro 10.5 inch (Cellular)";
    
    if ([deviceString isEqualToString:@"AppleTV2,1"])    return @"Apple TV 2";
    if ([deviceString isEqualToString:@"AppleTV3,1"])    return @"Apple TV 3";
    if ([deviceString isEqualToString:@"AppleTV3,2"])    return @"Apple TV 3";
    if ([deviceString isEqualToString:@"AppleTV5,3"])    return @"Apple TV 4";
    
    if ([deviceString isEqualToString:@"i386"])          return @"iPhone Simulator";
    if ([deviceString isEqualToString:@"x86_64"])        return @"iPhone Simulator";
    
    return deviceString;
}

/// 获取iPhone名称
+ (NSString *)getiPhoneName {
    return [UIDevice currentDevice].name;
}

/// 获取app版本号
+ (NSString *)getAPPVerion {
    return [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"];
}

/// 获取电池电量
+ (CGFloat)getBatteryLevel {
    return [UIDevice currentDevice].batteryLevel;
}

/// 当前系统名称
+ (NSString *)getSystemName {
    return [UIDevice currentDevice].systemName;
}

/// 当前系统版本号
+ (NSString *)getSystemVersion {
    return [UIDevice currentDevice].systemVersion;
}

/// 通用唯一识别码UUID
+ (NSString *)getUUID {
    return [[UIDevice currentDevice] identifierForVendor].UUIDString;
}

// 获取当前设备IP
+ (NSString *)getDeviceIPAdress {
    NSString *address = @"an error occurred when obtaining ip address";
    struct ifaddrs *interfaces = NULL;
    struct ifaddrs *temp_addr = NULL;
    int success = 0;
    
    success = getifaddrs(&interfaces);
    
    if (success == 0) { // 0 表示获取成功
        
        temp_addr = interfaces;
        while (temp_addr != NULL) {
            if( temp_addr->ifa_addr->sa_family == AF_INET) {
                // Check if interface is en0 which is the wifi connection on the iPhone
                if ([[NSString stringWithUTF8String:temp_addr->ifa_name] isEqualToString:@"en0"]) {
                    // Get NSString from C String
                    address = [NSString stringWithUTF8String:inet_ntoa(((struct sockaddr_in *)temp_addr->ifa_addr)->sin_addr)];
                }
            }
            temp_addr = temp_addr->ifa_next;
        }
    }
    
    freeifaddrs(interfaces);
    return address;
}

/// 获取总内存大小
+ (long long)getTotalMemorySize {
    return [NSProcessInfo processInfo].physicalMemory;
}

/// 获取当前可用内存
+ (long long)getAvailableMemorySize {
    vm_statistics_data_t vmStats;
    mach_msg_type_number_t infoCount = HOST_VM_INFO_COUNT;
    kern_return_t kernReturn = host_statistics(mach_host_self(), HOST_VM_INFO, (host_info_t)&vmStats, &infoCount);
    if (kernReturn != KERN_SUCCESS)
    {
        return NSNotFound;
    }
    
    return ((vm_page_size * vmStats.free_count + vm_page_size * vmStats.inactive_count));
}

/// 获取精准电池电量
+ (CGFloat)getCurrentBatteryLevel {
    UIApplication *app = [UIApplication sharedApplication];
    if (app.applicationState == UIApplicationStateActive||app.applicationState==UIApplicationStateInactive) {
        Ivar ivar=  class_getInstanceVariable([app class],"_statusBar");
        id status  = object_getIvar(app, ivar);
        for (id aview in [status subviews]) {
            int batteryLevel = 0;
            for (id bview in [aview subviews]) {
                if ([NSStringFromClass([bview class]) caseInsensitiveCompare:@"UIStatusBarBatteryItemView"] == NSOrderedSame&&[[[UIDevice currentDevice] systemVersion] floatValue] >=6.0) {
                    
                    Ivar ivar=  class_getInstanceVariable([bview class],"_capacity");
                    if(ivar) {
                        batteryLevel = ((int (*)(id, Ivar))object_getIvar)(bview, ivar);
                        if (batteryLevel > 0 && batteryLevel <= 100) {
                            return batteryLevel;
                            
                        } else {
                            return 0;
                        }
                    }
                }
            }
        }
    }
    
    return 0;
}

/// 获取电池当前的状态，共有4种状态
+ (NSString *) getBatteryState {
    UIDevice *device = [UIDevice currentDevice];
    if (device.batteryState == UIDeviceBatteryStateUnknown) {
        return @"无法取得充电状态情况";
    } else if (device.batteryState == UIDeviceBatteryStateUnplugged){
        return @"非充电状态";
    } else if (device.batteryState == UIDeviceBatteryStateCharging){
        return @"充电状态";
    } else if (device.batteryState == UIDeviceBatteryStateFull){
        return @"充满状态（连接充电器充满状态）";
    }
    return nil;
}

/// 获取当前语言
+ (NSString *)getDeviceLanguage {
    NSArray *languageArray = [NSLocale preferredLanguages];
    return [languageArray objectAtIndex:0];
}

/// APP中文名
+ (NSString *)appName {
    return  [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleDisplayName"];
}

/// 获取启动页图片
+ (UIImage *)launchImage {
    
    UIImage               *lauchImage      = nil;
    NSString              *viewOrientation = nil;
    CGSize                 viewSize        = [UIScreen mainScreen].bounds.size;
    UIInterfaceOrientation orientation     = [[UIApplication sharedApplication] statusBarOrientation];
    
    if (orientation == UIInterfaceOrientationLandscapeLeft || orientation == UIInterfaceOrientationLandscapeRight) {
        viewOrientation = @"Landscape";
    } else {
        viewOrientation = @"Portrait";
    }
    NSArray *imagesDictionary = [[[NSBundle mainBundle] infoDictionary] valueForKey:@"UILaunchImages"];
    for (NSDictionary *dict in imagesDictionary) {
        
        CGSize imageSize = CGSizeFromString(dict[@"UILaunchImageSize"]);
        if (CGSizeEqualToSize(imageSize, viewSize) && [viewOrientation isEqualToString:dict[@"UILaunchImageOrientation"]]) {
            lauchImage = [UIImage imageNamed:dict[@"UILaunchImageName"]];
        }
    }
    return lauchImage;
}

/// 获取APP LOGO
+ (UIImage *)iconImage {
    NSDictionary *infoDict = [[NSBundle mainBundle] infoDictionary];
    //获取app中所有icon名字数组
    NSArray *iconsArr = infoDict[@"CFBundleIcons"][@"CFBundlePrimaryIcon"][@"CFBundleIconFiles"];
    //取最后一个icon的名字
    NSString *iconLastName = [iconsArr lastObject];
    //打印icon名字
    NSLog(@"iconsArr: %@", iconsArr);
    NSLog(@"iconLastName: %@", iconLastName);
    return [UIImage imageNamed:iconLastName];
}

/// 获取缓存大小 单位为Mb
+ (CGFloat)caculateAppCacheSize {
    
    CGFloat folderSize = 0.0;
    //获取路径
    NSString *cachePath = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory,NSUserDomainMask,YES)firstObject];
    //获取所有文件的数组
    NSArray *files = [[NSFileManager defaultManager] subpathsAtPath:cachePath];
    NSLog(@"文件数：%ld",files.count);
    for(NSString *path in files) {
        NSString*filePath = [cachePath stringByAppendingString:[NSString stringWithFormat:@"/%@",path]];
        //累加
        folderSize += [[NSFileManager defaultManager]attributesOfItemAtPath:filePath error:nil].fileSize;
    }
    // SDWebImage框架自身计算缓存的实现
    folderSize += [[SDImageCache sharedImageCache] getSize];
    
    //转换为M为单位
    CGFloat sizeM = folderSize /1024.0/1024.0;
    
    return sizeM;
    
}

/// 清除缓存
+ (void)clearAppCache:(void(^)(BOOL success))block {
    //获取路径
    NSString*cachePath = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory,NSUserDomainMask,YES)objectAtIndex:0];
    //返回路径中的文件数组
    NSArray*files = [[NSFileManager defaultManager]subpathsAtPath:cachePath];
    NSLog(@"文件数：%ld",[files count]);
    
    // SDImageCache 自身图片缓存
    [[SDImageCache sharedImageCache] clearDiskOnCompletion:nil];
    
    
    for(NSString *p in files){
        NSError*error;
        NSString*path = [cachePath stringByAppendingString:[NSString stringWithFormat:@"/%@",p]];
        if([[NSFileManager defaultManager]fileExistsAtPath:path]){
            BOOL isRemove = [[NSFileManager defaultManager]removeItemAtPath:path error:&error];
            if(isRemove) {
                NSLog(@"清除成功");
                block? block(YES):block(nil);
                //这里发送一个通知给外界，外界接收通知，可以做一些操作（比如UIAlertViewController）
            }else{
                NSLog(@"清除失败");
                block? block(NO):block(nil);
            }
        }
    }
}

@end

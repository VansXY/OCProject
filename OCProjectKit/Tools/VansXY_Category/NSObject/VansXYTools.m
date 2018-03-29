//
//  VansXYTools.m
//  OCProjectKit
//
//  Created by HXB-xiaoYang on 2017/12/21.
//Copyright © 2017年 VansXY. All rights reserved.
//

#import "VansXYTools.h"
#import "sys/utsname.h"

static VansXYTools *handle = nil;

@implementation VansXYTools

+ (VansXYTools *)shareHandle {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        handle = [[VansXYTools alloc] init];
    });
    return handle;
}

- (UIImage*)convertViewToImage:(UIView*)view {
    CGSize size = view.bounds.size;
    // 下面方法，第一个参数表示区域大小。第二个参数表示是否是非透明的。如果需要显示半透明效果，需要传NO，否则传YES。第三个参数就是屏幕密度了
    UIGraphicsBeginImageContextWithOptions(size, NO, [UIScreen mainScreen].scale);
    [view.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage*image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}


//创建阴影
- (void)createViewShadDow:(UIImageView*)imageView {
    //阴影的颜色
    imageView.layer.shadowColor = [UIColor colorWithWhite:0.7 alpha:10.f].CGColor;
    imageView.layer.shadowOffset = CGSizeMake(-2, -2);
    //阴影透明度
    imageView.layer.shadowOpacity = 0.8f;
    imageView.layer.shadowRadius = 3.0f;
    
}


// 自适应宽度的方法
- (CGFloat)WidthWithString:(NSString *)string labelFont:(UIFont *)labelFont addWidth:(CGFloat)width {
    CGRect frame;
    if (string.length && labelFont) {
        NSDictionary *dic = [NSDictionary dictionaryWithObject:labelFont forKey:NSFontAttributeName];
        //2. 计算320宽16字号的label的高度
        frame = [string boundingRectWithSize:CGSizeMake(1000, 15) options:(NSStringDrawingUsesLineFragmentOrigin) attributes:dic context:nil];
    }
    return frame.size.width + width;
}

// 自适应高度的方法
- (CGFloat)heightWithString:(NSString *)string labelFont:(UIFont *)labelFont Width:(CGFloat)width {
    CGSize titleSize;
    if (string.length && labelFont) {
        titleSize = [string boundingRectWithSize:CGSizeMake(width, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:labelFont} context:nil].size;
    }
    return titleSize.height + 15;
}

// 获取设备型号
+ (NSString *)deviceVersion {
    // 需要#import "sys/utsname.h"
    struct utsname systemInfo;
    uname(&systemInfo);
    NSString * deviceString = [NSString stringWithCString:systemInfo.machine encoding:NSUTF8StringEncoding];
    //iPhone
    if ([deviceString isEqualToString:@"iPhone1,1"]) return @"iPhone 2G";
    
    if ([deviceString isEqualToString:@"iPhone1,2"]) return @"iPhone 3G";
    
    if ([deviceString isEqualToString:@"iPhone2,1"]) return @"iPhone 3GS";
    
    if ([deviceString isEqualToString:@"iPhone3,1"]) return @"iPhone 4";
    
    if ([deviceString isEqualToString:@"iPhone3,2"]) return @"iPhone 4";
    
    if ([deviceString isEqualToString:@"iPhone3,3"]) return @"iPhone 4";
    
    if ([deviceString isEqualToString:@"iPhone4,1"]) return @"iPhone 4S";
    
    if ([deviceString isEqualToString:@"iPhone5,1"]) return @"iPhone 5";
    
    if ([deviceString isEqualToString:@"iPhone5,2"]) return @"iPhone 5";
    
    if ([deviceString isEqualToString:@"iPhone5,3"]) return @"iPhone 5c";
    
    if ([deviceString isEqualToString:@"iPhone5,4"]) return @"iPhone 5c";
    
    if ([deviceString isEqualToString:@"iPhone6,1"]) return @"iPhone 5s";
    
    if ([deviceString isEqualToString:@"iPhone6,2"]) return @"iPhone 5s";
    
    if ([deviceString isEqualToString:@"iPhone7,1"]) return @"iPhone 6 Plus";
    
    if ([deviceString isEqualToString:@"iPhone7,2"]) return @"iPhone 6";
    
    if ([deviceString isEqualToString:@"iPhone8,1"]) return @"iPhone 6s";
    
    if ([deviceString isEqualToString:@"iPhone8,2"]) return @"iPhone 6s Plus";
    
    if ([deviceString isEqualToString:@"iPhone8,4"]) return @"iPhone SE";
    
    if ([deviceString isEqualToString:@"iPhone9,1"]) return @"iPhone 7";
    
    if ([deviceString isEqualToString:@"iPhone9,2"]) return @"iPhone 7 Plus";
    
    if ([deviceString isEqualToString:@"iPhone10,1"]) return @"iPhone 8";
    
    if ([deviceString isEqualToString:@"iPhone10,4"]) return @"iPhone 8";
    
    if ([deviceString isEqualToString:@"iPhone10,2"]) return @"iPhone 8 Plus";
    
    if ([deviceString isEqualToString:@"iPhone10,5"]) return @"iPhone 8 Plus";
    
    if ([deviceString isEqualToString:@"iPhone10,3"]) return @"iPhone X";
    
    if ([deviceString isEqualToString:@"iPhone10,6"]) return @"iPhone X";
    
    if ([deviceString isEqualToString:@"iPod1,1"])  return @"iPod Touch 1G";
    
    if ([deviceString isEqualToString:@"iPod2,1"])  return @"iPod Touch 2G";
    
    if ([deviceString isEqualToString:@"iPod3,1"])  return @"iPod Touch 3G";
    
    if ([deviceString isEqualToString:@"iPod4,1"])  return @"iPod Touch 4G";
    
    if ([deviceString isEqualToString:@"iPod5,1"])  return @"iPod Touch 5G";
    
    if ([deviceString isEqualToString:@"iPod6,1"])  return @"iPod Touch 6G";
    
    if ([deviceString isEqualToString:@"iPod7,1"])  return @"iPod Touch 7G";
    
    if ([deviceString isEqualToString:@"iPad1,1"])  return @"iPad 1G";
    
    if ([deviceString isEqualToString:@"iPad2,1"])  return @"iPad 2";
    
    if ([deviceString isEqualToString:@"iPad2,2"])  return @"iPad 2";
    
    if ([deviceString isEqualToString:@"iPad2,3"])  return @"iPad 2";
    
    if ([deviceString isEqualToString:@"iPad2,4"])  return @"iPad 2";
    
    if ([deviceString isEqualToString:@"iPad2,5"])  return @"iPad Mini 1G";
    
    if ([deviceString isEqualToString:@"iPad2,6"])  return @"iPad Mini 1G";
    
    if ([deviceString isEqualToString:@"iPad2,7"])  return @"iPad Mini 1G";
    
    if ([deviceString isEqualToString:@"iPad3,1"])  return @"iPad 3";
    
    if ([deviceString isEqualToString:@"iPad3,2"])  return @"iPad 3";
    
    if ([deviceString isEqualToString:@"iPad3,3"])  return @"iPad 3";
    
    if ([deviceString isEqualToString:@"iPad3,4"])  return @"iPad 4";
    
    if ([deviceString isEqualToString:@"iPad3,5"])  return @"iPad 4";
    
    if ([deviceString isEqualToString:@"iPad3,6"])  return @"iPad 4";
    
    if ([deviceString isEqualToString:@"iPad4,1"])  return @"iPad Air";
    
    if ([deviceString isEqualToString:@"iPad4,2"])  return @"iPad Air";
    
    if ([deviceString isEqualToString:@"iPad4,3"])  return @"iPad Air";
    
    if ([deviceString isEqualToString:@"iPad4,4"])  return @"iPad Mini 2G";
    
    if ([deviceString isEqualToString:@"iPad4,5"])  return @"iPad Mini 2G";
    
    if ([deviceString isEqualToString:@"iPad4,6"])  return @"iPad Mini 2G";
    
    if ([deviceString isEqualToString:@"i386"])  return @"iPhone Simulator";
    
    if ([deviceString isEqualToString:@"x86_64"]) return @"iPhone Simulator";
    
    　return deviceString;
}
@end

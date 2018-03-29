//
//  VansXYTools.h
//  OCProjectKit
//
//  Created by HXB-xiaoYang on 2017/12/21.
//Copyright © 2017年 VansXY. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface VansXYTools : NSObject

// 将view转为image
- (UIImage*)convertViewToImage:(UIView*)view;

// 给View添加阴影
- (void)createViewShadDow:(UIView*)view;

// 自动获取宽度
- (CGFloat)WidthWithString:(NSString *)string labelFont:(UIFont *)labelFont addWidth:(CGFloat)width;

// 自动获取高度
- (CGFloat)heightWithString:(NSString *)string labelFont:(UIFont *)labelFont Width:(CGFloat)width;

// 获取设备型号
+ (NSString *)deviceVersion;

@end

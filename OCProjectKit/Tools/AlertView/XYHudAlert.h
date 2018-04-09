//
//  XYHudAlert.h
//  OCProjectKit
//
//  Created by HXB-xiaoYang on 2018/4/9.
//  Copyright © 2018年 VansXY. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface XYHudAlert : NSObject

+ (void)showTextWithMessage:(NSString *)message;
+ (void)showTextInView:(UIView*)view text:(NSString *)message;
+ (void)showMessageCenter:(NSString *) msg hideAnimatedAfterDelay:(NSTimeInterval) delay;
+ (void)errorWithErrorCode:(NSInteger)errorCode;
- (void)showAnimationWithText:(NSString *)text;
- (void)showAnimation;
- (void)hide;
/**
 自定义HUD加载
 */
+ (void)showLoadDataHUD:(UIView *)showView text:(NSString*)message;
+ (void)hidenHUD:(UIView *)hidenView;
+ (void)showTextWithMessage: (NSString *)message andView: (UIView *)view;



#pragma showInKyWindow  -显示在Window层图

//  加载菊花,
+ (void)show;

//  加载菊花,带文字
+ (void)showProgress:(NSString *) msg;

//  显示文字(默认底部)
+ (void)showMessage:(NSString *) msg;

//  显示文字(中间显示)
+ (void)showMessageCenter:(NSString *) msg;

//  显示成功提示
+ (void)showSuccess:(NSString *) msg;

//  显示失败提示
+ (void)showError:(NSString *) msg;

//  隐藏
+ (void)hide;

//  隐藏(可设置时间)
+ (void)hideDelayTime:(NSInteger)delay;



#pragma showInCustomView -显示在指定视图上

// 加载菊花,,指定显示视图
+ (void)showInView:(UIView *)view;

//  加载菊花,带文字,指定显示视图
+ (void)showProgress:(NSString *)msg inView:(UIView *)view;

//  显示文字底部,指定显示视图
+ (void)showMessage:(NSString *)msg inView:(UIView *)view;

//  显示文字(中间显示),指定显示视图
+ (void)showMessageCenter:(NSString *) msg inView:(UIView *)view;

//  显示成功提示,指定显示视图
+ (void)showSuccess:(NSString *)msg inview:(UIView *)view;

//  显示失败提示,指定显示视图
+ (void)showError:(NSString *)msg inview:(UIView *)view;
///有回调的方法
+ (void)showMessageCenter:(NSString *) msg inView:(UIView *)view andBlock:(void(^)(void))block;

@end

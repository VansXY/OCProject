//
//  XYHudAlert.m
//  OCProjectKit
//
//  Created by HXB-xiaoYang on 2018/4/9.
//  Copyright © 2018年 VansXY. All rights reserved.
//

#import "XYHudAlert.h"

@interface XYHudAlert () <MBProgressHUDDelegate>
@property (strong, nonatomic) MBProgressHUD *HUD;
@property (assign, nonatomic) int  mTime;
@end

@implementation XYHudAlert
{
    NSTimer *timer;
}

+ (void)showTextWithMessage: (NSString *) message andView: (UIView * )view {
    MBProgressHUD *HUD = [MBProgressHUD  HUDForView:view];
    HUD.bezelView.backgroundColor = [UIColor colorWithRed:125/255.0f green:125/255.0f blue:125/255.0f alpha:1.f];
    HUD.label.text = message;
    HUD.label.textColor = [UIColor whiteColor];
    HUD.mode = MBProgressHUDModeText;
}

+ (void)showTextWithMessage:(NSString *)message{
    if(message.length <= 0) {
        return;
    }
    UIWindow *keyWindow = [UIApplication sharedApplication].keyWindow;
    [self showTextInView:keyWindow text:message];
}

+ (void)showTextInView:(UIView*)view text:(NSString *)message {
    MBProgressHUD *HUD = [[MBProgressHUD alloc]initWithView:view];
    [view addSubview:HUD];
    HUD.removeFromSuperViewOnHide = YES;
    NSString *text = message;
    HUD.mode = MBProgressHUDModeText;
    HUD.bezelView.backgroundColor = [UIColor blackColor];
    HUD.label.text = NSLocalizedString(text, @"HUD loading title");
    HUD.label.font = [UIFont systemFontOfSize:14];
    HUD.label.numberOfLines = 0;
    HUD.label.textColor = [UIColor whiteColor];
    HUD.backgroundColor = [UIColor clearColor];
    HUD.offset = CGPointMake(0, -100);
    int sec = text.length > 6? 2:1;
    
    [HUD showAnimated:YES whileExecutingBlock:^{
        sleep(sec);
    } completionBlock:^{
        [HUD removeFromSuperview];
    }];
}

+ (void)errorWithErrorCode:(NSInteger)errorCode{
    UIWindow *keyWindow = [UIApplication sharedApplication].keyWindow;
    MBProgressHUD *HUD = [[MBProgressHUD alloc]initWithView:keyWindow];
    HUD.removeFromSuperViewOnHide = YES;
    [keyWindow addSubview:HUD];
    if (errorCode == 401) {
        NSString *text = @"验证失效,请您重新刷新";
        HUD.detailsLabel.text = text;
        HUD.detailsLabel.font = [UIFont systemFontOfSize:16];
        HUD.mode = MBProgressHUDModeText;
        
        int sec = text.length > 6? 2:1;
        
        [HUD showAnimated:YES whileExecutingBlock:^{
            sleep(sec);
        } completionBlock:^{
            [HUD removeFromSuperview];
        }];
    }
}

+ (void)errorWithErrorCode:(int )errorCode message:(NSString *)message{
    UIWindow *keyWindow = [UIApplication sharedApplication].keyWindow;
    MBProgressHUD *HUD = [[MBProgressHUD alloc] initWithWindow:keyWindow];
    HUD.removeFromSuperViewOnHide = YES;
    [keyWindow addSubview:HUD];
    NSString *text = message;
    HUD.detailsLabelText = text;
    HUD.detailsLabelFont = [UIFont systemFontOfSize:16];
    HUD.mode = MBProgressHUDModeText;
    
    int sec = text.length > 6? 2:1;
    
    [HUD showAnimated:YES whileExecutingBlock:^{
        sleep(sec);
    } completionBlock:^{
        [HUD removeFromSuperview];
    }];
}

- (void)showAnimation {
    UIWindow *keyWindow = [UIApplication sharedApplication].keyWindow;
    _HUD = [[MBProgressHUD alloc]initWithView:keyWindow];
    _HUD.removeFromSuperViewOnHide = YES;
    [keyWindow addSubview:_HUD];
    _HUD.delegate = self;//添加代理
    _HUD.mode = MBProgressHUDModeIndeterminate;
    [_HUD showAnimated:YES];
}

- (void)showAnimationWithText:(NSString *)text {
    UIWindow *keyWindow = [UIApplication sharedApplication].keyWindow;
    _HUD = [[MBProgressHUD alloc]initWithView:keyWindow];
    _HUD.removeFromSuperViewOnHide = YES;
    _HUD.contentColor = [UIColor whiteColor];
    _HUD.bezelView.backgroundColor = [UIColor blackColor];
    [keyWindow addSubview:_HUD];
    _HUD.label.text = text;
    _HUD.label.textColor = [UIColor whiteColor];
    _HUD.delegate = self;//添加代理
    [_HUD showAnimated:YES];
}


-(void)hide {
    _HUD.removeFromSuperViewOnHide = YES;
    [_HUD hideAnimated:YES];
    if (timer) {
        timer.fireDate = [NSDate distantFuture];
    }
}

#pragma mark MBProgressHUD代理方法
-(void)hudWasHidden:(MBProgressHUD *)hud {
    [_HUD removeFromSuperview];
    if (_HUD != nil) {
        _HUD = nil;
    }
}

/**
 自定义HUD加载
 */
+ (void)showLoadDataHUD:(UIView *)showView text:(NSString*)message {
    UIWindow *keyWindow = [UIApplication sharedApplication].keyWindow;
    if (showView == nil) {
        showView = keyWindow;
    }
    if(!message) {
        message = NSLocalizedString(@"加载中。。。", @"HUD loading title");
    }
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:showView animated:YES];
    //    hud.backgroundColor = [UIColor colorWithRed:125/255.0f green:125/255.0f blue:125/255.0f alpha:1.f];
    hud.bezelView.backgroundColor = [UIColor blackColor];
    hud.contentColor = [UIColor whiteColor];
    hud.label.text = message;
    hud.label.textColor = [UIColor whiteColor];
    hud.backgroundColor = [UIColor clearColor];
}

+ (void)hidenHUD:(UIView *)hidenView {
    UIWindow *keyWindow = [UIApplication sharedApplication].keyWindow;
    if (hidenView == nil) {
        hidenView = keyWindow;
    }
    [MBProgressHUD hideHUDForView:hidenView animated:YES];
}

//  提示类型
typedef NS_ENUM(NSInteger, XYProgressHUDType) {
    XYProgressHUDTypeJHLoading,                 //菊花
    XYProgressHUDTypeOnlyText,                  //文字底部显示
    XYProgressHUDTypeOnlyTextCenter,            //文字中间显示
    XYProgressHUDTypeSuccess,                   //成功
    XYProgressHUDTypeError,                     //失败
    XYProgressHUDTypeCustomAnimation,           //自定义加载动画（序列帧实现）
};



+ (instancetype)shareInstance {
    static XYHudAlert *instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[XYHudAlert alloc] init];
    });
    return instance;
}

+ (void)show:(NSString *)msg inView:(UIView *)view type:(XYProgressHUDType) mytype {
    [self show:msg inView:view type:mytype customImgView:nil];
}


+ (void)show:(NSString *)msg inView:(UIView *)view type:(XYProgressHUDType)mytype customImgView:(UIImageView *)customImgView {
    
    if ([XYHudAlert shareInstance].HUD != nil) {
        [[XYHudAlert shareInstance].HUD hideAnimated:NO];
        [XYHudAlert shareInstance].HUD = nil;
    }
    
    if ([UIScreen mainScreen].bounds.size.height == 480) {
        [view endEditing:YES];
    }
    
    if (view == nil) view = [UIApplication sharedApplication].keyWindow;
    [XYHudAlert shareInstance].HUD = [MBProgressHUD showHUDAddedTo:view animated:YES];
    [XYHudAlert shareInstance].HUD.backgroundColor = [UIColor clearColor];
    
    //  是否设置黑色背景
    [XYHudAlert shareInstance].HUD.bezelView.backgroundColor = [UIColor blackColor];
    [XYHudAlert shareInstance].HUD.contentColor = [UIColor whiteColor];
    
    [[XYHudAlert shareInstance].HUD setRemoveFromSuperViewOnHide:YES];
    if (msg) {
        [XYHudAlert shareInstance].HUD.detailsLabel.text = msg;
    }
    [XYHudAlert shareInstance].HUD.detailsLabel.numberOfLines = 0;
    [XYHudAlert shareInstance].HUD.detailsLabel.font = [UIFont systemFontOfSize:16];
    
    switch (mytype) {
            
        case XYProgressHUDTypeOnlyText:
            [XYHudAlert shareInstance].HUD.mode = MBProgressHUDModeText;
            [[XYHudAlert shareInstance].HUD setMargin:15];
            [XYHudAlert shareInstance].HUD.offset = CGPointMake(0.f, MBProgressMaxOffset);
            break;
            
        case XYProgressHUDTypeJHLoading:
            [XYHudAlert shareInstance].HUD.mode = MBProgressHUDModeIndeterminate;
            break;
            
        case XYProgressHUDTypeSuccess:
            [XYHudAlert shareInstance].HUD.mode = MBProgressHUDModeCustomView;
            [XYHudAlert shareInstance].HUD.customView = [[UIImageView alloc] initWithImage:[[UIImage imageNamed:@"success"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate]];
            break;
            
        case XYProgressHUDTypeError:
            [XYHudAlert shareInstance].HUD.mode = MBProgressHUDModeCustomView;
            [XYHudAlert shareInstance].HUD.customView = [[UIImageView alloc] initWithImage:[[UIImage imageNamed:@"error"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate]];
            break;
            
        case XYProgressHUDTypeOnlyTextCenter:
            [XYHudAlert shareInstance].HUD.mode = MBProgressHUDModeCustomView;
            
            break;
            
        default:
            break;
    }
}




+ (void)show {
    [self show:nil inView:nil type:XYProgressHUDTypeJHLoading];
}


+ (void)showInView:(UIView *)view {
    [self show:nil inView:view type:XYProgressHUDTypeJHLoading];
}


+ (void)showProgress:(NSString *)msg {
    [self show:msg inView:nil type:XYProgressHUDTypeJHLoading];
}


+ (void)showMessage:(NSString *) msg {
    [self show:msg inView:nil type:XYProgressHUDTypeOnlyText];
    [[XYHudAlert shareInstance].HUD hideAnimated:YES afterDelay:1];
}


+ (void)showMessageCenter:(NSString *) msg {
    [self show:msg inView:nil type:XYProgressHUDTypeOnlyTextCenter];
    [[XYHudAlert shareInstance].HUD hideAnimated:YES afterDelay:1];
}

+ (void)showMessageCenter:(NSString *) msg hideAnimatedAfterDelay:(NSTimeInterval) delay {
    [self show:msg inView:nil type:XYProgressHUDTypeOnlyTextCenter];
    [[XYHudAlert shareInstance].HUD hideAnimated:YES afterDelay:delay];
}

+ (void)showProgress:(NSString *)msg inView:(UIView *)view {
    [self show:msg inView:view type:XYProgressHUDTypeJHLoading];
}


+ (void)hide {
    if ([XYHudAlert shareInstance].HUD != nil) {
        [[XYHudAlert shareInstance].HUD hideAnimated:YES];
    }
}


+ (void)hideDelayTime:(NSInteger)delay {
    if ([XYHudAlert shareInstance].HUD != nil) {
        [[XYHudAlert shareInstance].HUD hideAnimated:YES afterDelay:delay];
    }
}


+ (void)showMessage:(NSString *)msg inView:(UIView *)view {
    if(msg.length <= 0){
        return;
    }
    
    [self show:msg inView:view type:XYProgressHUDTypeOnlyText];
    [[XYHudAlert shareInstance].HUD hideAnimated:YES afterDelay:1];
}


+ (void)showMessageCenter:(NSString *) msg inView:(UIView *)view {
    [self show:msg inView:view type:XYProgressHUDTypeOnlyTextCenter];
    [[XYHudAlert shareInstance].HUD hideAnimated:YES afterDelay:1];
    [XYHudAlert shareInstance].HUD.offset = CGPointMake(0, -100);
}

+ (void)showSuccess:(NSString *)msg {
    [self show:msg inView:nil type:XYProgressHUDTypeSuccess];
    [[XYHudAlert shareInstance].HUD hideAnimated:YES afterDelay:1.0];
}


+ (void)showSuccess:(NSString *)msg inview:(UIView *)view {
    [self show:msg inView:view type:XYProgressHUDTypeSuccess];
    [[XYHudAlert shareInstance].HUD hideAnimated:YES afterDelay:1.0];
}


+ (void)showError:(NSString *)msg {
    [self show:msg inView:nil type:XYProgressHUDTypeError];
    [[XYHudAlert shareInstance].HUD hideAnimated:YES afterDelay:1.0];
}


+ (void)showError:(NSString *)msg inview:(UIView *)view {
    [self show:msg inView:view type:XYProgressHUDTypeError];
    [[XYHudAlert shareInstance].HUD hideAnimated:YES afterDelay:1.0];
}

///有回调的方法
+ (void)showMessageCenter:(NSString *) msg inView:(UIView *)view andBlock:(void(^)(void))block {
    [self show:msg inView:view type:XYProgressHUDTypeOnlyTextCenter];
    [[XYHudAlert shareInstance].HUD hideAnimated:YES afterDelay:1];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        block();
    });
}

@end

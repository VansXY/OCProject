//
//  HxbHUDProgress.m
//  hoomxb
//
//  Created by HXB-C on 2017/4/18.
//  Copyright © 2017年 hoomsun-miniX. All rights reserved.
//

#import "HxbHUDProgress.h"
@interface HxbHUDProgress () <MBProgressHUDDelegate>
@property (strong, nonatomic) MBProgressHUD *HUD;
@property (assign, nonatomic)int  mTime;
//@property (nonatomic, strong) ToastAnimationView *animtionView;
@end


@implementation HxbHUDProgress
{
    NSTimer *timer;
}
+ (void)showTextWithMessage: (NSString *)message andView: (UIView *)view {
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
    //        HUD.detailsLabel.text = text;
    //        HUD.detailsLabel.font = kHXBFont_PINGFANGSC_REGULAR(16);
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
    MBProgressHUD *HUD = [[MBProgressHUD alloc]initWithWindow:keyWindow];
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

- (void)showAnimation
{
    UIWindow *keyWindow = [UIApplication sharedApplication].keyWindow;
    _HUD = [[MBProgressHUD alloc]initWithView:keyWindow];
    _HUD.removeFromSuperViewOnHide = YES;
    [keyWindow addSubview:_HUD];
    _HUD.delegate = self;//添加代理
    _HUD.mode = MBProgressHUDModeIndeterminate;
    [_HUD showAnimated:YES];
}

- (void)showAnimationWithText:(NSString *)text
{
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


-(void)hide
{
    _HUD.removeFromSuperViewOnHide = YES;
    [_HUD hideAnimated:YES];
    if (timer) {
        timer.fireDate = [NSDate distantFuture];
    }
}

#pragma mark MBProgressHUD代理方法
-(void)hudWasHidden:(MBProgressHUD *)hud
{
    [_HUD removeFromSuperview];
    if (_HUD != nil) {
        _HUD = nil;
    }
}

/**
 自定义HUD加载
 */
+ (void)showLoadDataHUD:(UIView *)showView text:(NSString*)message{
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

+ (void)hidenHUD:(UIView *)hidenView
{
    UIWindow *keyWindow = [UIApplication sharedApplication].keyWindow;
    if (hidenView == nil) {
        hidenView = keyWindow;
    }
    [MBProgressHUD hideHUDForView:hidenView animated:YES];
}

/**
// 自定义HUD
// */
//- (void)customViewExampleWithView:(UIView *)view andImage: (UIImage *) {
//    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.navigationController.view animated:YES];
//    
//    // Set the custom view mode to show any view.
//    hud.mode = MBProgressHUDModeCustomView;
//    // Set an image view with a checkmark.
//    UIImage *image = [[UIImage imageNamed:@"Checkmark"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
//    hud.customView = [[UIImageView alloc] initWithImage:image];
//    // Looks a bit nicer if we make it square.
//    hud.square = YES;
//    // Optional label text.
//    hud.label.text = NSLocalizedString(@"Done", @"HUD done title");
//    
//    [hud hideAnimated:YES afterDelay:3.f];
//}

/**
 带有label的HUD
 */
//- (void)labelExample {
//    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.navigationController.view animated:YES];
//    hud.bezelView.backgroundColor = [UIColor colorWithRed:125/255.0f green:125/255.0f blue:125/255.0f alpha:1.f];
//    hud.label.text = NSLocalizedString(@"Loading...", @"HUD loading title");
//    hud.label.textColor = [UIColor whiteColor];
//    
//    //加载完成
//    //    [hud hideAnimated:YES];
//}


//  提示类型
typedef NS_ENUM(NSInteger, LCProgressHUDType){
    LCProgressHUDTypeJHLoading,                 //菊花
    LCProgressHUDTypeOnlyText,                  //文字底部显示
    LCProgressHUDTypeOnlyTextCenter,            //文字中间显示
    LCProgressHUDTypeSuccess,                   //成功
    LCProgressHUDTypeError,                     //失败
    LCProgressHUDTypeCustomAnimation,           //自定义加载动画（序列帧实现）
};



+ (instancetype)shareInstance{
    
    static HxbHUDProgress *instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[HxbHUDProgress alloc] init];
    });
    return instance;
}


+ (void)show:(NSString *)msg inView:(UIView *)view type:(LCProgressHUDType) mytype{
    
    [self show:msg inView:view type:mytype customImgView:nil];
}


+ (void)show:(NSString *)msg inView:(UIView *)view type:(LCProgressHUDType)mytype customImgView:(UIImageView *)customImgView{
    
    if ([HxbHUDProgress shareInstance].HUD != nil) {
        [[HxbHUDProgress shareInstance].HUD hideAnimated:NO];
        [HxbHUDProgress shareInstance].HUD = nil;
    }
    
    if ([UIScreen mainScreen].bounds.size.height == 480) {
        [view endEditing:YES];
    }
    
    if (view == nil) view = [UIApplication sharedApplication].keyWindow;
    [HxbHUDProgress shareInstance].HUD = [MBProgressHUD showHUDAddedTo:view animated:YES];
    [HxbHUDProgress shareInstance].HUD.backgroundColor = [UIColor clearColor];
    
    //  是否设置黑色背景
    [HxbHUDProgress shareInstance].HUD.bezelView.backgroundColor = [UIColor blackColor];
    [HxbHUDProgress shareInstance].HUD.contentColor = [UIColor whiteColor];
    
    [[HxbHUDProgress shareInstance].HUD setRemoveFromSuperViewOnHide:YES];
    if(msg)[HxbHUDProgress shareInstance].HUD.detailsLabel.text = msg;
    [HxbHUDProgress shareInstance].HUD.detailsLabel.numberOfLines = 0;
    [HxbHUDProgress shareInstance].HUD.detailsLabel.font = [UIFont systemFontOfSize:16];
    
    switch (mytype) {
            
        case LCProgressHUDTypeOnlyText:
            [HxbHUDProgress shareInstance].HUD.mode = MBProgressHUDModeText;
            [[HxbHUDProgress shareInstance].HUD setMargin:15];
            [HxbHUDProgress shareInstance].HUD.offset = CGPointMake(0.f, MBProgressMaxOffset);
            break;
            
        case LCProgressHUDTypeJHLoading:
            [HxbHUDProgress shareInstance].HUD.mode = MBProgressHUDModeIndeterminate;
            break;
            
        case LCProgressHUDTypeSuccess:
            [HxbHUDProgress shareInstance].HUD.mode = MBProgressHUDModeCustomView;
            [HxbHUDProgress shareInstance].HUD.customView = [[UIImageView alloc] initWithImage:[[UIImage imageNamed:@"success"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate]];
            break;
            
        case LCProgressHUDTypeError:
            [HxbHUDProgress shareInstance].HUD.mode = MBProgressHUDModeCustomView;
            [HxbHUDProgress shareInstance].HUD.customView = [[UIImageView alloc] initWithImage:[[UIImage imageNamed:@"error"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate]];
            break;
            
        case LCProgressHUDTypeOnlyTextCenter:
            [HxbHUDProgress shareInstance].HUD.mode = MBProgressHUDModeCustomView;
        
            break;
            
        default:
            break;
    }
}




+ (void)show{
    [self show:nil inView:nil type:LCProgressHUDTypeJHLoading];
}


+ (void)showInView:(UIView *)view{
    [self show:nil inView:view type:LCProgressHUDTypeJHLoading];
}


+ (void)showProgress:(NSString *)msg{
    [self show:msg inView:nil type:LCProgressHUDTypeJHLoading];
}


+ (void)showMessage:(NSString *) msg{
    [self show:msg inView:nil type:LCProgressHUDTypeOnlyText];
    [[HxbHUDProgress shareInstance].HUD hideAnimated:YES afterDelay:1];
}


+ (void)showMessageCenter:(NSString *) msg{
    [self show:msg inView:nil type:LCProgressHUDTypeOnlyTextCenter];
    [[HxbHUDProgress shareInstance].HUD hideAnimated:YES afterDelay:1];
}

+ (void)showMessageCenter:(NSString *) msg hideAnimatedAfterDelay:(NSTimeInterval) delay{
    [self show:msg inView:nil type:LCProgressHUDTypeOnlyTextCenter];
    [[HxbHUDProgress shareInstance].HUD hideAnimated:YES afterDelay:delay];
}

+ (void)showProgress:(NSString *)msg inView:(UIView *)view{
    [self show:msg inView:view type:LCProgressHUDTypeJHLoading];
}


+ (void)hide{
    if ([HxbHUDProgress shareInstance].HUD != nil) {
        [[HxbHUDProgress shareInstance].HUD hideAnimated:YES];
    }
}


+ (void)hideDelayTime:(NSInteger)delay{
    if ([HxbHUDProgress shareInstance].HUD != nil) {
        [[HxbHUDProgress shareInstance].HUD hideAnimated:YES afterDelay:delay];
    }
}


+ (void)showMessage:(NSString *)msg inView:(UIView *)view{
    if(msg.length <= 0){
        return;
    }
    
    [self show:msg inView:view type:LCProgressHUDTypeOnlyText];
    [[HxbHUDProgress shareInstance].HUD hideAnimated:YES afterDelay:1];
}


+ (void)showMessageCenter:(NSString *) msg inView:(UIView *)view{
    [self show:msg inView:view type:LCProgressHUDTypeOnlyTextCenter];
    [[HxbHUDProgress shareInstance].HUD hideAnimated:YES afterDelay:1];
    [HxbHUDProgress shareInstance].HUD.offset = CGPointMake(0, -100);
}

+ (void)showSuccess:(NSString *)msg{
    [self show:msg inView:nil type:LCProgressHUDTypeSuccess];
    [[HxbHUDProgress shareInstance].HUD hideAnimated:YES afterDelay:1.0];
}


+ (void)showSuccess:(NSString *)msg inview:(UIView *)view{
    [self show:msg inView:view type:LCProgressHUDTypeSuccess];
    [[HxbHUDProgress shareInstance].HUD hideAnimated:YES afterDelay:1.0];
}


+ (void)showError:(NSString *)msg{
    [self show:msg inView:nil type:LCProgressHUDTypeError];
    [[HxbHUDProgress shareInstance].HUD hideAnimated:YES afterDelay:1.0];
}


+ (void)showError:(NSString *)msg inview:(UIView *)view{
    [self show:msg inView:view type:LCProgressHUDTypeError];
    [[HxbHUDProgress shareInstance].HUD hideAnimated:YES afterDelay:1.0];
}

///有回调的方法
+ (void)showMessageCenter:(NSString *) msg inView:(UIView *)view andBlock:(void(^)(void))block{
    [self show:msg inView:view type:LCProgressHUDTypeOnlyTextCenter];
    [[HxbHUDProgress shareInstance].HUD hideAnimated:YES afterDelay:1];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        block();
    });
}
@end

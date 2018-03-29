//
//  UIView+RetureView.m
//  TouchActionDemo
//
//  Created by 肖扬 on 2017/4/27.
//  Copyright © 2017年 肖扬. All rights reserved.
//

#import "UIView+RetureView.h"
#import <objc/runtime.h>
#import "UIView+XYFrame.h"
#import "PostSessionTask.h"
#define kGetMobclickUrl @"http://340717c7.nat123.cc:39756/DMGetMobclick"

//static const PointKvo *pointKvo;

@implementation UIView (RetureView)

+ (void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        [[NSUserDefaults standardUserDefaults] setObject:@"0" forKey:@"newViewController"];
        Method methodA =  class_getInstanceMethod([self class], @selector(hitTest:withEvent:));
        Method methodB =  class_getInstanceMethod([self class], @selector(hitMyTest:withEvent:));
        method_exchangeImplementations(methodA, methodB);
    });
}

- (nullable UIView *)hitMyTest:(CGPoint)point withEvent:(nullable UIEvent *)event {
    UIView *myView = [self hitMyTest:point withEvent:event];
//
//    int count = (int)self.subviews.count;
//    for (int i = count - 1; i >= 0; i--) {
//        UIView *childView = self.subviews[i];
//        if ([NSStringFromClass(childView.class) isEqualToString:NSStringFromClass(myView.class)]) {
//            NSString *vcString = NSStringFromClass([self getCurrentViewController].class);
//            NSString *newString = [[NSUserDefaults standardUserDefaults] valueForKey:@"newViewController"];
//            if (![vcString isEqualToString:newString] && [vcString hasSuffix:@"ViewController"]) {
//                NSString *nowDate = [PostSessionTask getNowData];
//                [[NSUserDefaults standardUserDefaults] setObject:vcString forKey:@"newViewController"];
//                NSString *titleLable = @"";
//                if ([NSStringFromClass(myView.class) isEqualToString:@"UIButton"]) {
//                    UIButton *myButton = (UIButton *)myView;
//                    titleLable = myButton.titleLabel.text;
//                } else {
//                    titleLable = @"";
//                }
//                NSString *string_post = [NSString stringWithFormat:@"viewController=%@&view=%@&classFrame=%@&clickTime=%@&titleLabel=%@&unifyCode=maoxiaodai", vcString, NSStringFromClass(myView.class), NSStringFromCGRect(myView.frame), nowDate, titleLable];
//                [[PostSessionTask shareHandle] sendMessageWithUrl:kGetMobclickUrl parameters:string_post];
//            }
//        }
//    }
    return myView;

}


/** 获取当前View的控制器对象 */
-(UIViewController *)getCurrentViewController{
    UIResponder *next = [self nextResponder];
    do {
        if ([next isKindOfClass:[UIViewController class]]) {
            return (UIViewController *)next;
        }
        next = [next nextResponder];
    } while (next != nil);
    return nil;
}

@end

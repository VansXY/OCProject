//
//  UIViewController+SwizzMethod.m
//  OCProjectKit
//
//  Created by 肖扬 on 2018/4/20.
//  Copyright © 2018年 VansXY. All rights reserved.
//

#import "UIViewController+SwizzMethod.h"

@implementation UIViewController (SwizzMethod)

/*
 注意以下三点：
 1.load 方法
    +load方法能够确保在类的初始化时候调用，这能够保证改变应用行为的一致性，而+initialize在执行时并不提供这种保证，实际上，如果没有直接给这个类发送消息，该方法可能都不会调用到。
 2.选择器，方法和实现
    SEL
    Method
    selector
 3.调用
    调用替换的类名，他在运行时替换为调用原先被替换的方法
 */
+ (void)load {
    Class class = [self class];
    
    SEL originalSelector = @selector(viewWillAppear:);
    SEL swizzledSelector = @selector(xxx_viewWillAppear:);
    
    Method originalMethod = class_getInstanceMethod(class, originalSelector);
    Method swizzledMethod = class_getInstanceMethod(class, swizzledSelector);
    
    method_exchangeImplementations(originalMethod, swizzledMethod);
}

- (void)xxx_viewWillAppear:(BOOL)animated {
    [self xxx_viewWillAppear:animated];
    
    NSLog(@"%@", NSStringFromClass(self.class));
}

@end

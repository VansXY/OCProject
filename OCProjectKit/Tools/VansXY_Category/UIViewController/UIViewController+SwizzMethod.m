//
//  UIViewController+SwizzMethod.m
//  OCProjectKit
//
//  Created by 肖扬 on 2018/4/20.
//  Copyright © 2018年 VansXY. All rights reserved.
//

#import "UIViewController+SwizzMethod.h"

@implementation UIViewController (SwizzMethod)

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

//
//  UIViewController+SwizzMethod.m
//  OCProjectKit
//
//  Created by 肖扬 on 2018/4/20.
//  Copyright © 2018年 VansXY. All rights reserved.
//

#import "UIViewController+SwizzMethod.h"

/** 添加全局变量 */
static NSArray *_array = nil;

/** 在 category 上初始化全局变量的黑方法 */
__attribute__((constructor))
static void initialize_Array() {
    _array = [NSArray array];
    _array = @[@"1", @"2"];
}

@implementation UIViewController (SwizzMethod)

/*
 注意以下三点：
 1.load 和 initialize 区别
    load：
        1.子类的 load 方法在所有父类的 load 方法执行后再执行，分类的 load 方法在子类的 load 方法执行后执行，
        2.每个分类的 load 方法执行顺序不能确定先后（看编译顺序，可以在complie Source里面设置）
        3.load 方法不会继承，所有不用调用父类的 load 方法
    initialize：
        1.initialize 方法在类或它的子类收到的第一条消息之前调用的，包括类方法和实例方法调用
        2.类似于懒加载的方法，调用一次，触发一次，所以该方法或触发多次
        3.如果类或子类没有给它发送消息，那么它可能永远都不会触发
 
 2.选择器，方法和实现
    SEL方法选择器：通过方法名在类的方法列表中找到该方法
    Method 方法：用自定义的方法交换原来的方法
 
    ？？？（思考）
    替换过后怎么调用原来的方法？
    因为 runtime 是运行时编译的，所有调用自定义的方法，会在编译的时候 dia
 3.调用
    调用替换的类名，他在运行时替换为调用原先被替换的方法
 */

- (void)setAddProperty:(id)addProperty {
    objc_setAssociatedObject(self, @selector(addProperty), addProperty, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (id)addProperty {
    return objc_getAssociatedObject(self, @selector(addProperty));
}

/** 一般load 方法只触发一次，所以不需要在用 dispatch_once GCD去控制*/
+ (void)load {
    Class class = [self class];
    
    SEL originalSelector = @selector(viewWillAppear:);
    SEL swizzledSelector = @selector(xxx_viewWillAppear:);
    
    Method originalMethod = class_getInstanceMethod(class, originalSelector);
    Method swizzledMethod = class_getInstanceMethod(class, swizzledSelector);
    
    method_exchangeImplementations(originalMethod, swizzledMethod);
}

- (void)xxx_viewWillAppear:(BOOL)animated {
    /** 在 runtime 中 B 替换 A，当系统执行 A 方法的时候会被 B 替换，如果想保留 A 的方法再添加 B 的方法，那么该怎么做？如果调 再A 方法，就是 A替换成B，B 再调 A，导致循环调用了，正确的是调用 B 方法，看似自己调自己，其实不是，A 替换 B 方法，B 方法再调 B 方法，此时的 B 已经是 A 的方法了，不会发生循环调用的问题 */
    [self xxx_viewWillAppear:animated];
    NSLog(@"%@", _array);
    NSLog(@"%@", NSStringFromClass(self.class));
}

@end

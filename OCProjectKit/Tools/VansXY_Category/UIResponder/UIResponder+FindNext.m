//
//  UIResponder+FindNext.m
//  HongXiaoBao
//
//  Created by hoomsun on 16/8/3.
//  Copyright © 2016年 hongxb. All rights reserved.
//

#import "UIResponder+FindNext.h"

@implementation UIResponder (FindNext)

+ (UIResponder *)findNextResponderForClass:(Class)findClass ByFirstResponder:(UIResponder *)firstR
{
    id next = [firstR nextResponder];
    while (![next isKindOfClass:findClass]) {
        next = [next nextResponder];
    }
    
    if ([next isKindOfClass:findClass]) {
        return next;
    }
    return nil;
    
}

@end

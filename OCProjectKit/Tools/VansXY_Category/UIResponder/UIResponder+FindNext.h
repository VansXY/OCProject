//
//  UIResponder+FindNext.h
//  HongXiaoBao
//
//  Created by hoomsun on 16/8/3.
//  Copyright © 2016年 hongxb. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIResponder (FindNext)

+ (UIResponder *)findNextResponderForClass:(Class)findClass ByFirstResponder:(UIResponder *)firstR;

@end

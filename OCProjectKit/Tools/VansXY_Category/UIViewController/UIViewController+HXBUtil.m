//
//  UIViewController+HXBUtil.m
//  hoomxb
//
//  Created by 肖扬 on 2017/12/18.
//  Copyright © 2017年 hoomsun-miniX. All rights reserved.
//

#import "UIViewController+HXBUtil.h"

@implementation UIViewController (HXBUtil)

// pop到制定的页面
- (void)popToViewControllerWithClassName:(NSString *)className {
    __block UIViewController *vc = nil;
    if (self.navigationController) {
        [self.navigationController.viewControllers enumerateObjectsUsingBlock:^(__kindof UIViewController * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) { // 块遍历法，遍历子控制器
            if ([obj isKindOfClass:NSClassFromString(className)]) {
                vc = obj;
                *stop = YES;
            }
        }];
        if (vc) {
            [self.navigationController popToViewController:vc animated:YES];
        } else {
            [self.navigationController popViewControllerAnimated:YES];
        }
    }
}

@end

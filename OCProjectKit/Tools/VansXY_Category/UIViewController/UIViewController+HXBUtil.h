//
//  UIViewController+HXBUtil.h
//  hoomxb
//
//  Created by 肖扬 on 2017/12/18.
//  Copyright © 2017年 hoomsun-miniX. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIViewController (HXBUtil)

// 根据类名跳转返回页面
- (void)popToViewControllerWithClassName:(NSString *)className;

@end

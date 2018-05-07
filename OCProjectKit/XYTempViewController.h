//
//  XYTempViewController.h
//  OCProjectKit
//
//  Created by 肖扬 on 2018/5/5.
//  Copyright © 2018年 VansXY. All rights reserved.
//

#import <UIKit/UIKit.h>

/** block 的学习 */
typedef void(^callBackMobile)(NSString *mobile);

@interface XYTempViewController : UIViewController

/** block属性 */
@property (nonatomic, copy) callBackMobile mobileBlock;

@end

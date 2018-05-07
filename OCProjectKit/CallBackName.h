//
//  CallBackName.h
//  OCProjectKit
//
//  Created by 肖扬 on 2018/5/5.
//  Copyright © 2018年 VansXY. All rights reserved.
//

#import <Foundation/Foundation.h>

/** 委托 */
@protocol CallBackNameDelegate <NSObject>

/** 委托的属性 */
@property (nonatomic, strong) NSString *name;

/** 必须要实现的方法 */
@required
- (void)callBackName:(NSString *)name;

/** 可选实现的方法 */
@optional
- (void)printHAHA;


@end

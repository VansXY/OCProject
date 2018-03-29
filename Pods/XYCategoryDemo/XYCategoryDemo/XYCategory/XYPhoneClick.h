//
//  XYPhoneClick.h
//  MaoXiaoDai
//
//  Created by 肖扬 on 2017/5/11.
//  Copyright © 2017年 vans扬. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface XYPhoneClick : NSObject

/** 是否开启数据统计 */
@property (nonatomic, assign)  BOOL openData;

+ (void)startWithConfigureWithBool:(BOOL)trueOrFail;

@end

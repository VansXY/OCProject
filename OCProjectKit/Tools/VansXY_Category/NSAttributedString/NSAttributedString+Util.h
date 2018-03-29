//
//  NSAttributedString+Util.h
//  ProjectKit
//
//  Created by HXB-xiaoYang on 2017/12/5.
//  Copyright © 2017年 VansXY. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum : NSUInteger {
    attributeTypeColor,
    attributeTypeFont,
    attributeTypeCombination
} attributeType;

@interface NSAttributedString (Util)

// 给我一个字符串，要设置的类型，返回富文本
+ (NSMutableAttributedString *)attributedTransferWithString:(NSString *)string
                                              attributeType:(attributeType)attributeType
                                                      color:(UIColor *)color
                                                 colorRange:(NSRange)colorRange
                                                       font:(UIFont *)font
                                                  fontRange:(NSRange)fontRange;



@end

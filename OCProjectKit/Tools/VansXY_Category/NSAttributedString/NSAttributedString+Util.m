//
//  NSAttributedString+Util.m
//  ProjectKit
//
//  Created by HXB-xiaoYang on 2017/12/5.
//  Copyright © 2017年 VansXY. All rights reserved.
//

#import "NSAttributedString+Util.h"

@implementation NSAttributedString (Util)

// 给我一个字符串，要设置的类型，返回富文本
+ (NSMutableAttributedString *)attributedTransferWithString:(NSString *)string
                                              attributeType:(attributeType)attributeType
                                                      color:(UIColor *)color
                                                 colorRange:(NSRange)colorRange
                                                       font:(UIFont *)font
                                                  fontRange:(NSRange)fontRange {
    NSDictionary *attributeDic = nil;
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString: string]; 
    if (attributeType == attributeTypeColor) {
        
        attributeDic = @{NSForegroundColorAttributeName : color};
        [attributedString addAttributes:attributeDic range:colorRange];
        
    } else if (attributeType == attributeTypeFont) {
        
        attributeDic = @{NSFontAttributeName : font};
        [attributedString addAttributes:attributeDic range:colorRange];
        
    } else if (attributeType == attributeTypeCombination) {
        
        NSDictionary *attributeFontDic = @{NSFontAttributeName : font};
        NSDictionary *attributeColorDic = @{NSForegroundColorAttributeName : color};
        [attributedString addAttributes:attributeFontDic range:fontRange];
        [attributedString addAttributes:attributeColorDic range:colorRange];
    }
    return attributedString;
}
@end

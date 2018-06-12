//
//  XYLrcLabel.m
//  OCProjectKit
//
//  Created by HXB-xiaoYang on 2018/6/12.
//  Copyright © 2018年 VansXY. All rights reserved.
//

#import "XYLrcLabel.h"

@implementation XYLrcLabel


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    [super drawRect:rect];
    
    [[UIColor greenColor] set];
    CGRect fillRect = CGRectMake(0, 0, rect.size.width * self.progress, rect.size.height);
    
    UIRectFillUsingBlendMode(fillRect, kCGBlendModeSourceIn);
}

- (void)setProgress:(CGFloat)progress {
    _progress = progress;
    [self setNeedsDisplay];
}

@end

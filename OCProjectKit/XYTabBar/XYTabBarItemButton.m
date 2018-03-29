//
//  XYTabBarItemButton.m
//  OCProjectKit
//
//  Created by HXB-xiaoYang on 2018/3/19.
//Copyright © 2018年 VansXY. All rights reserved.
//

#import "XYTabBarItemButton.h"

@interface XYTabBarItemButton ()

@end

@implementation XYTabBarItemButton

- (void)layoutSubviews {
    [super layoutSubviews];
    [self setUI];
}

- (void)setUI {
    // 图片
    CGPoint center = self.imageView.center;
    center.x = self.frame.size.width / 2;
    center.y = self.frame.size.height / 2;
    self.imageView.center = center;
    self.imageView.backgroundColor = [UIColor redColor];
    
    // 文字
    self.titleLabel.center = self.imageView.center;
    self.titleLabel.font = [UIFont systemFontOfSize:13];
    self.titleLabel.textAlignment = NSTextAlignmentCenter;
}

- (BOOL)pointInside:(CGPoint)point withEvent:(UIEvent *)event {
    ///圆形区域半径
    CGFloat maxRadius = CGRectGetWidth(self.frame) / 2;
    ///触摸点相对圆心的坐标
    CGFloat xoffset = point.x - maxRadius;
    CGFloat yoffset = point.y - maxRadius;
    ///触摸点的半径
    CGFloat radius = sqrt(xoffset * xoffset + yoffset * yoffset);
    return radius <= maxRadius;
}



@end

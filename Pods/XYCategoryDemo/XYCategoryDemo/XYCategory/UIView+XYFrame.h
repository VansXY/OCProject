//
//  UIView+XYFrame.h
//  TouchActionDemo
//
//  Created by 肖扬 on 2017/5/9.
//  Copyright © 2017年 肖扬. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (XYFrame)

- (void)setLayerShadow:(UIColor*)color offset:(CGSize)offset radius:(CGFloat)radius;

- (void)removeAllSubviews;

@property (nonatomic, readonly) UIViewController *viewController;

@property (nonatomic) CGFloat left;
@property (nonatomic) CGFloat top;
@property (nonatomic) CGFloat right;
@property (nonatomic) CGFloat bottom;
@property (nonatomic) CGFloat width;
@property (nonatomic) CGFloat height;
@property (nonatomic) CGFloat centerX;
@property (nonatomic) CGFloat centerY;
@property (nonatomic) CGPoint origin;
@property (nonatomic) CGSize  size;

@end

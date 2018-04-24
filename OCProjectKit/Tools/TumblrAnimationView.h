//
//  tumblrAnimationView.h
//  OCProjectKit
//
//  Created by HXB-xiaoYang on 2018/4/24.
//Copyright © 2018年 VansXY. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TumblrAnimationView : UIView

/// 圆点颜色
@property (nonatomic, strong) UIColor *dotColor;
/// 圆点个数
@property (nonatomic, assign) NSInteger dotCount;
/// 圆点半径
@property (nonatomic, assign) float dotRadius;
/// 运行时间
@property (nonatomic, assign) float animationTime;

- (id)initWithFrame:(CGRect)frame dotCount:(NSInteger)dotCount;

/// 展示动画
- (void)showAnimated:(BOOL)animated;

/// 隐藏动画
- (void)hide;

@end

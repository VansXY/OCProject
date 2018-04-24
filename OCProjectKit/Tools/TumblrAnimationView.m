//
//  tumblrAnimationView.m
//  OCProjectKit
//
//  Created by HXB-xiaoYang on 2018/4/24.
//Copyright © 2018年 VansXY. All rights reserved.
//

#import "TumblrAnimationView.h"

#define kDotCount 6
#define kDotRadius 4.5

@interface TumblrAnimationView()

@property (nonatomic, strong) NSMutableArray *viewArray;

@end

@implementation TumblrAnimationView

- (id)initWithFrame:(CGRect)frame dotCount:(NSInteger)dotCount {
    self = [super initWithFrame:frame];
    if (self) {
        self.userInteractionEnabled = NO;
        self.alpha = 0;
        [self setUIWithDotCount:dotCount];
    }
    return self;
}

- (void)setUIWithDotCount:(NSInteger)dotCount {
    for (int i = 0; i < dotCount; i++) {
        UIView *rect = [self drawRectAtPosition:CGPointMake(20 * i, 5)];
        [self addSubview:rect];
        [self.viewArray addObject:rect];
    }
    [self doAnimateCycleWithRects:self.viewArray];
}

#pragma mark - animation

- (void)doAnimateCycleWithRects:(NSArray *)rects {
    __weak typeof(self) weakSelf = self;
    [self animationAfterWithI:0 WithRects:rects];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t) (self.animationTime * (kDotCount + 2) * 0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [weakSelf doAnimateCycleWithRects:rects];
    });
}

- (void)animationAfterWithI:(NSInteger)i WithRects:(NSArray *)rects {
    if (i >= rects.count) {
        return;
    }
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t) (self.animationTime * 0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self animateRect:rects[i] withDuration:self.animationTime];
        [self animationAfterWithI:(i + 1) WithRects:rects];
    });
}

- (void)animateRect:(UIView *)rect withDuration:(NSTimeInterval)duration {
    [rect setAutoresizingMask:UIViewAutoresizingFlexibleHeight];
    
    [UIView animateWithDuration:duration
                     animations:^{
                         rect.alpha = 1;
                         rect.transform = CGAffineTransformMakeScale(1.56, 1.56);
                     } completion:^(BOOL finished) {
                         [UIView animateWithDuration:duration
                                          animations:^{
                                              rect.alpha = 1;
                                              rect.transform = CGAffineTransformMakeScale(1, 1);
                                          } completion:^(BOOL f) {
                                          }];
                     }];
}

#pragma mark - drawing

- (UIView *)drawRectAtPosition:(CGPoint)positionPoint {
    UIView *rect = [[UIView alloc] init];
    CGRect rectFrame;
    rectFrame.size.width = 2*kDotRadius;
    rectFrame.size.height = 2*kDotRadius;
    rectFrame.origin.x = positionPoint.x + kDotRadius;
    rectFrame.origin.y = positionPoint.y;
    rect.frame = rectFrame;
    rect.backgroundColor = [UIColor whiteColor];
    rect.alpha = 1;
    rect.layer.cornerRadius = kDotRadius;
    
    return rect;
}


#pragma mark - setter
- (void)setDotColor:(UIColor *)dotColor {
    _dotColor = dotColor;
    for (UIView *view in self.viewArray) {
        view.backgroundColor = dotColor;
    }
}


#pragma mark - show / hide

- (void)hide {
    
}

- (void)showAnimated:(BOOL)animated {
    if (animated) {
        [UIView animateWithDuration:self.animationTime animations:^{
            self.alpha = 1;
        }];
    } else {
        self.alpha = 1;
    }
}


- (NSMutableArray *)viewArray {
    if (!_viewArray) {
        _viewArray = [NSMutableArray array];
    }
    return _viewArray;
}

@end

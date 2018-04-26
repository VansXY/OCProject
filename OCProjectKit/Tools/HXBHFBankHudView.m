//
//  HXBHFBankHudView.m
//  OCProjectKit
//
//  Created by HXB-xiaoYang on 2018/4/25.
//Copyright © 2018年 VansXY. All rights reserved.
//

#import "HXBHFBankHudView.h"
#import "TumblrAnimationView.h"

@interface HXBHFBankHudView ()

@property (nonatomic, strong) TumblrAnimationView *tumblrAnimationView;
@property (nonatomic, strong) UILabel *label;

@end

@implementation HXBHFBankHudView

#pragma mark - Life Cycle

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self setUI];
    }
    return self;
}

#pragma mark - UI

- (void)setUI {
    
    self.backView = [[UIView alloc] initWithFrame:UIScreen.mainScreen.bounds];
    self.backView.backgroundColor = [UIColor colorWithWhite:1 alpha:0.5];
    [self addSubview:self.backView];
    
    UIView *hudView = [[UIView alloc] initWithFrame:CGRectMake(kWidth / 2 - 110, 300, 220, 95)];
    hudView.layer.cornerRadius = 4;
    hudView.backgroundColor = [UIColor colorWithRed:119/ 256.0 green:119/256.0 blue:119/256.0 alpha:1];
    [self.backView addSubview:hudView];
    
    int dotCount = 6;
    self.tumblrAnimationView = [[TumblrAnimationView alloc] initWithFrame:CGRectMake(hudView.frame.size.width / 2 - 10 * dotCount, 25, 20 * dotCount, 16) dotCount:dotCount];
    self.tumblrAnimationView.dotColor = [UIColor whiteColor];
    self.tumblrAnimationView.animationTime = 0.2;
    [self.tumblrAnimationView showAnimated:YES];
    self.tumblrAnimationView.backgroundColor = [UIColor clearColor];
    [hudView addSubview:self.tumblrAnimationView];
    
    self.label = [[UILabel alloc] initWithFrame:CGRectMake(0, self.tumblrAnimationView.frame.origin.y + self.tumblrAnimationView.frame.size.height + 14, hudView.frame.size.width, 30)];
    self.label.font = [UIFont systemFontOfSize:14];
    self.label.textColor = [UIColor whiteColor];
    self.label.textAlignment = NSTextAlignmentCenter;
    [hudView addSubview:self.label];
}

- (void)setHudContent:(NSString *)hudContent {
    _hudContent = hudContent;
    self.label.text = hudContent;
}


@end

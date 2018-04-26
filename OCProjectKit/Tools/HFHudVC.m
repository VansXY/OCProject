//
//  HFHudVC.m
//  OCProjectKit
//
//  Created by HXB-xiaoYang on 2018/4/24.
//Copyright © 2018年 VansXY. All rights reserved.
//

#import "HFHudVC.h"
#import "TumblrAnimationView.h"

@interface HFHudVC ()

@end

@implementation HFHudVC

#pragma mark - Life Cycle

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

- (instancetype)init {
    self = [super init];
    if (self) {
        self.view.userInteractionEnabled = NO;
        self.view.backgroundColor = [UIColor colorWithWhite:1 alpha:0.5];
        [self setUI];
    }
    return self;
}

#pragma mark - UI

- (void)setUI {
    UIView *hudView = [[UIView alloc] initWithFrame:CGRectMake(kWidth / 2 - 110, 300, 220, 95)];
    hudView.layer.cornerRadius = 4;
    hudView.backgroundColor = [UIColor colorWithRed:119/ 256.0 green:119/256.0 blue:119/256.0 alpha:1];
    [self.view addSubview:hudView];
    
    int dotCount = 6;
    TumblrAnimationView *tumblrAnimationView = [[TumblrAnimationView alloc] initWithFrame:CGRectMake(hudView.frame.size.width / 2 - 10 * dotCount, 25, 20 * dotCount, 16) dotCount:dotCount];
    tumblrAnimationView.dotColor = [UIColor whiteColor];
    tumblrAnimationView.animationTime = 0.2;
    [tumblrAnimationView showAnimated:YES];
    tumblrAnimationView.backgroundColor = [UIColor clearColor];
    [hudView addSubview:tumblrAnimationView];
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, tumblrAnimationView.frame.origin.y + tumblrAnimationView.frame.size.height + 14, hudView.frame.size.width, 30)];
    label.text = @"正在跳转恒丰银行";
    label.font = [UIFont systemFontOfSize:14];
    label.textColor = [UIColor whiteColor];
    label.textAlignment = NSTextAlignmentCenter;
    [hudView addSubview:label];
}


@end

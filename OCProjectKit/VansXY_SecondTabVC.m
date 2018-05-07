//
//  VansXY_SecondTabVC.m
//  ProjectKit
//
//  Created by HXB-xiaoYang on 2017/12/6.
//Copyright © 2017年 VansXY. All rights reserved.
//

#import "VansXY_SecondTabVC.h"

@interface VansXY_SecondTabVC ()

@end

@implementation VansXY_SecondTabVC

#pragma mark - Life Cycle

- (void)viewDidLoad {
    [super viewDidLoad];
    
//    [self setUI];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self setUI];
}
#pragma mark - UI

- (void)setUI {
    NSLog(@"%@", XYKeyChain.token);
    UIButton *button = [UIButton buttonWithType:(UIButtonTypeCustom)];
    button.frame = CGRectMake(137.5, 100, 100, 100);
    button.layer.masksToBounds = YES;
    button.layer.cornerRadius = 50;
    [button setBackgroundColor:[UIColor orangeColor]];
    [button setTitle:@"hahahahahahaha" forState:(UIControlStateNormal)];
    [button addTarget:self action:@selector(clickMe) forControlEvents:(UIControlEventTouchUpInside)];
    [self.view addSubview:button];
}

- (void)clickMe {
    
}
@end

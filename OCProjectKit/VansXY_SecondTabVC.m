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
}


@end

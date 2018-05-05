//
//  VansXY_SecondTabVC.m
//  ProjectKit
//
//  Created by HXB-xiaoYang on 2017/12/6.
//Copyright © 2017年 VansXY. All rights reserved.
//

#import "VansXY_SecondTabVC.h"
#import "XYTempViewController.h"

@interface VansXY_SecondTabVC ()

@property (nonatomic, strong) UIButton *button;

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
    
    _button = [UIButton buttonWithType:(UIButtonTypeCustom)];
    _button.frame = CGRectMake(137.5, 100, 100, 100);
    _button.layer.masksToBounds = YES;
    _button.layer.cornerRadius = 50;
    [_button setBackgroundColor:[UIColor purpleColor]];
    [_button setTitle:@"点我" forState:(UIControlStateNormal)];
    [_button addTarget:self action:@selector(clickMe) forControlEvents:(UIControlEventTouchUpInside)];
    [self.view addSubview:_button];
    
    
    
}

- (void)clickMe {
    XYTempViewController *tempVC = [[XYTempViewController alloc] init];
    /**
     防止循环引用
     1. __weak 修饰（__unsafe_unretained __block会出现野指针）
     2. __block 修饰，在 block 块里面置为 nil。
     */
//    kWeakSelf
    __block typeof(self) blockSelf = self;
    tempVC.mobileBlock = ^(NSString *mobile) {
        NSLog(@"mobile = %@", mobile);
        [_button setTitle:mobile forState:(UIControlStateSelected)];
//        blockSelf = nil;
    };
    [self.navigationController pushViewController:tempVC animated:true];
}

@end

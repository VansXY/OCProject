//
//  PRESENTVC.m
//  OCProjectKit
//
//  Created by HXB-xiaoYang on 2018/5/4.
//Copyright © 2018年 VansXY. All rights reserved.
//

#import "PRESENTVC.h"
#import "VansXY_SecondTabVC.h"

@interface PRESENTVC ()

@end

@implementation PRESENTVC

#pragma mark - Life Cycle

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setUI];  
}

#pragma mark - UI

- (void)setUI {
    
    self.view.backgroundColor = [UIColor redColor];
    
    UIButton *button = [UIButton buttonWithType:(UIButtonTypeCustom)];
    button.frame = CGRectMake(137.5, 100, 100, 100);
    button.layer.masksToBounds = YES;
    button.layer.cornerRadius = 50;
    [button setBackgroundColor:[UIColor orangeColor]];
    [button setTitle:@"点我" forState:(UIControlStateNormal)];
    [button addTarget:self action:@selector(clickMe) forControlEvents:(UIControlEventTouchUpInside)];
    [self.view addSubview:button];
}

- (void)clickMe {
//    NSLog(@"______%@", s)
    if (self.block) {
        self.block(@"name");
    }
    [self dismissViewControllerAnimated:true completion:nil];
//    UINavigationController *naVC = [[UINavigationController alloc] initWithRootViewController:self];
//    [naVC pushViewController:[VansXY_SecondTabVC new] animated:true];
}
#pragma mark - Network


#pragma mark - Delegate Internal

#pragma mark -


#pragma mark - Delegate External

#pragma mark -


#pragma mark - Action


#pragma mark - Setter / Getter / Lazy


#pragma mark - Helper


#pragma mark - Other


#pragma mark - Public

@end

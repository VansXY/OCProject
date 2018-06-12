//
//  VansXY_SecondTabVC.m
//  ProjectKit
//
//  Created by HXB-xiaoYang on 2017/12/6.
//Copyright © 2017年 VansXY. All rights reserved.
//

#import "VansXY_SecondTabVC.h"
#import "XYTempViewController.h"
#import "XYLrcLabel.h"

@interface VansXY_SecondTabVC ()

@property (nonatomic, strong) UIButton *button;
@property (nonatomic, strong) XYLrcLabel *label;

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
    button.frame = CGRectMake(87.5, 100, 200, 100);
    button.layer.masksToBounds = YES;
    button.layer.cornerRadius = 50;
    [button setBackgroundColor:[UIColor orangeColor]];
    [button setTitle:@"hahahahahahaha" forState:(UIControlStateNormal)];
    [button addTarget:self action:@selector(clickMe) forControlEvents:(UIControlEventTouchUpInside)];
    [self.view addSubview:button];
    
    XYLrcLabel *label = [[XYLrcLabel alloc] initWithFrame:CGRectMake(10, 200, 355, 30)];
    label.text = @"哈哈哈哈哈哈哈哈哈哈哈哈哈哈";
    label.textColor = [UIColor grayColor];
    [self.view addSubview:label];
    _label = label;
    _label.progress = 0.5;
    
//    NSTimer *timer = [NSTimer timerWithTimeInterval:3 target:self selector:@selector(displayLrc) userInfo:nil repeats:YES];
//    [[NSRunLoop mainRunLoop] addTimer:timer forMode:NSRunLoopCommonModes];
    
    UISlider *slider = [[UISlider alloc] initWithFrame:CGRectMake(50, 300, 275, 30)];
    slider.minimumValue = 0.0;
    slider.maximumValue = 1.0;
    slider.continuous = YES;
    slider.tintColor = [UIColor greenColor];
    slider.thumbTintColor = [UIColor grayColor];
    [slider addTarget:self action:@selector(changeSlider:) forControlEvents:(UIControlEventValueChanged)];
    [self.view addSubview:slider];
    

}

- (void)changeSlider:(UISlider *)sender {
    NSLog(@"sneder = %.2f", sender.value);
    _label.progress = sender.value;
}


//- (void)displayLrc {
//    NSLog(@"12313");
//}

- (void)clickMe {
    
}
@end

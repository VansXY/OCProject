//
//  XYTempViewController.m
//  OCProjectKit
//
//  Created by 肖扬 on 2018/5/5.
//  Copyright © 2018年 VansXY. All rights reserved.
//

#import "XYTempViewController.h"

@interface XYTempViewController ()

@end

@implementation XYTempViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"TempViewController";
    self.view.backgroundColor = [UIColor whiteColor];
    [self setUI];
}

- (void)setUI {
    UIButton *button = [UIButton buttonWithType:(UIButtonTypeCustom)];
    button.frame = CGRectMake(137.5, 100, 100, 100);
    button.layer.masksToBounds = YES;
    button.layer.cornerRadius = 50;
    [button setBackgroundColor:[UIColor purpleColor]];
    [button setTitle:@"点我返回" forState:(UIControlStateNormal)];
    [button addTarget:self action:@selector(clickMe) forControlEvents:(UIControlEventTouchUpInside)];
    [self.view addSubview:button];
    
    
    /** 数组包含 block */
    NSArray *array = @[_mobileBlock, @"block"];
    
    /** 字典包含 block */
    NSDictionary *dic = @{
                          @"block": _mobileBlock,
                          @"mobile": @"mobile"
                          };
    
    NSLog(@"%@, %@", array, dic);
    
}

- (void)clickMe {
    if (self.mobileBlock) {
        self.mobileBlock(@"189-1158-0767");
    }
    [self.navigationController popViewControllerAnimated:true];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end

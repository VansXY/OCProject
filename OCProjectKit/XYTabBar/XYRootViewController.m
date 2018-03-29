//
//  XYRootViewController.m
//  OCProjectKit
//
//  Created by HXB-xiaoYang on 2018/3/19.
//Copyright © 2018年 VansXY. All rights reserved.
//

#import "XYRootViewController.h"
#import "XYTabBar.h"

#import "VansXY_FirstTabVC.h"
#import "VansXY_SecondTabVC.h"



@interface XYRootViewController ()

@end

@implementation XYRootViewController

#pragma mark - Life Cycle

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 利用 KVC 来使用自定义的tabBar；
    XYTabBar *tabBar = [[XYTabBar alloc] init];
    [self setValue:tabBar forKey:@"tabBar"];
    
    [self addChildViewControllers];
}

#pragma mark - UI

- (void)addChildViewControllers {
    
    VansXY_FirstTabVC *homeVC = [[VansXY_FirstTabVC alloc] init];
    homeVC.view.backgroundColor = [UIColor whiteColor];
    [self addChildViewController:homeVC title:@"首页" imageName:@"tabBar_home"];
    
    VansXY_SecondTabVC *activityVC = [[VansXY_SecondTabVC alloc] init];
    activityVC.view.backgroundColor = [UIColor orangeColor];
    [self addChildViewController:activityVC title:@"活动" imageName:@"tabBar_kdb"];
    
    UIViewController *findVC = [[UIViewController alloc] init];
    findVC.view.backgroundColor = [UIColor purpleColor];
    [self addChildViewController:findVC title:@"发现" imageName:@"tabBar_find"];
    
    UIViewController *mineVC = [[UIViewController alloc] init];
    mineVC.view.backgroundColor = [UIColor redColor];
    [self addChildViewController:mineVC title:@"我的" imageName:@"tabBar_mine"];
    
}

- (void)addChildViewController:(UIViewController *)viewController title:(NSString *)title imageName:(NSString *)imageName {
    
    UINavigationController *naVC = [[UINavigationController alloc] initWithRootViewController:viewController];
    self.tabBar.tintColor = [UIColor colorWithRed:245/255.0 green:81/255.0 blue:81/255.0 alpha:1];
    viewController.navigationItem.title = title;
    naVC.tabBarItem.title = title;
    naVC.tabBarItem.image = [UIImage imageNamed:[NSString stringWithFormat:@"%@_default", imageName]];
    naVC.tabBarItem.selectedImage = [[UIImage imageNamed:[NSString stringWithFormat:@"%@_highlight", imageName]] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    [self addChildViewController:naVC];
}

#pragma mark - XYTabBarViewDelegate
@end

//
//  VansXY_FirstTabVC.m
//  OCProjectKit
//
//  Created by HXB-xiaoYang on 2018/3/20.
//Copyright © 2018年 VansXY. All rights reserved.
//

#import "VansXY_FirstTabVC.h"
#import "XYTabBarItemButton.h"
#import "GCDAsyncSocket.h"
#import "XYGCDAsyncSocketManage.h"
#import "XYConnectConfig.h"
#import "XYKeyChainManager.h"
#import "XYBaseRequest.h"
#import "XYBaseNetwork.h"
#import "TumblrAnimationView.h"

#define kDefaultChannel     @"dkf"
#define kToken              @"f14c4e6f6c89335ca5909031d1a6efa9"



@interface VansXY_FirstTabVC ()<HXBRequestHudDelegate>

@property (nonatomic, strong) XYTabBarItemButton *button;
@property (nonatomic, strong) XYConnectConfig *config;
@property (nonatomic, strong) UICKeyChainStore *keychain;

@end

@implementation VansXY_FirstTabVC

#pragma mark - Life Cycle

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self buildButton];
    [self loadData];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    // 1. 使用默认的连接环境
    //    [[GCDAsyncSocketCommunicationManager sharedInstance] createSocketWithToken:@"f14c4e6f6c89335ca5909031d1a6efa9" channel:kDefaultChannel];
    
    // 2.自定义配置连接环境
    [[XYGCDAsyncSocketManage shareInstance] createSocketWithConfig:self.config];
}

#pragma mark - UI

- (void)buildButton {
    
    /*
     点击按钮的响应者链是什么：
        button —— mainView —— viewController —— UIWindow —— UIApplication —— AppDelegate
     
        1. UIView 的 nextResponder 是直接管理它的 UIViewController （也就是 VC.view.nextResponder = VC ），如果当前 View 不是 ViewController 直接管理的 View，则 nextResponder 是它的 superView（ view.nextResponder = view.superView ）。
        2. UIViewController 的 nextResponder 是它直接管理的 View 的 superView（ VC.nextResponder = VC.view.superView ）。
        3. UIWindow 的 nextResponder 是 UIApplication 。
        4. UIApplication 的 nextResponder 是 AppDelegate。
     
     
     事件寻找顺序：
        UIWindow —— mainView —— UIButton —— UIButtonLabel
     
        1. 从视图层级最底层的 window 开始遍历它的子 View。
        2. 默认的遍历顺序是按照 UIView 中 Subviews 的逆顺序。
        3. 找到 hit-TestView 之后，寻找过程就结束了。
     */
    _button = [XYTabBarItemButton buttonWithType:(UIButtonTypeCustom)];
    _button.frame = CGRectMake(137.5, 100, 100, 100);
    _button.layer.masksToBounds = YES;
    _button.layer.cornerRadius = 50;
    [_button setBackgroundColor:[UIColor orangeColor]];
    [_button setTitle:@"点我" forState:(UIControlStateNormal)];
    [_button addTarget:self action:@selector(clickMe) forControlEvents:(UIControlEventTouchUpInside)];
    [self.view addSubview:_button];
    
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

#pragma mark - Network
- (void)loadData {
    [XYBaseNetwork GET:@"https://www.sojson.com/open/api/weather/json.shtml" parameters:@{@"city": @"北京"} responseCache:nil success:^(id responseObject) {
        NSLog(@"responseObject = %@", responseObject);
        
    } failure:^(NSError *error) {
        NSLog(@"error = %@", error);
        
    }];
}

#pragma mark - Action
- (void)clickMe {
    NSLog(@"点我");
    _keychain = XYKeyChain.keyChain;
    _keychain[@"token"] = kToken;
    NSLog(@"%d", [_keychain setString:kToken forKey:@"token"]);
    [self loadData];
    NSDictionary *requestParams =@{};
    [[XYGCDAsyncSocketManage shareInstance] socketWriteDataWithRequestBody:requestParams completion:^(NSError * _Nullable error, id  _Nullable data) {
        NSLog(@"error = %@,\ndata = %@", error, data);
        if (error) {
            
        } else {
            
        }
    }];
}

- (void)keyChainUse {
    _keychain = XYKeyChain.keyChain;
    [_keychain setValue:kToken forKey:@"token"];
}

#pragma mark - Setter / Getter / Lazy
- (XYConnectConfig *)config {
    if (!_config) {
        _config = [[XYConnectConfig alloc] init];
        _config.channels = kDefaultChannel;
        _config.currentChannel = kDefaultChannel;
        _config.host = @"online socket address";
        _config.port = 7070;
        _config.socketVersion = 5;
    }
    _config.token = kToken;
    return _config;
}

@end

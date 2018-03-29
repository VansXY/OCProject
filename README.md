# OCProject

1. 添加工程管理类文件

```
#pragma mark - Life Cycle

- (void)viewDidLoad {
[super viewDidLoad];

[self setUI];
}

#pragma mark - UI

- (void)setUI {

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

```

2. 添加GCDAsyncSocketManager的使用

```
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

// 1. 使用默认的连接环境
//    [[GCDAsyncSocketCommunicationManager sharedInstance] createSocketWithToken:@"f14c4e6f6c89335ca5909031d1a6efa9" channel:kDefaultChannel];

// 2.自定义配置连接环境
[[XYGCDAsyncSocketManage shareInstance] createSocketWithConfig:self.config];
```

3. 添加 UICKeyChainStore 对 UIKeyChain 的使用

4. KVO 自定义TabBar

5. Category的积累

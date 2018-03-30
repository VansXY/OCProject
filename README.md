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

3. 添加 UICKeyChainStore 对 UIKeyChain 的使用，使用类似于NSUserDefault，方便快捷。

```
#import <Foundation/Foundation.h>
#import <UICKeyChainStore.h>

static NSString *const server = @"OCProject";

#define XYKeyChain [XYKeyChainManager shareHandle]

@interface XYKeyChainManager : NSObject

@property (nonatomic, strong) UICKeyChainStore *keyChain;
@property (nonatomic, strong) NSString *token;

+ (XYKeyChainManager *)shareHandle;

@end

_keychain = XYKeyChain.keyChain;
_keychain[@"token"] = kToken;
NSLog(@"%d", [_keychain setString:kToken forKey:@"token"]);
```

4. KVC 自定义TabBar

```
// 把 tabBarButton 取出来（把 tabBar 的 subViews 打印出来就明白了）
NSMutableArray *tabBarButtonArray = [NSMutableArray array];
for (UIView *view in self.subviews) {
if ([view isKindOfClass:NSClassFromString(@"UITabBarButton")]) {
[tabBarButtonArray addObject:view];
}
}

CGFloat barWidth = self.bounds.size.width;
CGFloat barHeight = self.bounds.size.height;
CGFloat centerBtnWidth = CGRectGetWidth(self.centerBtn.frame);
CGFloat centerBtnHeight = CGRectGetHeight(self.centerBtn.frame);
// 设置中间按钮的位置，居中，凸起一丢丢
self.centerBtn.center = CGPointMake(barWidth / 2, barHeight - centerBtnHeight/2 - 5 - 34); // 34是为了适配iPhone X，自己用宏代替
// 重新布局其他 tabBarItem
// 平均分配其他 tabBarItem 的宽度
CGFloat barItemWidth = (barWidth - centerBtnWidth) / tabBarButtonArray.count;
// 逐个布局 tabBarItem，修改 UITabBarButton 的 frame
[tabBarButtonArray enumerateObjectsUsingBlock:^(UIView *  _Nonnull view, NSUInteger idx, BOOL * _Nonnull stop) {

CGRect frame = view.frame;
if (idx >= tabBarButtonArray.count / 2) {
// 重新设置 x 坐标，如果排在中间按钮的右边需要加上中间按钮的宽度
frame.origin.x = idx * barItemWidth + centerBtnWidth;
} else {
frame.origin.x = idx * barItemWidth;
}
// 重新设置宽度
frame.size.width = barItemWidth;
view.frame = frame;
}];
// 把中间按钮带到视图最前面
[self bringSubviewToFront:self.centerBtn];
```

5. Category的积累

```
/// 获取设备版本号
+ (NSString *)getDeviceName;

/// 获取iPhone名称
+ (NSString *)getiPhoneName;

/// 获取app版本号
+ (NSString *)getAPPVerion;

/// 获取电池电量
+ (CGFloat)getBatteryLevel;

/// 当前系统名称
+ (NSString *)getSystemName;

/// 当前系统版本号
+ (NSString *)getSystemVersion;

/// 通用唯一识别码UUID
+ (NSString *)getUUID;

/// 获取当前设备IP
+ (NSString *)getDeviceIPAdress;

/// 获取总内存大小
+ (long long)getTotalMemorySize;

/// 获取当前可用内存
+ (long long)getAvailableMemorySize;

/// 获取精准电池电量
+ (CGFloat)getCurrentBatteryLevel;

/// 获取电池当前的状态，共有4种状态
+ (NSString *) getBatteryState;

/// 获取当前语言
+ (NSString *)getDeviceLanguage;

/// APP中文名
+ (NSString *)appName;

/// 获取启动页图片
+ (UIImage *)launchImage;

/// 获取APP LOGO
+ (UIImage *)iconImage;

/// 获取缓存大小 单位为Mb
+ (CGFloat)caculateAppCacheSize;

/// 清除缓存
+ (void)clearAppCache:(void(^)(BOOL success))block;

/**
*  生成缓存目录全路径
*/
- (instancetype)cacheDirectories;

/**
*  生成文档目录全路径
*/
- (instancetype)docDirectories;

/**
*  生成临时目录全路径
*/
- (instancetype)tmpDirectories;

/**
*  判断字符串是否为空
*
*  @return YES 是 NO 不是
*/
- (BOOL)isEmpty;

/**
*  判断是否为整型
*
*  @return YES 是 NO 不是
*/
- (BOOL)isInteger;

/**
*  判断是否为浮点型
*
*  @return YES 是 NO 不是
*/
- (BOOL)isFloat;

/**
*  判断是否有特殊字符
*
*  @return YES 是 NO 不是
*/
- (BOOL)isHasSpecialcharacters;

/**
*  判断是否含有数字
*
*  @return YES 是 NO 不是
*/
- (BOOL)isHasNumder;

// base64
/**
*  base64加密
*
*  @return 加密后的字符串
*/
- (NSString *)base64Encode;

/**
*  base64解密
*
*  @return 解密后的字符串
*/
- (NSString *)base64Decode;

// des
/**
*  DES加密
*
*  @param key 加密需要的key
*
*  @return 得到加密后的字符串
*/
- (NSString *)encryptWithKey:(NSString *)key;

/**
*  DES解密
*
*  @param key 解密需要的key
*
*  @return 得到解密后的字符串
*/
- (NSString *)decryptWithKey:(NSString *)key;

/**
金额判断

@param money 金额数
@return YES OR NO
*/
+ (BOOL)validateMoney:(NSString *)money;

/**
*  匹配Email
*
*  @return YES 成功 NO 失败
*/
- (BOOL)isEmail;

/**
*  匹配URL
*
*  @return YES 成功 NO 失败
*/
- (BOOL)isUrl;

/**
*  匹配电话号码
*
*  @return YES 成功 NO 失败
*/
- (BOOL)isTelephone;

- (BOOL)isHKTelephone;
- (BOOL)isTaiWanTelephone;
- (BOOL)isMCTelephone;
- (BOOL)isChinaTelephone;

- (BOOL)isTelephoneVerificationID;

/**
*  匹配身份证号码
*
*  @return YES 成功 NO 失败
*/
- (BOOL)isChineseIdentificationCard;

/**
*  由英文、字母或数字组成 6-18位
*
*  @return YES 验证成功 NO 验证失败
*/
- (BOOL)isPassword;
- (BOOL)isSpecailChar;

/**
*  匹配数字
*
*  @return YES 成功 NO 失败
*/
- (BOOL)isNumbers;

/**
*  匹配英文字母
*
*  @return YES 成功 NO 失败
*/
- (BOOL)isLetter;

/**
*  匹配大写英文字母
*
*  @return YES 成功 NO 失败
*/
- (BOOL)isCapitalLetter;

/**
*  匹配小写英文字母
*
*  @return YES 成功 NO 失败
*/
- (BOOL)isSmallLetter;

/**
*  匹配小写英文字母
*
*  @return YES 成功 NO 失败
*/
- (BOOL)isLetterAndNumbers;

/**
*  匹配中文，英文字母和数字及_
*
*  @return YES 成功 NO 失败
*/
- (BOOL)isChineseAndLetterAndNumberAndBelowLine;

/**
*  匹配中文，英文字母和数字及_ 并限制字数
*
*  @return YES 成功 NO 失败
*/
- (BOOL)isChineseAndLetterAndNumberAndBelowLine4to10;

/**
*  匹配含有汉字、数字、字母、下划线不能以下划线开头和结尾
*
*  @return YES 成功 NO 失败
*/
- (BOOL)isChineseAndLetterAndNumberAndBelowLineNotFirstOrLast;

#pragma mark - 计算String的字数(中英混合)
///=============================================================================
/// @name 计算String的字数(中英混合)
///=============================================================================

/**
*  计算string字数
*
*  @return 获得的中英混合字数
*/
- (NSInteger)stringLength;


#pragma mark -  email 转换为 774******@qq.com 形式
///=============================================================================
/// @name email 转换为 774******@qq.com 形式
///=============================================================================

/**
*  email 转换为 774******@qq.com 形式
*
*  @return 替换后的字符串
*/
- (NSString *)emailChangeToPrivacy;

#pragma mark - Emoji相关
///=============================================================================
/// @name Emoji相关
///=============================================================================

/**
*  判断是否是Emoji
*
*  @return YES 是 NO 不是
*/
- (BOOL)isEmoji;

/**
*  判断字符串时候含有Emoji
*
*  @return YES 是 NO 不是
*/
- (BOOL)isIncludingEmoji;

/**
*  移除掉字符串中得Emoji
*
*  @return 得到移除后的Emoji
*/
- (instancetype)removedEmojiString;

#pragma mark - 拼音相关
///=============================================================================
/// @name 拼音相关
///=============================================================================

/**
*  汉字转成拼音
*
*  @return 拼音字符串
*/
- (instancetype)hanzi2pinyin;

/**
*  初始化拼音
*
*  @return 拼音字符串
*/
- (instancetype)pinyinInitial;
```

6. 包含全国地区文件 area.plist



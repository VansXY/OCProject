//
//  ViewController.m
//  OCProjectKit
//
//  Created by HXB-xiaoYang on 2017/12/20.
//  Copyright © 2017年 VansXY. All rights reserved.
//

#import "ViewController.h"
#import <Photos/Photos.h>


@interface ViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (nonatomic, strong) UIImageView *animatedImageView;
@property (nonatomic, strong) UILabel *testLabel;
@property (nonatomic, strong) UIButton *testButton;
@property (nonatomic, copy) NSString *pngAddress;
@property (nonatomic, copy) NSString *jpgAddress;
@property (nonatomic, copy) NSString *gifAddress;
@property (nonatomic, assign) BOOL gcdFlag;
@property (nonatomic, copy) NSString *str1;
@property (nonatomic, strong) NSString *str2;

@end


/*
 懒猫存管设计模式：
 
 所有关于资金的都交给恒丰银行
 
 以购买为例：
 1.用户投资，点击按钮，请求服务器接口。
 2.服务器接口返回订单信息，拿到订单消息跳转恒丰银行H5页面
 3.H5页面校验用户填写信息，点击按钮，传递model，跳转结果页，
 */
@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    NSMutableString *m_str = [NSMutableString stringWithString:@"hello"];
    self.str1 = m_str;
    [m_str appendString:@" Lucy"];
    NSLog(@"str1 = %@", self.str1);
    
    
    _gcdFlag = NO;
    _pngAddress = @"http://github.com/logo.png";
    _pngAddress = @"http://github.com/logo.png";
    _gifAddress = @"http://github.com/ani.webp";
    
    _testLabel = [[UILabel alloc] initWithFrame:CGRectMake(100, 370, 175, 175)];
    _testLabel.backgroundColor = [UIColor grayColor];
    [self.view addSubview:_testLabel];
    [self.view sendSubviewToBack:_testLabel];
    
    _animatedImageView = [YYAnimatedImageView new];
    _animatedImageView.frame = CGRectMake(100, 560, 175, 175);
     [self.view addSubview:_animatedImageView];
    _animatedImageView.yy_imageURL = [NSURL URLWithString:_gifAddress];
    
    _imageView.contentMode = UIViewContentModeScaleAspectFit;
    _imageView.yy_imageURL = [NSURL URLWithString:_pngAddress];
    _imageView.userInteractionEnabled = YES;
    UILongPressGestureRecognizer *press = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(pressGesture:)];
    press.numberOfTouchesRequired = 1;
    press.minimumPressDuration = 1;
    [_imageView addGestureRecognizer:press];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapGesture)];
    [_imageView addGestureRecognizer:tap];
    
//    [_imageView yy_setImageWithURL:[NSURL URLWithString:_gifAddress] options:(YYWebImageOptionProgressive)];
//    [self closeGCD];
    
    UIButton *testButton = [UIButton buttonWithType:(UIButtonTypeCustom)];
    testButton.frame = CGRectMake(100, 200, 175, 50);
    [testButton setTitle:@"点我" forState:(UIControlStateNormal)];
    [testButton setBackgroundColor:[UIColor redColor]];
    [self.view addSubview:testButton];
    self.testButton = testButton;
    [[self.testButton rac_signalForControlEvents:(UIControlEventTouchUpInside)] subscribeNext:^(__kindof UIControl * _Nullable x) {
        NSLog(@"你点我了");
    }];
    
}

// iOS的GCD中如何关闭或者杀死一个还没执行完的后台线程?
- (void)closeGCD {
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        for (int i = 0; i < 100000; i++) {
            sleep(1);
            NSLog(@"__________");
            if (_gcdFlag == YES) {
                NSLog(@"结束");
                return ;
            }
            NSLog(@"+++++++++");
        }
    });
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(30 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        _gcdFlag = YES;
        NSLog(@"发结束消息");
    });
}


- (void)tapGesture {
    /// 取相册里面第一个元素
    
}

- (void)pressGesture:(UILongPressGestureRecognizer *)sender {
    if (sender.state == UIGestureRecognizerStateBegan) {
        NSLog(@"长按保存图片");
        /// 1. 获取当前App的相册授权状态
        PHAuthorizationStatus status = [PHPhotoLibrary authorizationStatus];
        if (status == PHAuthorizationStatusAuthorized) {
            NSLog(@"已授权");
            [self saveImage:_imageView.image toCollectionWithName:@"真好"];
        } else if (status == PHAuthorizationStatusNotDetermined) {
            kWeakSelf
            [PHPhotoLibrary requestAuthorization:^(PHAuthorizationStatus status) {
                // 如果用户选择授权, 则保存图片
                if (status == PHAuthorizationStatusAuthorized) {
                    dispatch_async(dispatch_get_main_queue(), ^{
                        // CollectionWithName相册名字
                        [self saveImage:weakSelf.imageView.image toCollectionWithName:@"真好"];
                    });
                }
            }];
        } else {
            NSLog(@"未授权");
        }
        
        // 但是不能创建相册, 保存的图片会直接保存到默认的系统相册中
//        UIImageWriteToSavedPhotosAlbum(_imageView.image, self, @selector(image:didFinishSavingWithError:contextInfo:), nil);
    }
}

// 保存图片
- (void)saveImage:(UIImage *)image toCollectionWithName:(NSString *)collectionName {
    
    // 1. 获取相片库对象
    PHPhotoLibrary *library = [PHPhotoLibrary sharedPhotoLibrary];
    
    // 2. 调用changeBlock
    [library performChanges:^{
        
        // 2.1 创建一个相册变动请求
        PHAssetCollectionChangeRequest *collectionRequest;
        
        // 2.2 取出指定名称的相册
        PHAssetCollection *assetCollection = [self getCurrentPhotoCollectionWithTitle:collectionName];
        
        // 2.3 判断相册是否存在
        if (assetCollection) { // 如果存在就使用当前的相册创建相册请求
            collectionRequest = [PHAssetCollectionChangeRequest changeRequestForAssetCollection:assetCollection];
        } else { // 如果不存在, 就创建一个新的相册请求
            collectionRequest = [PHAssetCollectionChangeRequest creationRequestForAssetCollectionWithTitle:collectionName];
        }
        
        // 2.4 根据传入的相片, 创建相片变动请求
        PHAssetChangeRequest *assetRequest = [PHAssetChangeRequest creationRequestForAssetFromImage:image];
        
        // 2.4 创建一个占位对象
        PHObjectPlaceholder *placeholder = [assetRequest placeholderForCreatedAsset];
        
        // 2.5 将占位对象添加到相册请求中
        [collectionRequest addAssets:@[placeholder]];
        
    } completionHandler:^(BOOL success, NSError * _Nullable error) {
        
        // 3. 判断是否出错, 如果报错, 声明保存不成功
        if (error) {
            NSLog(@"保存失败");
        } else {
            NSLog(@"保存成功");
        }
    }];
}

- (PHAssetCollection *)getCurrentPhotoCollectionWithTitle:(NSString *)collectionName {
    
    // 1. 创建搜索集合
    PHFetchResult *result = [PHAssetCollection fetchAssetCollectionsWithType:PHAssetCollectionTypeAlbum subtype:PHAssetCollectionSubtypeAlbumRegular options:nil];
    
    // 2. 遍历搜索集合并取出对应的相册
    for (PHAssetCollection *assetCollection in result) {
        
        if ([assetCollection.localizedTitle containsString:collectionName]) {
            return assetCollection;
        }
    }
    
    return nil;
}

//- (void)image:(UIImage *)image didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo {
//
//    if (error) {
//        NSLog(@"保存失败");
//    } else {
//        NSLog(@"保存成功");
//    }
//}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end

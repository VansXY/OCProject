//
//  PRESENTVC.m
//  OCProjectKit
//
//  Created by HXB-xiaoYang on 2018/5/4.
//Copyright © 2018年 VansXY. All rights reserved.
//

#import "PRESENTVC.h"
#import "VansXY_SecondTabVC.h"
#import "CallBackName.h"
#import "EmitterButton.h"

@interface PRESENTVC ()<CallBackNameDelegate>

@property (nonatomic, strong) EmitterButton *button;
@property (nonatomic, strong) UIView *myView;
@property (nonatomic , strong) CAEmitterLayer * explosionLayer;

@end

@implementation PRESENTVC

#pragma mark - Life Cycle

- (void)viewDidLoad {
    [super viewDidLoad];
    // 发射位置
    _explosionLayer.position = CGPointMake(kWidth/2, kHeight/2);
    [self setEmitter];
    [self setUI];
    
    /*
     // dispatch_sync会阻塞主线程，只有block里面的执行完了，才能继续往下执行，打印要放在主线程去执行，可是主线程卡死，故一直卡死
    NSLog(@"之前 - %@", [NSThread currentThread]);
    dispatch_sync(dispatch_get_main_queue(), ^{
        NSLog(@"sync - %@", [NSThread currentThread]);
    });
    NSLog(@"之后 - %@", NSThread.currentThread);
     */
//    dispatch_queue_t queue = dispatch_queue_create("SERIALQueue", DISPATCH_QUEUE_SERIAL);
//    NSLog(@"之前 - %@", [NSThread currentThread]);
//    dispatch_barrier_sync(queue, ^{
//        NSLog(@"sync - %@", [NSThread currentThread]);
//    });
    
    NSLog(@"1"); // 任务1
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        NSLog(@"2"); // 任务2
        dispatch_sync(dispatch_get_main_queue(), ^{
            NSLog(@"3"); // 任务3
        });
        NSLog(@"4"); // 任务4
    });
    NSLog(@"5"); // 任务5
    
//    NSLog(@"1");
//    dispatch_sync(dispatch_get_main_queue(), ^{
//        NSLog(@"2");
//    });
//    NSLog(@"3");
    
//    dispatch_queue_t queue = dispatch_queue_create("com.demo.serialQueue", DISPATCH_QUEUE_SERIAL);
//    NSLog(@"1"); // 任务1
//    dispatch_async(queue, ^{
//        NSLog(@"2"); // 任务2
//        dispatch_sync(queue, ^{
//            NSLog(@"3"); // 任务3
//        });
//        NSLog(@"4"); // 任务4
//    });
//    NSLog(@"5"); // 任务5
    
//    dispatch_sync(queue, ^{
//        NSLog(@"之前 - %@", NSThread.currentThread);
//        dispatch_sync(queue, ^{
//            NSLog(@"sync - %@", NSThread.currentThread);
//        });
//        NSLog(@"之后 - %@", NSThread.currentThread);
//    });

//    [self creatDispatch];
}

#pragma mark - UI

- (void)creatDispatch {
    /*
     NSThread
     
    NSThread *thread = [[NSThread alloc] initWithTarget:self selector:@selector(createThread) object:nil];
    [thread start];
    
     @synchronized(thread)  {
         
     }
    
    [NSThread detachNewThreadSelector:@selector(createThread1) toTarget:self withObject:nil];
    */
    
    /// 线程间通信
//    [self performSelector:@selector(<#selector#>) withObject:nil afterDelay:2 inModes:@[NSRunLoopCommonModes]];
    /// 1.创建一个串行队列
    dispatch_queue_t queue = dispatch_queue_create("serial", DISPATCH_QUEUE_SERIAL);
    
    /*
     2.并行队列
     
     系统默认提供了四个全局可用的并行队列:
     DISPATCH_QUEUE_PRIORITY_HIGH
     DISPATCH_QUEUE_PRIORITY_DEFAULT
     DISPATCH_QUEUE_PRIORITY_LOW
     DISPATCH_QUEUE_PRIORITY_BACKGROUND
     优先级依次降低。优先级越高的队列中的任务会更早执行
     */
    dispatch_queue_t conCurrentQueue = dispatch_queue_create("conCurrent", DISPATCH_QUEUE_CONCURRENT);
    dispatch_queue_t aQueue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0);
    
    /// 3.主队列(异步在主线程执行)
    dispatch_async(dispatch_get_main_queue(), ^{
        self.myView.backgroundColor = [UIColor purpleColor];
    });
}

- (void)setUI {
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    EmitterButton *button = [EmitterButton buttonWithType:(UIButtonTypeCustom)];
    button.frame = CGRectMake(100, 100, 100, 100);
    button.layer.masksToBounds = YES;
    button.layer.cornerRadius = 25;
    [button setTitle:@"点我" forState:(UIControlStateNormal)];
    button.titleLabel.font = [UIFont systemFontOfSize:12];
    [button setTitleColor:[UIColor grayColor] forState:(UIControlStateNormal)];
    [button addTarget:self action:@selector(clickMe:) forControlEvents:(UIControlEventTouchUpInside)];
    [self.view addSubview:button];
    _button = button;
    
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(100, 300, 50, 50)];
    view.backgroundColor = [UIColor orangeColor];
    [self.view addSubview:view];
    _myView = view;
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapG:)];
    [_myView addGestureRecognizer:tap];
}

- (void)tapG:(UITapGestureRecognizer *)sender {
    CGPoint location = [sender locationInView:self.view];
    NSString *animationKey = @"position";
    CGFloat duration = 1.0f;
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"emitterPosition"];
    CAEmitterLayer *presentation = (CAEmitterLayer*)[self.explosionLayer presentationLayer];
    CGPoint currentPosition = [presentation emitterPosition];
    [animation setFromValue:
     [NSValue valueWithCGPoint:currentPosition]];
    [animation setToValue:[NSValue valueWithCGPoint:location]];
    [animation setDuration:duration];
    [animation setFillMode:kCAFillModeForwards];
    [animation setRemovedOnCompletion:NO];
    [self.explosionLayer addAnimation:animation forKey:animationKey];
}

- (void)startAnimation{
    _explosionLayer.beginTime = CACurrentMediaTime();
    //每秒生成多少个粒子
    _explosionLayer.birthRate = 1;
    //    perform(#selector(STPraiseEmitterBtn.stopAnimation), with: nil, afterDelay: 0.15);
    [self performSelector:@selector(stopAnimation) withObject:self afterDelay:0.55];
}
- (void)stopAnimation{
    _explosionLayer.birthRate = 0;
}

- (void)setEmitter{
    _explosionLayer = [CAEmitterLayer layer];
    
    CAEmitterCell *explosionCell = [[CAEmitterCell alloc]init];
    
    explosionCell.name = @"explosion";
    //        设置粒子颜色alpha能改变的范围
    explosionCell.alphaRange = 0.10;
    //        粒子alpha的改变速度
    explosionCell.alphaSpeed = -1.0;
    //        粒子的生命周期
    explosionCell.lifetime = 0.7;
    //        粒子生命周期的范围;
    explosionCell.lifetimeRange = 0.3;
    
    //        粒子发射的初始速度
    explosionCell.birthRate = 2500;
    //        粒子的速度
    explosionCell.velocity = 40.00;
    //        粒子速度范围
    explosionCell.velocityRange = 10.00;
    
    //        粒子的缩放比例
    explosionCell.scale = 0.03;
    //        缩放比例范围
    explosionCell.scaleRange = 0.02;
    
    
    
    
    //        粒子要展现的图片
    explosionCell.contents = (id)([[UIImage imageNamed:@"sparkle"] CGImage]);
    
    _explosionLayer.name = @"explosionLayer";
    
    //        发射源的形状
    _explosionLayer.emitterShape = kCAEmitterLayerCuboid;
    //        发射模式
    _explosionLayer.emitterMode = kCAEmitterLayerOutline;
    //        发射源大小
    //    _explosionLayer.emitterSize = CGSize.init(width: 10, height: 0);
    _explosionLayer.emitterSize = CGSizeMake(5, 0);
    
    //        发射源包含的粒子
    _explosionLayer.emitterCells = @[explosionCell];
    //        渲染模式
    _explosionLayer.renderMode = kCAEmitterLayerOldestFirst;
    _explosionLayer.masksToBounds = false;
    _explosionLayer.birthRate = 0;
    
    
    
    _explosionLayer.zPosition = 0;
    [self.view.layer addSublayer:_explosionLayer];
    
    //添加背景图
//    UIImage *bgImage = [UIImage imageNamed:@"tabBar_center"];
//    self.view.backgroundColor = [UIColor colorWithPatternImage:bgImage];
//
//    //粒子图层
//    CAEmitterLayer *snowLayer = [CAEmitterLayer layer];
//    snowLayer.backgroundColor = [UIColor redColor].CGColor;
//    //发射位置
//    snowLayer.emitterPosition = CGPointMake(0, 0);
//    //发射源的尺寸
//    snowLayer.emitterSize = CGSizeMake(640, 1);
//    //发射源的形状
//    snowLayer.emitterMode = kCAEmitterLayerSurface;
//    //发射模式
//    snowLayer.emitterShape = kCAEmitterLayerLine;
//
//    //存放粒子种类的数组
//    NSMutableArray *snow_array = @[].mutableCopy;
//
//    for (NSInteger i=1; i<5; i++) {
//        //snow
//        CAEmitterCell *snowCell = [CAEmitterCell emitterCell];
//        snowCell.name = @"snow";
//        //产生频率
//        snowCell.birthRate = 15.0f;
//        //生命周期
//        snowCell.lifetime = 30.0f;
//        //运动速度
//        snowCell.velocity = 1.0f;
//        //运动速度的浮动值
//        snowCell.velocityRange = 10;
//        //y方向的加速度
//        snowCell.yAcceleration = 2;
//        //抛洒角度的浮动值
//        snowCell.emissionRange = 0.5*M_PI;
//        //自旋转角度范围
//        snowCell.spinRange = 0.25*M_PI;
//        //粒子透明度在生命周期内的改变速度
//        snowCell.alphaSpeed = 2.0f;
//        //cell的内容，一般是图片
//        NSString *snow_str = [NSString stringWithFormat:@"snow%ld",i];
//        snowCell.contents = (id)[UIImage imageNamed:snow_str].CGImage;
//
//        [snow_array addObject:snowCell];
//    }
//
//    //添加到当前的layer上
//    snowLayer.shadowColor = [[UIColor redColor]CGColor];
//    snowLayer.cornerRadius = 1.0f;
//    snowLayer.shadowOffset = CGSizeMake(1, 1);
//    snowLayer.emitterCells = [NSArray arrayWithArray:snow_array];
//    [self.view.layer insertSublayer:snowLayer atIndex:0];
}

- (void)clickMe:(EmitterButton *)sender {
    sender.selected = !sender.selected;
    
//    UIDynamicAnimator *animator = [[UIDynamicAnimator alloc] initWithReferenceView:self.view];
//
//    UIGravityBehavior* gravityBehavior = [[UIGravityBehavior alloc] initWithItems:@[self.myView]];
//    [animator addBehavior:gravityBehavior];
//
//    UICollisionBehavior* collisionBehavior = [[UICollisionBehavior alloc] initWithItems:@[self.myView]];
//    collisionBehavior.translatesReferenceBoundsIntoBoundary = YES;
//    [animator addBehavior:collisionBehavior];
    
//    CAKeyframeAnimation * animation = [CAKeyframeAnimation animationWithKeyPath:@"transform.scale"];
//    animation.values = @[@1.5,@0.8,@1.0,@1.2,@1.0];
//    animation.duration = 0.5;
//    [self startAnimation];
    
    /*
     values 和 keyTimes
     
     CAKeyframeAnimation *anima = [CAKeyframeAnimation animationWithKeyPath:@"transform.rotation"];//在这里@"transform.rotation"==@"transform.rotation.z"
     NSValue *value1 = [NSNumber numberWithFloat:-M_PI/180*4];
     NSValue *value2 = [NSNumber numberWithFloat:M_PI/180*4];
     NSValue *value3 = [NSNumber numberWithFloat:-M_PI/180*4];
     anima.values = @[value1,value2,value3];
     // anima.keyTimes = @[@0.0, @0.5, @1.0];
     anima.repeatCount = MAXFLOAT;
     
     [_myView.layer addAnimation:anima forKey:@"shakeAnimation"];
    */
    
    /*
     path按照轨迹运动
     
     CAKeyframeAnimation *anima = [CAKeyframeAnimation animationWithKeyPath:@"position"];
     UIBezierPath *path = [UIBezierPath bezierPath];
     
     [UIBezierPath bezierPathWithOvalInRect:CGRectMake(kWidth/2-100, kHeight/2-100, 200, 200)];
     [path moveToPoint:CGPointMake(20, 400)];
     [path addCurveToPoint:CGPointMake(260, 400) controlPoint1:CGPointMake(140, 200) controlPoint2:CGPointMake(140, 600)];
     anima.path = path.CGPath;
     anima.duration = 6.0f;
     [_myView.layer addAnimation:anima forKey:@"pathAnimation"];
    */
    
    /*
     组动画
     
     CAAnimationGroup *group = [[CAAnimationGroup alloc] init];
     group.duration = 5;
     CABasicAnimation *animationOne = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
     
     animationOne.toValue = @2.0;
     animationOne.duration = 3.0;
     
     CABasicAnimation *animationTwo = [CABasicAnimation animationWithKeyPath:@"position.x"];
     animationTwo.toValue = @400;
     animationTwo.duration = 3.0;
     
     [group setAnimations:@[animationOne, animationTwo]];
     [self.myView.layer addAnimation:group forKey:nil];
    */
    
    /*
     转场动画
     
     CATransition *trans = [CATransition animation];
     trans.duration = 0.5;
     trans.type = @"reveal";
     
     [self.myView.layer addAnimation:trans forKey:nil];
     self.myView.backgroundColor = [UIColor blueColor];
     */
    
//    CAEmitterLayer
    /*
     运动曲线
     
     // 初始化layer
     //    CALayer *layer        = [CALayer layer];
     //    layer.frame           = CGRectMake(350, 250, 20, 2);
     //    layer.backgroundColor = [UIColor whiteColor].CGColor;
     //
     //
     //    // 终点位置
     //    CGPoint endPosition = CGPointMake(layer.position.x, layer.position.y + 200);
     //
     //    // 动画
     //    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"position"];
     //    animation.fromValue         = [NSValue valueWithCGPoint:layer.position];
     //    animation.toValue           = [NSValue valueWithCGPoint:endPosition];
     //    animation.timingFunction    = [CAMediaTimingFunction functionWithControlPoints:0.00 :0.01 :0.00 :1.00];
     //    layer.position              = endPosition;
     //    animation.duration          = 3.f;
     //
     //    // 添加动画
     //    [layer addAnimation:animation forKey:nil];
     //    // 添加layer
     //    [self.view.layer addSublayer:layer];
     */
    
//    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"position.x"];
//    animation.toValue = @200;
//    animation.duration = 0.8;
//    animation.repeatCount = 5;
//    animation.beginTime = CACurrentMediaTime() + 0.5;
//    animation.fillMode = kCAFillModeBoth;
//    animation.timingFunction = [CAMediaTimingFunction functionWithControlPoints:1.00 :0.64 :0.09 :0.36];
//    [self.myView.layer addAnimation:animation forKey:nil];
//
//    [CAMediaTimingFunction functionWithControlPoints:1.00 :0.64 :0.09 :0.36];
    
//    [UIView animateWithDuration:3 delay:2 options:(UIViewAnimationOptionRepeat | UIViewAnimationOptionCurveEaseOut) animations:^{
//        _myView.transform = CGAffineTransformMakeScale(0.5, 0.5);
//    } completion:^(BOOL finished) {
//        _myView.transform = CGAffineTransformMakeScale(1, 1);
//    }];
//    [UIView animateKeyframesWithDuration:2.0 delay:0.0 options:UIViewKeyframeAnimationOptionRepeat | UIViewAnimationOptionCurveEaseOut animations:^{
//        [UIView addKeyframeWithRelativeStartTime:0.0 relativeDuration:0.5 animations:^{
//            self.myView.frame = CGRectMake(10, 50, 100, 100);
//        }];
//        [UIView addKeyframeWithRelativeStartTime: 0.5 relativeDuration:0.3 animations:^{
//            self.myView.frame = CGRectMake(20, 100, 100, 100);
//        }];
//        [UIView addKeyframeWithRelativeStartTime:0.8 relativeDuration:0.2 animations:^{
//            self.myView.transform = CGAffineTransformMakeScale(0.5, 0.5);
//        }];
//    } completion:nil];
    
//    if (self.block) {
//        self.block(@"name");
//    }
//    if ([self respondsToSelector:@selector(callBackName:)]) {
//        [self callBackName:@"name"];
//    }
//
//    [self dismissViewControllerAnimated:true completion:nil];
}


@end

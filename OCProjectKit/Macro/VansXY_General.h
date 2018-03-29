//
//  VansXY_General.h
//  ProjectKit
//
//  Created by HXB-xiaoYang on 2017/12/6.
//  Copyright © 2017年 VansXY. All rights reserved.
//

#ifndef VansXY_General_h
#define VansXY_General_h

#pragma mark ================= UI层 =================

#define kWidth [UIScreen mainScreen].bounds.size.width
#define kHeight [UIScreen mainScreen].bounds.size.height


// 以iPhone7为单元
#define kScreenAdaptation_Width_unit (kScreenWidth/375.0)
#define kScreenAdaptation_Height_unit (kScreenHeight/667.0)


// 计算比例后的宽度
#define kScrAdaptationW(W) ((W) * kScreenAdaptation_Width_unit)
// 计算比例后的高度
#define kScrAdaptationH(H) ((H) * kScreenAdaptation_Width_unit)


// 获取RGB颜色
#define colorWithRGBAlpha(r,g,b,a) [UIColor colorWithRed:r/255.0f green:g/255.0f blue:b/255.0f alpha:a]
#define colorWithRGB(r,g,b) [UIColor colorWithRed:r/255.0f green:g/255.0f blue:b/255.0f alpha:1.0f]




#pragma mark ================= FUNCTION =================

// 读取本地图片
#define LOADIMAGE(file,ext) [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:file ofType:ext]]
// 通过文件名获取UIImage
#define getImageWithName(name) [UIImage imageNamed:name]
//关于__weak 修饰的self, 用于block内部
#define kWeakSelf __weak typeof(self) weakSelf = self;





#pragma mark ================= 值 =================

// range初始值
#define kRangeZero NSMakeRange(0, 0)

// iPhone X
#define  HXBIPhoneX (kScreenWidth == 375.f && kScreenHeight == 812.f ? YES : NO)
// 状态栏高度
#define  HXBStatusBarHeight      (HXBIPhoneX ? 44.f : 20.f)
// 导航栏高度
#define  HXBNavigationBarHeight  44.f
// Tabbar高度
#define  HXBTabbarHeight         (HXBIPhoneX ? (49.f+34.f) : 49.f)
// Tabbar 安全区域高度
#define  HXBTabbarSafeBottomMargin         (HXBIPhoneX ? 34.f : 0.f)
// 状态栏和导航栏高度
#define  HXBStatusBarAndNavigationBarHeight  (HXBIPhoneX ? 88.f : 64.f)
// iOS11上面的安全区
#define HXBViewSafeAreInsets(view) ({UIEdgeInsets insets; if(@available(iOS 11.0, *)) {insets = view.safeAreaInsets;} else {insets = UIEdgeInsetsZero;} insets;})


#endif /* VansXY_General_h */

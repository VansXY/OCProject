//
//  SGInfoAlert.m
//
//  Created by Azure_Sagi on 3/1/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "SGInfoAlert.h"

@interface SGInfoAlert()
@property (nonatomic, strong) UIView* parentView;
@end

@implementation SGInfoAlert


// 画出圆角矩形背景
static void addRoundedRectToPath(CGContextRef context, CGRect rect,
                                 float ovalWidth,float ovalHeight)
{
    float fw, fh;
    if (ovalWidth == 0 || ovalHeight == 0) { 
        CGContextAddRect(context, rect);
        return;
    }
    CGContextSaveGState(context); 
    CGContextTranslateCTM (context, CGRectGetMinX(rect), 
                           CGRectGetMinY(rect));
    CGContextScaleCTM (context, ovalWidth, ovalHeight); 
    fw = CGRectGetWidth (rect) / ovalWidth; 
    fh = CGRectGetHeight (rect) / ovalHeight; 
    CGContextMoveToPoint(context, fw, fh/2); 
    CGContextAddArcToPoint(context, fw, fh, fw/2, fh, 1); 
    CGContextAddArcToPoint(context, 0, fh, 0, fh/2, 1); 
    CGContextAddArcToPoint(context, 0, 0, fw/2, 0, 1); 
    CGContextAddArcToPoint(context, fw, 0, fw, fh/2, 1); 
    CGContextClosePath(context); 
    CGContextRestoreGState(context); 
}

- (id)initWithFrame:(CGRect)frame bgColor:(CGColorRef)color info:(NSString*)info{
    CGRect viewR = CGRectMake(0, 0, frame.size.width*1.2, frame.size.height*1.8);
    self = [super initWithFrame:viewR];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        bgcolor_ = color;
        info_ = [[NSString alloc] initWithString:info];
        fontSize_ = frame.size;
    }
    return self;
}

- (void)drawRect:(CGRect)rect{
    CGContextRef context = UIGraphicsGetCurrentContext();
    // 背景0.8透明度
    CGContextSetAlpha(context, .8);
    addRoundedRectToPath(context, rect, 4.0f, 4.0f);
    CGContextSetFillColorWithColor(context,bgcolor_);//bgcolor_
    CGContextFillPath(context);
    
    // 文字1.0透明度
    CGContextSetAlpha(context, 1.0);
   // CGContextSetShadowWithColor(context, CGSizeMake(0, -1), 1, [[UIColor whiteColor] CGColor]);
    CGContextSetFillColorWithColor(context, [[UIColor whiteColor] CGColor]);
    float x = (rect.size.width - fontSize_.width) / 2.0;
    float y = (rect.size.height - fontSize_.height) / 2.0;
    CGRect r = CGRectMake(x, y, fontSize_.width, fontSize_.height);
    [info_ drawInRect:r withFont:[UIFont systemFontOfSize:kSGInfoAlert_fontSize] lineBreakMode:NSLineBreakByTruncatingTail];
}

// 从上层视图移除并释放
- (void)remove{
    [self removeFromSuperview];
    self.parentView = nil;
}

// 渐变消失
- (void)fadeAway{
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:1.5f];
    self.alpha = .0;
    [UIView commitAnimations];
    [self performSelector:@selector(remove) withObject:nil afterDelay:1.5f];
}



+ (void)showInfo:(NSString *)info 
         bgColor:(CGColorRef)color
          inView:(UIView *)view 
        vertical:(float)height{
    height = height < 0 ? 0 : height > 1 ? 1 : height;
    
    CGSize size = [info caleFontSize:[UIFont systemFontOfSize:kSGInfoAlert_fontSize] forMaxSize:kMax_ConstrainedSize lineBreakMode:NSLineBreakByWordWrapping];
    
   // [info caleFontSize:[UIFont systemFontOfSize:kSGInfoAlert_fontSize]
                  // constrainedToSize:kMax_ConstrainedSize];
    CGRect frame = CGRectMake(0, 0, size.width, size.height);
    int tag = -100000;
    SGInfoAlert *alert = [view viewWithTag:tag];
    if(alert) {
        [alert remove];
    }
    alert = [[SGInfoAlert alloc] initWithFrame:frame bgColor:color info:info];
    alert.tag = tag;
    alert.parentView = view;
    alert.center = CGPointMake(view.center.x, view.frame.size.height*height);
    alert.alpha = 0;
    [view addSubview:alert];
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:.3f];
    alert.alpha = 1.0;
    [UIView commitAnimations];
    [alert performSelector:@selector(fadeAway) withObject:nil afterDelay:1.5];
}

@end

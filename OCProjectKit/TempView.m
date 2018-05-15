//
//  TempView.m
//  OCProjectKit
//
//  Created by HXB-xiaoYang on 2018/5/15.
//Copyright © 2018年 VansXY. All rights reserved.
//

#import "TempView.h"

@interface TempView () {
    NSInteger tempViewHeight;
}

@end

@implementation TempView

#pragma mark - Life Cycle

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self setUI];
        
    }
    return self;
}

#pragma mark - UI

- (void)setUI {
    NSLog(@"tempViewHeight = %ld", tempViewHeight);
    
//    @throw [NSException exceptionWithName:<#(nonnull NSExceptionName)#> reason:<#(nullable NSString *)#> userInfo:<#(nullable NSDictionary *)#>]
    [self addObserver:self forKeyPath:@"tempViewHeight" options:(NSKeyValueObservingOptionNew | NSKeyValueObservingOptionOld) context:nil];
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context {
    if ([keyPath isEqualToString:@"tempViewHeight"]) {
        NSLog(@"tempViewHeight = %ld", tempViewHeight);
    }
}

- (void)dealloc {
    [self removeObserver:self forKeyPath:@"tempViewHeight"];
}


@end

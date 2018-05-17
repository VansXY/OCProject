//
//  XYSort.m
//  OCProjectKit
//
//  Created by HXB-xiaoYang on 2018/5/17.
//Copyright © 2018年 VansXY. All rights reserved.
//

#import "XYSort.h"

@implementation XYSort

- (instancetype)init {
    if (self = [super init]) {
        [self doSort];
    }
    return self;
}

- (void)doSort {
    // 冒泡排序
    NSMutableArray *array = [NSMutableArray arrayWithArray:@[@1, @3, @2, @9, @6, @19, @7]];
    for (int i = 0; i < array.count - 1; i++) {
        for (int j = 0; j < array.count - 1 - i; j++) {
            if (array[j] > array[j+1]) {
                int temp = [array[j] intValue];
                array[j] = array[j + 1];
                array[j+1] = [NSNumber numberWithInteger:temp];
            }
        }
    }
    NSLog(@"%@", array);
}


@end

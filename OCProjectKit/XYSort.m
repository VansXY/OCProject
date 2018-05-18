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
    NSMutableArray *array = [NSMutableArray arrayWithArray:@[@1, @3, @2, @9, @6, @19, @7]];
    int k = 0;
    BOOL isSort = YES;
    // 因为是双向比较，所以比较次数为原来数组的1/2次即可。
    for (int i = 0; i < array.count - 1 && isSort; i++) {
        k++;
        isSort = NO;
        // 从前到后的排序 (升序)
        for (int j = 0; j < array.count - i - 1; j++) {
            // 如果前面大于后面，则进行交换
            if (array[j] > array[j+1]) {
                int temp = [array[j] intValue];
                array[j] = array[j + 1];
                array[j+1] = [NSNumber numberWithInteger:temp];
                isSort = YES;
            }
        }
        
        // 从后到前的排序（降序）
        for (int k = (int)array.count - i - 1; k > i; k--) {
            // 如果前面大于后面，则进行交换
            if (array[k - 1] > array[k]) {
                int temp = [array[k] intValue];
                array[k] = array[k - 1];
                array[k - 1] = [NSNumber numberWithInteger:temp];
                isSort = YES;
            }
        }
        NSLog(@"k = %d", k);
        NSLog(@"%@\n", array);
    }
    
//    NSLog(@"%@", array);
}


@end

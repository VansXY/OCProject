//
//  XYSort.m
//  OCProjectKit
//
//  Created by HXB-xiaoYang on 2018/5/17.
//Copyright © 2018年 VansXY. All rights reserved.
//

#import "XYSort.h"

@interface XYSort()

@property (nonatomic, strong) NSMutableArray *randomArray;

@end

@implementation XYSort

- (instancetype)init {
    if (self = [super init]) {
//        [self doSort];
//        [self insertSort];
        _randomArray = [NSMutableArray array];
        [self createRendomArray];
        [self quickSortArray:_randomArray leftIndex:3 rightIndex:_randomArray.count - 1];
        NSLog(@"%@", _randomArray);
    }
    return self;
}

/// 冒泡排序
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

/// 插入排序
- (void)insertSort {
    int k = 0;
    NSMutableArray *array = [NSMutableArray arrayWithArray:@[@1, @3, @2, @9, @6, @19, @7]];
    for (int i = 0; i < array.count; i++) {
        k++;
        for (int j = i; j > 0; j--) {
            if (array[j-1] > array[j]) {
                int temp = [array[j] intValue];
                array[j] = array[j - 1];
                array[j - 1] = [NSNumber numberWithInteger:temp];
            }
            
        }
        NSLog(@"k = %d", k);
        NSLog(@"%@\n", array);
    }
//    NSLog(@"%@", array);
}

- (void)quickSortArray:(NSMutableArray *)array leftIndex:(NSInteger)leftIndex rightIndex:(NSInteger)rightIndex {
    
    if (leftIndex >= rightIndex) {
        return;
    }
    
    NSInteger i = leftIndex;
    NSInteger j = rightIndex;
    NSInteger key = [array[i] integerValue];
    
    while (i < j) {
        while (i < j && [array[j] integerValue] >= key) {
            j--;
        }
        array[i] = array[j];
        
        while (i < j && [array[i] integerValue] <= key) {
            i++;
        }
        array[j] = array[i];
    }
    array[i] = @(key);
    
    [self quickSortArray:array leftIndex:leftIndex rightIndex:i - 1];
    [self quickSortArray:array leftIndex:i + 1 rightIndex:rightIndex];
}







- (NSMutableArray *) createRendomArray {
    int i = 0;
    while (i < 10) {
        int num = arc4random() % 100 + 10;
        [_randomArray addObject:@(num)];
        i++;
    }
    return _randomArray;
}




//- (void)quickSort {
//    NSMutableArray *array = [NSMutableArray arrayWithArray:@[@1, @3, @2, @9, @6, @19, @7]];
////    [self quickSortArray:array leftIndex:0 rightIndex:array.count - 1];
//    NSInteger k = [self quickSortArray:array began:0 end:array.count - 1];
//    [self quickSortArray:array began:0 end:k - 1];
//    [self quickSortArray:array began:k + 1 end:array.count - 1];
//    NSLog(@"%@", array);
//}

//- (NSInteger)quickSortArray:(NSMutableArray *)array began:(NSInteger)began end:(NSInteger)end {
//    NSInteger num = (NSInteger)array[end];
//    NSInteger i = began - 1;
//    for (NSInteger j = began; j < end && j > began; j++) {
//        if ((NSInteger)array[j] <= num) {
//            int temp = [array[i] intValue];
//            array[i] = array[j];
//            array[j] = [NSNumber numberWithInteger:temp];
//            j++;
//        }
//    }
//    int temp = [array[i + 1] intValue];
//    array[i + 1] = array[end];
//    array[end] = [NSNumber numberWithInteger:temp];
//    return i + 1;
//}
@end

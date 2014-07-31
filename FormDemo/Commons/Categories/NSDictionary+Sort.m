//
//  NSDictionary+Sort.m
//  FormDemo
//
//  Created by sasaki on 2014/07/29.
//  Copyright (c) 2014年 mycompany. All rights reserved.
//

#import "NSDictionary+Sort.h"
#import "NSArray+Sort.h"

@implementation NSDictionary (Sort)

// キーを通常の比較で並び替えて、その順序のまま全ての値を返す
- (NSArray *)keyCompareSortedAllValues
{
    if (!self.allKeys) {
        return nil;
    }
    
    NSMutableArray *sortedAllValues = [[NSMutableArray alloc] init];
    for (id key in [self.allKeys compareSort]) {
        [sortedAllValues addObject:self[key]];
    }
    
    return [sortedAllValues copy];
}

@end

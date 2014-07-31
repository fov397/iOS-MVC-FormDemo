//
//  NSArray+Sort.m
//  FormDemo
//
//  Created by sasaki on 2014/07/29.
//  Copyright (c) 2014年 mycompany. All rights reserved.
//

#import "NSArray+Sort.h"

@implementation NSArray (Sort)

// 通常の比較ソート
- (NSArray *)compareSort
{
    return [self sortedArrayUsingComparator:^(id o1, id o2) {
        return [o1 compare:o2];
    }];
}

@end

//
//  NSObject+isNull.m
//  FormDemo
//
//  Created by sasaki on 2014/07/28.
//  Copyright (c) 2014年 mycompany. All rights reserved.
//

#import "NSObject+Validation.h"

@implementation NSObject (Validation)

- (BOOL) isNSNull
{
    return [self isEqual:[NSNull null]];
}

@end

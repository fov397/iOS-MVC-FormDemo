//
//  AFHTTPRequestOperationManager+Json.m
//  FormDemo
//
//  Created by sasaki on 2014/07/23.
//  Copyright (c) 2014年 mycompany. All rights reserved.
//

#import "AFHTTPRequestOperationManager+Manager.h"

@implementation AFHTTPRequestOperationManager (Manager)

+ (instancetype)jsonRequest2JsonResponseManager
{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.requestSerializer              = [AFJSONRequestSerializer serializer];
    
    NSArray *responseSerializer = @[[AFJSONResponseSerializer serializer],
                                    [AFHTTPResponseSerializer serializer],];
    manager.responseSerializer = [AFCompoundResponseSerializer
                                  compoundSerializerWithResponseSerializers:responseSerializer];

    return manager;
}

@end

//
//  FDUser.h
//  FormDemo
//
//  Created by sasaki on 2014/07/23.
//  Copyright (c) 2014年 mycompany. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AFNetworking/AFNetworking.h>

@interface FDUserModel : NSObject

@property (strong, nonatomic) NSString *userName;
@property (strong, nonatomic) NSString *email;
@property (strong, nonatomic) NSString *handed;
@property (strong, nonatomic) NSString *password;
@property (strong, nonatomic) NSString *note;

- (instancetype)initWithAttributes:(NSDictionary *)attributes;

- (NSDictionary *)toDictionary;

- (NSString *)validateForInsert;

- (void)insertUser:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success
           failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure;

@end

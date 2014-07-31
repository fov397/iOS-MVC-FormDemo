//
//  NSString+Validation.h
//  FormDemo
//
//  Created by sasaki on 2014/07/22.
//  Copyright (c) 2014年 mycompany. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (Validation)

- (BOOL)isEmail;
- (BOOL)isPhoneNumber;
- (BOOL)isUrl;

- (BOOL)hasLength;
- (BOOL)validateExactLength:(NSUInteger)exactLength;

- (BOOL)validateMinLength:(NSUInteger)minLength;
- (BOOL)validateMaxLength:(NSUInteger)maxLength;
- (BOOL)validateMinMaxLength:(NSUInteger)minLength
                   maxLength:(NSUInteger)maxLength;

- (BOOL)validateRegex:(NSString *)regexString error:(NSError **)error;

- (NSString *)trim;

@end

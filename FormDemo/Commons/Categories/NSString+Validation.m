//
//  NSString+Validation.m
//  FormDemo
//
//  Created by sasaki on 2014/07/22.
//  Copyright (c) 2014年 mycompany. All rights reserved.
//

#import "NSString+Validation.h"

@implementation NSString (Validation)

// stackoverflowを参考に実装
// http://stackoverflow.com/questions/800123/what-are-best-practices-for-validating-email-addresses-in-objective-c-for-ios-2
- (BOOL)isEmail
{
    if (![self hasLength]) {
        return NO;
    }

    NSString *emailRegex =
        @"(?:[a-z0-9!#$%\\&'*+/=?\\^_`{|}~-]+(?:\\.[a-z0-9!#$%\\&'*+/=?\\^_`{|}"
        @"~-]+)*|\"(?:[\\x01-\\x08\\x0b\\x0c\\x0e-\\x1f\\x21\\x23-\\x5b\\x5d-\\"
        @"x7f]|\\\\[\\x01-\\x09\\x0b\\x0c\\x0e-\\x7f])*\")@(?:(?:[a-z0-9](?:[a-"
        @"z0-9-]*[a-z0-9])?\\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?|\\[(?:(?:25[0-5"
        @"]|2[0-4][0-9]|[01]?[0-9][0-9]?)\\.){3}(?:25[0-5]|2[0-4][0-9]|[01]?[0-"
        @"9][0-9]?|[a-z0-9-]*[a-z0-9]:(?:[\\x01-\\x08\\x0b\\x0c\\x0e-\\x1f\\x21"
        @"-\\x5a\\x53-\\x7f]|\\\\[\\x01-\\x09\\x0b\\x0c\\x0e-\\x7f])+)\\])";
    
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES[c] %@", emailRegex];
    
    return [emailTest evaluateWithObject:self];
}

- (BOOL)isPhoneNumber
{
    if (![self hasLength]) {
        return NO;
    }

    NSString *phoneNumberRegex = @"[0-9]{2,4}-[0-9]{2,4}-[0-9]{2,4}";
    NSPredicate *phoneNumberTest
        = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", phoneNumberRegex];
    
    return [phoneNumberTest evaluateWithObject:self];
}

// stackoverflowを参考に実装
// http://stackoverflow.com/questions/1471201/how-to-validate-an-url-on-the-iphone
- (BOOL)isUrl
{
    if (![self hasLength]) {
        return NO;
    }

    NSString *urlRegex   = @"(http|https)://((\\w)*|([0-9]*)|([-|_])*)+([\\.|/]((\\w)*|([0-9]*)|([-|_])*))+";
    NSPredicate *urlTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", urlRegex];
    
    return [urlTest evaluateWithObject:self];
}

# pragma mark - Length

- (BOOL)hasLength
{
    return self.length > 0;
}

- (BOOL)validateExactLength:(NSUInteger)exactLength
{
    return self.length == exactLength;
}

- (BOOL)validateMinLength:(NSUInteger)minLength
{
    return self.length >= minLength;
}

- (BOOL)validateMaxLength:(NSUInteger)maxLength
{
    return self.length <= maxLength;
}

- (BOOL)validateMinMaxLength:(NSUInteger)minLength
                   maxLength:(NSUInteger)maxLength
{
    return [self validateMinLength:minLength] && [self validateMaxLength:maxLength];
}

# pragma mark - Regex

- (BOOL)validateRegex:(NSString *)regexString error:(NSError **)error
{
    NSRegularExpression *regex
        = [NSRegularExpression regularExpressionWithPattern:regexString
                                                    options:NSRegularExpressionCaseInsensitive
                                                      error:error];
    if (*error) {
        return NO;
    }
    
    NSTextCheckingResult *result = [regex firstMatchInString:self
                                                     options:0
                                                       range:NSMakeRange(0, self.length)];
    
    return result != nil;
}

# pragma mark - Validation Utilities

- (NSString *)trim
{
    return [self stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
}

@end

//
//  FDUser.m
//  FormDemo
//
//  Created by sasaki on 2014/07/23.
//  Copyright (c) 2014年 mycompany. All rights reserved.
//

#import "FDUserModel.h"
#import "FDConfigLoader.h"
#import "NSString+Validation.h"
#import "NSObject+Validation.h"
#import "AFHTTPRequestOperationManager+Manager.h"

@implementation FDUserModel

- (instancetype)initWithAttributes:(NSDictionary *)attributes {
    self = [super init];
    if (!self) {
        return nil;
    }
    
    self.userName = [attributes valueForKey:@"userName"];
    self.email    = [attributes valueForKey:@"email"];
    self.handed   = [attributes valueForKey:@"handed"];
    self.password = [attributes valueForKey:@"password"];
    self.note     = [attributes valueForKey:@"note"];

    // NSNullチェック
    // NSDictionaryではnilを表現できないため、NSNullで渡ってくる
    if ([self.userName isNSNull]) {
        self.userName = nil;
    }
    
    if ([self.email isNSNull]) {
        self.email = nil;
    }
    
    if ([self.handed isNSNull]) {
        self.handed = nil;
    }
    
    if ([self.password isNSNull]) {
        self.password = nil;
    }
    
    if ([self.note isNSNull]) {
        self.note = nil;
    }

    return self;
}

- (NSDictionary *)toDictionary
{
    return @{@"userName":self.userName ?: [NSNull null],
             @"email":   self.email    ?: [NSNull null],
             @"handed":  self.handed   ?: [NSNull null],
             @"password":self.password ?: [NSNull null],
             @"note":    self.note     ?: [NSNull null],};
}

// 登録時入力チェック
// TODO:NSErrorを使用した方が柔軟性があるかもしれない
- (NSString *)validateForInsert
{
    
    if (![self.userName hasLength]) {
        return @"氏名を正しく入力してください";
    }
    
    if (![self.email isEmail]) {
        return @"メールアドレスを正しく入力してください";
    }

    NSDictionary *fdConfig = [FDConfigLoader mixIn];
    if (![[fdConfig[@"Handed"] allValues] containsObject:self.handed]) {
        return @"利き腕を正しく選択してください";
    }
    
    if (![self.password validateMinMaxLength:8 maxLength:16]) {
        return @"パスワードを8〜16文字で入力してください";
    }
    
    return nil;
}

// ユーザ登録
- (void)insertUser:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success
           failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure
{
    // jsonを渡してjsonを受け取る
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager jsonRequest2JsonResponseManager];
    
    NSDictionary *fdConfig  = [FDConfigLoader mixIn];
    NSString *insertUserUrl = [fdConfig[@"Base Api Url"]
                               stringByAppendingString:fdConfig[@"Api Path For Insert User"]];
    
    // 非同期通信でユーザ登録のApiを叩く
    // 渡されたブロックをそのまま実行する事で、コントローラの処理も行う
    // 注意：コントローラの状態変化はメインスレッドを呼び出して実施している
    [manager POST:insertUserUrl
       parameters:self.toDictionary
          success:^(AFHTTPRequestOperation *operation, id responseObject) {
              // ~~ モデル側成功時処理(何かあれば記述) ~~
              DLog(@"%@", responseObject);
              [NSThread sleepForTimeInterval:5.0];
              
              dispatch_async(dispatch_get_main_queue(), ^{
                  // コントローラ側成功時処理
                  success(operation, responseObject);
              });
          }
          failure:^(AFHTTPRequestOperation *operation, NSError *error) {
              // ~~ モデル側失敗時処理(何かあれば記述) ~~
              DLog(@"%@", error);
              [NSThread sleepForTimeInterval:1.0];
              
              dispatch_async(dispatch_get_main_queue(), ^{
                  // コントローラ側失敗時処理
                  failure(operation, error);
              });
          }];
}
@end

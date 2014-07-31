//
//  FDFMConfirmViewController.m
//  FormDemo
//
//  Created by sasaki on 2014/07/23.
//  Copyright (c) 2014年 mycompany. All rights reserved.
//

#import "FDFMConfirmViewController.h"
#import <AFNetworking/AFNetworking.h>
#import <SVProgressHUD/SVProgressHUD.h>

@interface FDFMConfirmViewController ()

@property (weak, nonatomic) IBOutlet UILabel *userNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *emailLabel;
@property (weak, nonatomic) IBOutlet UILabel *handedLabel;
@property (weak, nonatomic) IBOutlet UITextView *noteLabel;

@end

@implementation FDFMConfirmViewController

#pragma mark - Life Cycle Methods

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.userNameLabel.text = self.userModel.userName;
    self.emailLabel.text    = self.userModel.email;
    self.handedLabel.text   = self.userModel.handed;
    self.noteLabel.text     = self.userModel.note;
}

#pragma mark - Event Recieve Action

- (IBAction)submitButtonDidTouchUpInside:(UIButton *)sender {
    // 登録中インジケータ表示
    // SVProgressHUDMaskTypeGradientで登録中のユーザ操作は不可とする
    [SVProgressHUD showWithStatus:@"登録中"
                         maskType:SVProgressHUDMaskTypeGradient];

    // ブロック内で使用するため、弱参照で再定義
    __weak FDFMConfirmViewController *weakSelf = self;

    // ユーザー登録実行
    // ブロックはモデルによる登録処理完了後に実行される
    [self.userModel insertUser:^(AFHTTPRequestOperation *operation, id responseObject) {
            [SVProgressHUD showSuccessWithStatus:@"成功"];
        
            // 登録完了後に画面を閉じる
            [weakSelf.navigationController dismissViewControllerAnimated:YES completion:nil];
        }
        failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            [SVProgressHUD dismiss];
        
            NSString *errorMessage = @"サーバーエラーが発生しました。\nしばらく経ってから再度登録してください";
            UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"エラー"
                                                                message:errorMessage
                                                               delegate:nil
                                                      cancelButtonTitle:@"OK"
                                                      otherButtonTitles:nil];
            [alertView show];
        }];
}

@end

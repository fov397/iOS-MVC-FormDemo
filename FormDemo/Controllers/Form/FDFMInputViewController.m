//
//  FDFMInputViewController.m
//  FormDemo
//
//  Created by sasaki on 2014/07/18.
//  Copyright (c) 2014年 mycompany. All rights reserved.
//

#import "FDFMInputViewController.h"
#import "FDFMHandedTableViewController.h"
#import "FDFMConfirmViewController.h"
#import "FDUserModel.h"
#import <TPKeyboardAvoiding/TPKeyboardAvoidingScrollView.h>
#import "UIView+FrameAccessor.h"
#import "NSString+Validation.h"

// segue identifier
NSString * const FDFMInputViewControllerInput2HandedTableSegueIdentifier
    = @"input2HandedTableSegueIdentifier";
NSString * const FDFMInputViewControllerInput2ConfirmSegueIdentifier
    = @"input2ConfirmSegueIdentifier";

@interface FDFMInputViewController () <UITextFieldDelegate, UITextViewDelegate>

@property (weak, nonatomic) IBOutlet TPKeyboardAvoidingScrollView *scrollView;

@property (weak, nonatomic) IBOutlet UITextField *userNameTextField;
@property (weak, nonatomic) IBOutlet UITextField *emailTextField;
@property (weak, nonatomic) IBOutlet UITextField *passwordTextField;
@property (weak, nonatomic) IBOutlet UITextView *noteTextView;

@property (strong, nonatomic) FDUserModel *userModel;

@end

@implementation FDFMInputViewController

#pragma mark - Life Cycle Methods

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    // スクロールの位置をリセット
    self.scrollView.contentOffset = CGPointZero;
}

#pragma mark - Selector + Internal Methods

- (void)_didBeginEditing
{
    // 右上に入力完了ボタンを追加
    UIBarButtonItem *didEndEditingBarButtonItem
        = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone
                                                        target:self
                                                        action:@selector(_didEndEditing)];
    self.navigationItem.rightBarButtonItem = didEndEditingBarButtonItem;
}

- (void)_didEndEditing
{
    // キーボードを閉じ、右上の入力完了ボタンを削除
    [self.view endEditing:YES];
    self.navigationItem.rightBarButtonItem = nil;
}

#pragma mark - Delegate
#pragma mark UITextViewDelegate

- (void)textViewDidBeginEditing:(UITextView *)textView
{
    [self _didBeginEditing];
}

#pragma mark UITextFieldDelegate

-(void)textFieldDidBeginEditing:(UITextField *)textField
{
    [self _didBeginEditing];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
   [self _didEndEditing];
    return YES;
}

#pragma mark - Navigation

- (BOOL)shouldPerformSegueWithIdentifier:(NSString *)identifier
                                  sender:(id)sender
{
    // 編集状態であれば編集を終了させてからチェックを実施
    [self _didEndEditing];
    
    if ([identifier isEqualToString:FDFMInputViewControllerInput2ConfirmSegueIdentifier]) {
        // 確認ページへ遷移する前に入力チェックを行う
        // FDUserModelを生成してバリデーションを実施
        
        NSDictionary *attributes
            = @{@"userName":[self.userNameTextField.text trim]       ?: [NSNull null],
                @"email":   [self.emailTextField.text trim]          ?: [NSNull null],
                @"handed":  [self.handedButton.titleLabel.text trim] ?: [NSNull null],
                @"password":[self.passwordTextField.text trim]       ?: [NSNull null],
                @"note":    [self.noteTextView.text trim]            ?: [NSNull null],};
        FDUserModel *userModel = [[FDUserModel alloc] initWithAttributes:attributes];
        
        NSString *errorMessage = [userModel validateForInsert];
        
        if (errorMessage) {
            UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"エラー"
                                                                message:errorMessage
                                                               delegate:nil
                                                      cancelButtonTitle:@"OK"
                                                      otherButtonTitles:nil];
            [alertView show];
        
            return NO;
        }

        // 画面遷移のために保持
        self.userModel = userModel;
    }
    
    return YES;
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    NSString *identifier = segue.identifier;
    
    if ([identifier isEqualToString:FDFMInputViewControllerInput2HandedTableSegueIdentifier]) {
        // 利き腕選択へ
        FDFMHandedTableViewController *handedTableViewController = [segue destinationViewController];
        
        // 現在のコントローラを渡して、選択完了時に値をセットさせる
        handedTableViewController.inputViewController            = self;
    }
    else if ([identifier isEqualToString:FDFMInputViewControllerInput2ConfirmSegueIdentifier]) {
        // 確認へ
        FDFMConfirmViewController *confirmViewController = [segue destinationViewController];
        confirmViewController.userModel                  = self.userModel;
    }
}

@end

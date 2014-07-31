//
//  FDRootViewController.m
//  FormDemo
//
//  Created by sasaki on 2014/07/23.
//  Copyright (c) 2014年 mycompany. All rights reserved.
//

#import "FDRootViewController.h"

@interface FDRootViewController ()

@end

@implementation FDRootViewController

//　Form　Storyboardを読み込んで入力画面を表示する
- (IBAction)inputButtonDidTouchUpInside:(UIButton *)sender {
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Form"
                                                         bundle:[NSBundle mainBundle]];
    
    UIViewController *formInitialViewController = [storyboard instantiateInitialViewController];    
    [self presentViewController:formInitialViewController animated:YES completion:nil];
}

@end

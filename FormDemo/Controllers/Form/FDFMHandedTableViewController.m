//
//  FDFMHandedTableViewController.m
//  FormDemo
//
//  Created by sasaki on 2014/07/29.
//  Copyright (c) 2014年 mycompany. All rights reserved.
//

#import "FDFMHandedTableViewController.h"
#import "FDConfigLoader.h"
#import "NSDictionary+Sort.h"

@interface FDFMHandedTableViewController ()

@property (strong, nonatomic) NSArray *handedValues;

@end

@implementation FDFMHandedTableViewController

#pragma mark - Life Cycle Methods

- (void)viewDidLoad
{
    // 利き腕一覧を取得して、セルの表示に使用する
    NSDictionary *fdConfig = [FDConfigLoader mixIn];
    NSDictionary *handed   = fdConfig[@"Handed"];
    self.handedValues      = [handed keyCompareSortedAllValues];
}

#pragma mark - DataSource
#pragma mark UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.handedValues.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"FDFMHandedTableViewCell" forIndexPath:indexPath];
    cell.textLabel.text   = self.handedValues[indexPath.row];
    
    cell.accessoryType = UITableViewCellAccessoryNone;
    
    // 前回選択の項目にのみチェックマークを付ける
    if ([cell.textLabel.text isEqualToString:self.inputViewController.handedButton.titleLabel.text]) {
        cell.accessoryType = UITableViewCellAccessoryCheckmark;
    }

    return cell;
}

#pragma mark - Delegate
#pragma mark UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // 選択された利き腕を入力画面に反映する
    [self.inputViewController.handedButton setTitle:self.handedValues[indexPath.row] forState:UIControlStateNormal];
    
    [self.navigationController popViewControllerAnimated:YES];
}

@end

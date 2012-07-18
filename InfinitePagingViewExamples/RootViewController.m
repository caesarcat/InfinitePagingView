//
//  RootViewController.m
//  InfinitePagingView
//
//  Created by SHIGETA Takuji
//  Copyright (c) 2012 qnote,Inc. All rights reserved.
//

#import "RootViewController.h"
#import "HPagingViewController.h"
#import "VPagingViewController.h"
#import "HPaddingPageViewController.h"
#import "VPaddingPageViewController.h"

@implementation RootViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"InfinitePagingView Examples";
}


#pragma mark - Table view data source

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 84.f;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 4;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        cell.textLabel.numberOfLines = 2;
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    switch (indexPath.row) {
        case 0:
            cell.textLabel.text = @"Horizontal ScrollView.";
            break;
        case 1:
            cell.textLabel.text = @"Vertical ScrollView.";
            break;
        case 2:
            cell.textLabel.text = @"Horizontal ScrollView \nwith padding.";
            break;
        case 3:
            cell.textLabel.text = @"Vertical ScrollView \nwith padding.";
            break;
        default:
            break;
    }    
    return cell;
}


#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    UIViewController *viewController = nil;
    if (indexPath.row == 0) {
        viewController = [[HPagingViewController alloc] initWithNibName:nil bundle:nil];
    } else if (indexPath.row == 1) {
        viewController = [[VPagingViewController alloc] initWithNibName:nil bundle:nil];
    } else if (indexPath.row == 2) {
        viewController = [[HPaddingPageViewController alloc] initWithNibName:nil bundle:nil];
    } else if (indexPath.row == 3) {
        viewController = [[VPaddingPageViewController alloc] initWithNibName:nil bundle:nil];
    } else {
        viewController = nil;
    }
    [self.navigationController pushViewController:viewController animated:YES];
}

@end

//
//  HPaddingPageViewController.m
//  InfinitePagingView
//
//  Created by SHIGETA Takuji
//  Copyright (c) 2012 qnote,Inc. All rights reserved.
//

#import "HPaddingPageViewController.h"
#import "InfinitePagingView.h"


@implementation HPaddingPageViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    CGFloat naviBarHeight = self.navigationController.navigationBar.frame.size.height;

    self.view.backgroundColor = [UIColor scrollViewTexturedBackgroundColor];

    // pagingView
    InfinitePagingView *pagingView = [[InfinitePagingView alloc] initWithFrame:CGRectMake(0.f, self.view.center.y - 100 - naviBarHeight, self.view.frame.size.width, 200.f)];
    pagingView.backgroundColor = [UIColor blackColor];
    pagingView.pageSize = CGSizeMake(120.f, self.view.frame.size.height);
    [self.view addSubview:pagingView];
    
    for (NSUInteger i = 1; i <= 15; ++i) {
        UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"%d.JPG", i]];
        UIImageView *page = [[UIImageView alloc] initWithImage:image];
        page.frame = CGRectMake(0.f, 0.f, 100.f, pagingView.frame.size.height);
        page.contentMode = UIViewContentModeScaleAspectFit;
        [pagingView addPageView:page];
    }
    
    // label
    UILabel *labelName = [[UILabel alloc] initWithFrame:CGRectMake(0.f, pagingView.frame.origin.y - 50.f, self.view.frame.size.width, 50.f)];
    labelName.textAlignment = UITextAlignmentCenter;
    labelName.textColor = [UIColor whiteColor];
    labelName.backgroundColor = [UIColor clearColor];
    labelName.text = @"⇦ ⇨";
    labelName.font = [UIFont boldSystemFontOfSize:50.f];
    [self.view addSubview:labelName];
}

@end

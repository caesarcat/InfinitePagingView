//
//  VPaddingPageViewController.m
//  InfinitePagingView
//
//  Created by SHIGETA Takuji
//  Copyright (c) 2012 qnote,Inc. All rights reserved.
//

#import "VPaddingPageViewController.h"
#import "InfinitePagingView.h"


@implementation VPaddingPageViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    CGFloat naviBarHeight = self.navigationController.navigationBar.frame.size.height;

    self.view.backgroundColor = [UIColor scrollViewTexturedBackgroundColor];

    // pagingView
    InfinitePagingView *pagingView = [[InfinitePagingView alloc] initWithFrame:CGRectMake(self.view.center.x - 65.f, 0.f, 130.f, self.view.frame.size.height - naviBarHeight)];
    pagingView.backgroundColor = [UIColor brownColor];
    pagingView.scrollDirection = InfinitePagingViewVerticalScrollDirection;
    // View size per one page.
    pagingView.pageSize = CGSizeMake(120.f, 120.f);
    [self.view addSubview:pagingView];
    
    for (NSUInteger i = 1; i <= 15; ++i) {
        UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"%d.JPG", i]];
        UIImageView *page = [[UIImageView alloc] initWithImage:image];
        page.backgroundColor = [UIColor blackColor];
        page.frame = CGRectMake(0.f, 0.f, 100.f, 100.f);
        page.contentMode = UIViewContentModeScaleAspectFit;
        [pagingView addPageView:page];
    }
    
    // label
    UILabel *labelName = [[UILabel alloc] initWithFrame:CGRectMake(pagingView.frame.origin.x - 110.f / 2, self.view.center.y - naviBarHeight - 110.f / 2, 55.f, 110.f)];
    labelName.clipsToBounds = NO;
    labelName.textAlignment = UITextAlignmentCenter;
    labelName.numberOfLines = 2;
    labelName.textColor = [UIColor whiteColor];
    labelName.backgroundColor = [UIColor clearColor];
    labelName.text = @"⇧\n⇩";
    labelName.font = [UIFont boldSystemFontOfSize:50.f];
    [self.view addSubview:labelName];
}

@end

//
//  HorizontalScrollViewController.m
//  InfinitePagingView
//
//  Created by SHIGETA Takuji
//  Copyright (c) 2012 qnote,Inc. All rights reserved.
//

#import "HPagingViewController.h"
#import "InfinitePagingView.h"


@implementation HPagingViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    CGFloat naviBarHeight = self.navigationController.navigationBar.frame.size.height;

    self.view.backgroundColor = [UIColor blackColor];
    
    // pagingView
    InfinitePagingView *pagingView = [[InfinitePagingView alloc] initWithFrame:CGRectMake(0.f, 0.f, self.view.frame.size.width, self.view.frame.size.height - naviBarHeight)];
    [self.view addSubview:pagingView];
    
    for (NSUInteger i = 1; i <= 15; ++i) {
        UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"%d.JPG", i]];
        UIImageView *page = [[UIImageView alloc] initWithImage:image];
        page.frame = CGRectMake(0.f, 0.f, pagingView.frame.size.width * 0.8, pagingView.frame.size.height * 0.8);
        page.contentMode = UIViewContentModeScaleAspectFit;
        [pagingView addPageView:page];
    }
    
    // label
    UILabel *labelName = [[UILabel alloc] initWithFrame:CGRectMake(0.f, 0.f, self.view.frame.size.width, 50.f)];
    labelName.textAlignment = UITextAlignmentCenter;
    labelName.textColor = [UIColor whiteColor];
    labelName.backgroundColor = [UIColor clearColor];
    labelName.text = @"⇦ ⇨";
    labelName.font = [UIFont boldSystemFontOfSize:50.f];
    [self.view addSubview:labelName];
}

@end

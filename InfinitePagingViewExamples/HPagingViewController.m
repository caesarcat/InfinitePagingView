//
//  HorizontalScrollViewController.m
//  InfinitePagingView
//
//  Created by SHIGETA Takuji
//  Copyright (c) 2012 qnote,Inc. All rights reserved.
//

#import "HPagingViewController.h"
#import "InfinitePagingView.h"

@interface HPagingViewController() <InfinitePagingViewDelegate>

@end

@implementation HPagingViewController
{
    UIPageControl *pageControl;
    InfinitePagingView *pagingView;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    CGFloat naviBarHeight = self.navigationController.navigationBar.frame.size.height;

    self.view.backgroundColor = [UIColor blackColor];
    
    // pagingView
    pagingView = [[InfinitePagingView alloc] initWithFrame:CGRectMake(0.f, 0.f, self.view.frame.size.width, self.view.frame.size.height - naviBarHeight)];
    pagingView.delegate = self;
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
    
    UIButton *previousButton = [UIButton buttonWithType:101];
    [previousButton setTitle:@"<" forState:UIControlStateNormal];
    previousButton.frame = CGRectMake(0.f, 0.f, 30.f, 80.f);
    previousButton.center = CGPointMake(previousButton.frame.size.width / 2.f, pagingView.center.y);
    [previousButton addTarget:pagingView action:@selector(scrollToPreviousPage) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:previousButton];
    
    UIButton *nextButton = [UIButton buttonWithType:101];
    [nextButton setTitle:@"<" forState:UIControlStateNormal];
    nextButton.transform = CGAffineTransformScale(nextButton.transform, -1, 1);
    nextButton.frame = CGRectMake(0.f, 0.f, 30.f, 80.f);
    nextButton.center = CGPointMake(pagingView.frame.size.width - previousButton.frame.size.width / 2.f, pagingView.center.y);
    [nextButton addTarget:pagingView action:@selector(scrollToNextPage) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:nextButton];
    
    // Page controller
    pageControl = [[UIPageControl alloc] init];
    pageControl.center = CGPointMake(self.view.center.x, pagingView.frame.size.height - 30.f);
    pageControl.numberOfPages = 15;
    [self.view addSubview:pageControl];
}

#pragma mark - InfinitePagingViewDelegate

- (void)pagingView:(InfinitePagingView *)pagingView didEndDecelerating:(UIScrollView *)scrollView atPageIndex:(NSInteger)pageIndex
{
    pageControl.currentPage = pageIndex;
}

@end

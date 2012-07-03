//
//  ViewController.m
//  InfinitePagingView
//
//  Created by SHIGETA Takuji
//  Copyright (c) 2012 qnote,Inc. All rights reserved.
//

#import "ViewController.h"
#import "InfinitePagingView.h"

@interface ViewController ()

@end

@implementation ViewController
@synthesize infinitePagingView = _infinitePagingView;

- (void)viewDidLoad
{
    [super viewDidLoad];
    InfinitePagingView *pagingView = [[InfinitePagingView alloc] initWithFrame:CGRectMake(275.f, 0.f, 45.f, self.view.frame.size.height)];
    pagingView.pageSize = CGSizeMake(0.f, 60.f);
    pagingView.scrollDirection = InfinitePagingViewVerticalScrollDirection;
    pagingView.backgroundColor = [UIColor scrollViewTexturedBackgroundColor];
    pagingView.tag = 101;
    for (NSUInteger i = 1; i <= 15; ++i) {
        UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"%d.JPG", i]];
        UIImageView *page = [[UIImageView alloc] initWithImage:image];
        page.frame = CGRectMake(0.f, 0.f, 45.f, 45.f);
        page.contentMode = UIViewContentModeScaleAspectFit;
        [pagingView addPageView:page];
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0.f, 0.f, 20.f, 10.f)];
        label.text = [NSString stringWithFormat:@"%d", i];
        [page addSubview:label];
    }
    [self.view addSubview:pagingView];

    _infinitePagingView.tag = 201;
    _infinitePagingView.backgroundColor = [UIColor scrollViewTexturedBackgroundColor];
    _infinitePagingView.clipsToBounds = YES;
    _infinitePagingView.pageSize = CGSizeMake(200.f, 0.f);
    
    for (NSUInteger i = 1; i <= 15; ++i) {
        UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"%d.JPG", i]];
        UIImageView *page = [[UIImageView alloc] initWithImage:image];
        page.frame = CGRectMake(0.f, 0.f, 180.f, 240.f);
        page.contentMode = UIViewContentModeScaleAspectFit;
        [_infinitePagingView addPageView:page];
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0.f, 0.f, 20.f, 10.f)];
        label.text = [NSString stringWithFormat:@"%d", i];
        [page addSubview:label];
    }
    
//    UIView *page1View = [[UIView alloc] initWithFrame:CGRectMake(0.f, 0.f, 220.f, 200.f)];
//    page1View.backgroundColor = [UIColor blackColor];
//    [_infinitePagingView addPageView:page1View];
//    UIView *page2View = [[UIView alloc] initWithFrame:CGRectMake(0.f, 0.f, 220.f, 200.f)];
//    page2View.backgroundColor = [UIColor blueColor];
//    [_infinitePagingView addPageView:page2View];
//    UIView *page3View = [[UIView alloc] initWithFrame:CGRectMake(0.f, 0.f, 220.f, 200.f)];
//    page3View.backgroundColor = [UIColor redColor];
//    [_infinitePagingView addPageView:page3View];
//    UIView *page4View = [[UIView alloc] initWithFrame:CGRectMake(0.f, 0.f, 220.f, 200.f)];
//    page4View.backgroundColor = [UIColor orangeColor];
//    [_infinitePagingView addPageView:page4View];
//    UIView *page5View = [[UIView alloc] initWithFrame:CGRectMake(0.f, 0.f, 220.f, 200.f)];
//    page5View.backgroundColor = [UIColor purpleColor];
//    [_infinitePagingView addPageView:page5View];
//    UIView *page6View = [[UIView alloc] initWithFrame:CGRectMake(0.f, 0.f, 220.f, 200.f)];
//    page6View.backgroundColor = [UIColor cyanColor];
//    [_infinitePagingView addPageView:page6View];
}

- (void)viewDidUnload
{
    self.infinitePagingView = nil;
    [super viewDidUnload];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
    } else {
        return YES;
    }
}

@end

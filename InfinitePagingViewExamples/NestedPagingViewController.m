//
//  NestedPagingViewController.m
//  InfinitePagingView
//
//  Created by SHIGETA Takuji
//  Copyright (c) 2012 qnote,Inc. All rights reserved.
//

#import "NestedPagingViewController.h"
#import "InfinitePagingView.h"


@implementation NestedPagingViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor viewFlipsideBackgroundColor];
    InfinitePagingView *pagingView = [[InfinitePagingView alloc] initWithFrame:CGRectMake(0.f, 0.f, self.view.frame.size.width, self.view.frame.size.height)];
    pagingView.scrollDirection = InfinitePagingViewVerticalScrollDirection;
    pagingView.pageSize = CGSizeMake(120.f, 120.f);
    pagingView.tag = 1;
    [self.view addSubview:pagingView];
    
    for (NSUInteger i = 1; i <= 15; ++i) {
        @autoreleasepool {
            InfinitePagingView *subPagingView = [[InfinitePagingView alloc] initWithFrame:CGRectMake(0.f, 0.f, self.view.frame.size.width, self.view.frame.size.height)];
            subPagingView.scrollDirection = InfinitePagingViewHorizonScrollDirection;
            subPagingView.pageSize = CGSizeMake(120.f, 120.f);
            subPagingView.tag = i * 10000;

            for (NSUInteger n = 1; n <= 15; ++n) {
                UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"%d.JPG", n]];
                UIImageView *page = [[UIImageView alloc] initWithImage:image];
                page.frame = CGRectMake(0.f, 0.f, 100.f, 100.f);
                page.tag = i * 1000 + n;
                page.backgroundColor = [UIColor colorWithRed:1.f green:1.f blue:1.f alpha:0.5f];
                page.contentMode = UIViewContentModeScaleAspectFit;
                [subPagingView addPageView:page];
            }
            [pagingView addPageView:subPagingView];            
        }
    }
}

@end

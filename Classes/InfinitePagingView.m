//
//  InfinitePagingView.m
//  InfinitePagingView
//
//  Created by SHIGETA Takuji
//

/**
 This is the MIT License.
 
 Copyright (c) 2012 SHIGETA Takuji.
 
 Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:
 
 The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.
 
 THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
 */


#import "InfinitePagingView.h"

@implementation InfinitePagingView
{
    UIScrollView *_innerScrollView;
    NSMutableArray *_pageViews;
    NSInteger _lastPageIndex;
}

@synthesize pageSize = _pageSize;
@synthesize scrollDirection = _scrollDirection;

- (void)setFrame:(CGRect)frame
{
    [super setFrame:frame];
    if (nil == _innerScrollView) {
        self.userInteractionEnabled = YES;
        self.clipsToBounds = YES;
        _innerScrollView = [[UIScrollView alloc] initWithFrame:frame];
        _innerScrollView.delegate = self;
        _innerScrollView.backgroundColor = [UIColor clearColor];
        _innerScrollView.clipsToBounds = NO;
        _innerScrollView.pagingEnabled = YES;
        _innerScrollView.scrollEnabled = YES;
        _innerScrollView.showsHorizontalScrollIndicator = NO;
        _innerScrollView.showsVerticalScrollIndicator = NO;
        _scrollDirection = InfinitePagingViewHorizonScrollDirection;
        [self addSubview:_innerScrollView];
        self.pageSize = frame.size;
    }
}

- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event
{
    UIView *hitView = [super hitTest:point withEvent:event];
    if (nil != hitView) {
        return _innerScrollView;
    }
    return nil;
}

#pragma mark - Public methods

- (void)addPageView:(UIView *)pageView
{
    if (nil == _pageViews) {
        _pageViews = [NSMutableArray array];
    }
    [_pageViews addObject:pageView];
    [self layoutPages];
}

#pragma mark - Private methods

- (void)layoutPages
{
    if (_scrollDirection == InfinitePagingViewHorizonScrollDirection) {
        CGFloat left_margin = (self.frame.size.width - _pageSize.width) / 2;
        _innerScrollView.frame = CGRectMake(left_margin, 0.f, _pageSize.width, self.frame.size.height);
        _innerScrollView.contentSize = CGSizeMake(self.frame.size.width * _pageViews.count, self.frame.size.height);
    } else {
        CGFloat top_margin  = (self.frame.size.height - _pageSize.height) / 2;
        _innerScrollView.frame = CGRectMake(0.f, top_margin, self.frame.size.width, _pageSize.height);
        _innerScrollView.contentSize = CGSizeMake(self.frame.size.width, self.frame.size.height * _pageViews.count);
    }
    NSUInteger idx = 0;
    for (UIView *pageView in _pageViews) {
        if (_scrollDirection == InfinitePagingViewHorizonScrollDirection) {
            pageView.center = CGPointMake(idx * (_innerScrollView.frame.size.width) + (_innerScrollView.frame.size.width / 2), _innerScrollView.center.y);
        } else {
            pageView.center = CGPointMake(_innerScrollView.center.x, idx * (_innerScrollView.frame.size.height) + (_innerScrollView.frame.size.height / 2));
        }
        [_innerScrollView addSubview:pageView];
        idx++;
    }

    _lastPageIndex = floor(_pageViews.count / 2);
    if (_scrollDirection == InfinitePagingViewHorizonScrollDirection) {
        _innerScrollView.contentSize = CGSizeMake(_pageViews.count * _innerScrollView.frame.size.width, self.frame.size.height);
        _innerScrollView.contentOffset = CGPointMake(_pageSize.width * _lastPageIndex, 0.f);
    } else {
        _innerScrollView.contentSize = CGSizeMake(_innerScrollView.frame.size.width, _pageSize.height * _pageViews.count);
        _innerScrollView.contentOffset = CGPointMake(0.f, _pageSize.height * _lastPageIndex);
    }
}

#pragma mark - UIScrollViewDelegate methods

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    NSInteger currentPageIndex = 0;
    if (_scrollDirection == InfinitePagingViewHorizonScrollDirection) {
        currentPageIndex = _innerScrollView.contentOffset.x / _innerScrollView.frame.size.width;
    } else {
        currentPageIndex = _innerScrollView.contentOffset.y / _innerScrollView.frame.size.height;
    }
    
    NSInteger moveDirection = currentPageIndex - _lastPageIndex;
    CGRect adjustScrollRect = CGRectZero;
    if (moveDirection == 0) {
        return;
    } else if (moveDirection > 0.f) {
        for (NSUInteger i = 0; i < abs(moveDirection); ++i) {
            UIView *leftView = [_pageViews objectAtIndex:0];
            [_pageViews removeObjectAtIndex:0];
            [_pageViews insertObject:leftView atIndex:_pageViews.count];
        }
        if (_scrollDirection == InfinitePagingViewHorizonScrollDirection) {
            adjustScrollRect = CGRectMake(scrollView.contentOffset.x - (_innerScrollView.frame.size.width * moveDirection),
                                          _innerScrollView.contentOffset.y,
                                          _innerScrollView.frame.size.width, _innerScrollView.frame.size.height);
        } else {
            adjustScrollRect = CGRectMake(_innerScrollView.contentOffset.x, 
                                          scrollView.contentOffset.y - (_innerScrollView.frame.size.height * moveDirection),
                                          _innerScrollView.frame.size.width, _innerScrollView.frame.size.height);
        }
        currentPageIndex -= moveDirection;
    } else if (moveDirection < 0) {
        for (NSUInteger i = 0; i < abs(moveDirection); ++i) {
            UIView *rightView = [_pageViews lastObject];
            [_pageViews removeLastObject];
            [_pageViews insertObject:rightView atIndex:0];
        }
        if (_scrollDirection == InfinitePagingViewHorizonScrollDirection) {
            adjustScrollRect = CGRectMake(scrollView.contentOffset.x + _innerScrollView.frame.size.width * abs(moveDirection),
                                          _innerScrollView.contentOffset.y, 
                                          _innerScrollView.frame.size.width, _innerScrollView.frame.size.height);
        } else {
            adjustScrollRect = CGRectMake(_innerScrollView.contentOffset.x,
                                          scrollView.contentOffset.y + _innerScrollView.frame.size.height * abs(moveDirection),
                                          _innerScrollView.frame.size.width, _innerScrollView.frame.size.height);
            
        }
        currentPageIndex += abs(moveDirection);
    }
    if (currentPageIndex > _pageViews.count - 1) {
        currentPageIndex = _pageViews.count - 1;
    }
    
    NSUInteger idx = 0;
    for (UIView *pageView in _pageViews) {
        UIView *pageView = [_pageViews objectAtIndex:idx];
        if (_scrollDirection == InfinitePagingViewHorizonScrollDirection) {
            pageView.center = CGPointMake(idx * _innerScrollView.frame.size.width + _innerScrollView.frame.size.width / 2, _innerScrollView.center.y);
        } else {
            pageView.center = CGPointMake(_innerScrollView.center.x, idx * (_innerScrollView.frame.size.height) + (_innerScrollView.frame.size.height / 2));
        }
        ++idx;
    }
    [_innerScrollView scrollRectToVisible:adjustScrollRect animated:NO];

    _lastPageIndex = currentPageIndex;
}

@end

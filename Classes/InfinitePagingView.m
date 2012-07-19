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
@synthesize currentPageIndex = _currentPageIndex;
@synthesize delegate;

- (void)setFrame:(CGRect)frame
{
    [super setFrame:frame];
    if (nil == _innerScrollView) {
        _currentPageIndex = 0;
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

- (void)scrollToPreviousPage
{
    [self scrollToDirection:1 animated:YES];
    [self performSelector:@selector(scrollViewDidEndDecelerating:) withObject:_innerScrollView afterDelay:0.5f]; // delay until scroll animation end.
}

- (void)scrollToNextPage
{
    [self scrollToDirection:-1 animated:YES];
    [self performSelector:@selector(scrollViewDidEndDecelerating:) withObject:_innerScrollView afterDelay:0.5f]; // delay until scroll animation end.
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

- (void)scrollToDirection:(NSInteger)moveDirection animated:(BOOL)animated
{
    CGRect adjustScrollRect;
    if (_scrollDirection == InfinitePagingViewHorizonScrollDirection) {
        if (0 != fmodf(_innerScrollView.contentOffset.x, _pageSize.width)) return ;
        adjustScrollRect = CGRectMake(_innerScrollView.contentOffset.x - _innerScrollView.frame.size.width * moveDirection,
                                      _innerScrollView.contentOffset.y, 
                                      _innerScrollView.frame.size.width, _innerScrollView.frame.size.height);
    } else {
        if (0 != fmodf(_innerScrollView.contentOffset.y, _pageSize.height)) return ;
        adjustScrollRect = CGRectMake(_innerScrollView.contentOffset.x,
                                      _innerScrollView.contentOffset.y - _innerScrollView.frame.size.height * moveDirection,
                                      _innerScrollView.frame.size.width, _innerScrollView.frame.size.height);
        
    }
    [_innerScrollView scrollRectToVisible:adjustScrollRect animated:animated];
}

#pragma mark - UIScrollViewDelegate methods

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    if (nil != delegate && [delegate respondsToSelector:@selector(pagingView:willBeginDragging:)]) {
        [delegate pagingView:self willBeginDragging:_innerScrollView];
    }
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if (nil != delegate && [delegate respondsToSelector:@selector(pagingView:didScroll:)]) {
        [delegate pagingView:self didScroll:_innerScrollView];
    }
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    if (nil != delegate && [delegate respondsToSelector:@selector(pagingView:didEndDragging:)]) {
        [delegate pagingView:self didEndDragging:_innerScrollView];
    }
}

- (void)scrollViewWillBeginDecelerating:(UIScrollView *)scrollView
{
    if (nil != delegate && [delegate respondsToSelector:@selector(pagingView:willBeginDecelerating:)]) {
        [delegate pagingView:self willBeginDecelerating:_innerScrollView];
    }
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    NSInteger pageIndex = 0;
    if (_scrollDirection == InfinitePagingViewHorizonScrollDirection) {
        pageIndex = _innerScrollView.contentOffset.x / _innerScrollView.frame.size.width;
    } else {
        pageIndex = _innerScrollView.contentOffset.y / _innerScrollView.frame.size.height;
    }
    
    NSInteger moveDirection = pageIndex - _lastPageIndex;
    if (moveDirection == 0) {
        return;
    } else if (moveDirection > 0.f) {
        for (NSUInteger i = 0; i < abs(moveDirection); ++i) {
            UIView *leftView = [_pageViews objectAtIndex:0];
            [_pageViews removeObjectAtIndex:0];
            [_pageViews insertObject:leftView atIndex:_pageViews.count];
        }
        pageIndex -= moveDirection;
    } else if (moveDirection < 0) {
        for (NSUInteger i = 0; i < abs(moveDirection); ++i) {
            UIView *rightView = [_pageViews lastObject];
            [_pageViews removeLastObject];
            [_pageViews insertObject:rightView atIndex:0];
        }
        pageIndex += abs(moveDirection);
    }
    if (pageIndex > _pageViews.count - 1) {
        pageIndex = _pageViews.count - 1;
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
    [self scrollToDirection:moveDirection animated:NO];

    _lastPageIndex = pageIndex;

    if (nil != delegate && [delegate respondsToSelector:@selector(pagingView:didEndDecelerating:atPageIndex:)]) {
        _currentPageIndex += moveDirection;
        if (_currentPageIndex < 0) {
            _currentPageIndex = _pageViews.count - 1;
        } else if (_currentPageIndex >= _pageViews.count) {
            _currentPageIndex = 0;
        }
        [delegate pagingView:self didEndDecelerating:_innerScrollView atPageIndex:_currentPageIndex];
    }
}

@end

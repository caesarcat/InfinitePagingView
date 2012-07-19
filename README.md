InfinitePagingView
=====================


Overview
--------
InfinitePagingView is a subclass of UIView. It contains an endlessly scrollable UIScrollView.

Features
--------
- Endlessly scrollable to horizontal (or vertical) direction.
- Each page view contents are available to a UIView based custom view.
- Implements paging delegate protocol.
- Page scroll action methods.
 

Requirements
------------
- iOS 4+
- Xcode 4.3 (Use ARC)

Screenshots
-----------
![Screenshot0](http://resources.qnote.jp/infinity-paging-view/sample4.png)
![Screenshot0](http://resources.qnote.jp/infinity-paging-view/sample1.png)
![Screenshot0](http://resources.qnote.jp/infinity-paging-view/sample2.png)
![Screenshot0](http://resources.qnote.jp/infinity-paging-view/sample3.png)


How to use
----------

```Objective-C
#import "InfinityPagingView.h"
...
- (void)loadView
{
    [super loadView];
    
    // create instance.
    InfinitePagingView *pagingView = [[InfinitePagingView alloc] initWithFrame:CGRectMake(0.f, 30.f, 100.f, 50.f)];
    
    // Adding each page views.(UIView based)
    // (At least 3 pages.)
    UIImageView *page1View = [[UIImageView alloc] initWithFrame:frame];
    [pagingView addPageView:page1View];
    ...
    [pagingView addPageView:page2View];
    [pagingView addPageView:page3View];
    [pagingView addPageView:page4View];
    [pagingView addPageView:page5View];
    
    [self.view addSubview:pagingView];
}
```

Build and run the project files. Enjoy more examples!

Public methods
--------

```Objective-C
- (void)addPageView:(UIView *)pageView;
```
Adds a view to the inner scrollview's subviews.

-

```Objective-C
- (void)scrollToPreviousPage;
```
Scroll to the previous page.

-

```Objective-C
- (void)scrollToNextPage;
```
Scroll to the next page.



InfinitePagingViewDelegate Protocols
-

```Objective-C
- (void)pagingView:(InfinitePagingView *)pagingView willBeginDragging:(UIScrollView *)scrollView;
```
Tells the delegate when the paging view is about to start scrolling the content.

-

```Objective-C
- (void)pagingView:(InfinitePagingView *)pagingView didScroll:(UIScrollView *)scrollView;
```
Tells the delegate when the user scrolls the content view within the receiver.

-

```Objective-C
- (void)pagingView:(InfinitePagingView *)pagingView didEndDragging:(UIScrollView *)scrollView;
```
Tells the delegate when dragging ended in the paging view.


-

```Objective-C
- (void)pagingView:(InfinitePagingView *)pagingView willBeginDecelerating:(UIScrollView *)scrollView;
```

Tells the delegate that the paging view is starting to decelerate the scrolling movement.

-

```Objective-C
- (void)pagingView:(InfinitePagingView *)pagingView didEndDecelerating:(UIScrollView *)scrollView atPageIndex:(NSInteger)pageIndex;
```
Tells the delegate that the scroll view has ended decelerating the scrolling movement.



License
-------
MIT License.

See LICENSE.txt for more information.

InfinityPagingView
=====================


Overview
--------
InfinityPagingView is a subclass of UIView. It contains an endlessly scrollable UIScrollView.

Features
--------
- Endlessly scrollable to horizontal (or vertical) direction.
- Each page view contents are available to a UIView based custom view.

Requirements
------------
- iOS 4+
- Xcode 4.3 (Uses ARC)

Screenshots
-----------
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


License
-------
MIT License.

See LICENSE.txt for more information.

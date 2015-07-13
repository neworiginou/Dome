//
//  TVGuidanceViewController.m
//  TVGuidance
//
//  Created by lben on 15/6/12.
//  Copyright (c) 2015年 lben. All rights reserved.
//

#import "TVGuidanceViewController.h"
#import "TVGuidancePage.h"
#import "TVGuidancePageViewController.h"

#import "TVGuidanceAnimationUpPageViewController.h"
#import "TVTTShakeView.h"

#define kAnimationDuration 1.0

@interface TVGuidanceViewController ()<UIScrollViewDelegate,UIPageViewControllerDataSource,UIPageViewControllerDelegate>{
    CGFloat     __dragStartPointX;
    NSInteger   __currentPageIndex;
}
@property (weak, nonatomic) UIScrollView * scrollView;
@property (strong, nonatomic) NSMutableArray * pageItems;
@property (strong, nonatomic) NSMutableArray * pageViewControllers;
@property (weak, nonatomic) UIPageViewController * pageViewController;
@property (weak, nonatomic) UIPageControl * pageControl;

@property (strong, nonatomic) NSMutableArray * reusePageControllers;
@property (strong, nonatomic) NSMutableDictionary * currentPageControllers;

@property (weak, nonatomic) UIViewController * preViewController;
@property (weak, nonatomic) UIViewController * currentViewController;
@property (weak, nonatomic) UIViewController * nextViewController;

@end

@implementation TVGuidanceViewController

- (instancetype)initWithItems:(NSArray *)items{
    self = [self init];
    if (self) {
        [self pInitData];
    }
    return self;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self pInitData];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
//    [self pMakeScrollView];
//    [self pMakePageConroller];
    TVTTShakeView * view = [[TVTTShakeView alloc] initWithFrame:CGRectMake(0, 0, 300, 300)];
    view.backgroundColor = [UIColor redColor];
//    [view addShakeAnimationAndRemoveOnCompletion:YES];
//    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//        [view addZoomAnimationAndRemoveOnCompletion:YES];
//    });
    [view addPathAnimationAndRemoveOnCompletion:YES completion:^(BOOL finished) {
        NSLog(@"haha");
    }];
    [self.view addSubview:view];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    TVGuidancePageViewController * vc = [self.pageViewController.viewControllers lastObject];
    [vc showAnimationWithDuration:kAnimationDuration];
}

#pragma mark - static  view

- (void)pInitData{
    TVGuidancePage * page_1 = [[TVGuidancePage alloc] initWithBackgroundPictureName:@"1" duation:.3 centerImageName:nil animationType:TVGuidancePageTypeLaunch];
    TVGuidancePage * page_2 = [[TVGuidancePage alloc] initWithBackgroundPictureName:@"2" duation:.3 centerImageName:nil animationType:TVGuidancePageTypeLaunch];
    TVGuidancePage * page_3 = [[TVGuidancePage alloc] initWithBackgroundPictureName:@"3" duation:.3 centerImageName:nil animationType:TVGuidancePageTypeLaunch];
    TVGuidancePage * page_4 = [[TVGuidancePage alloc] initWithBackgroundPictureName:@"4" duation:.3 centerImageName:nil animationType:TVGuidancePageTypeLaunchHome];
    [self.pageItems addObject:page_1];
    [self.pageItems addObject:page_2];
    [self.pageItems addObject:page_3];
    [self.pageItems addObject:page_4];
}

- (void)pMakePageConroller{
    UIPageViewController * pageViewController = ({
        UIPageViewController * pageViewController = [[UIPageViewController alloc] init];
        NSDictionary *options =[NSDictionary dictionaryWithObject:[NSNumber numberWithInteger:UIPageViewControllerSpineLocationMin]
                                                           forKey: UIPageViewControllerOptionSpineLocationKey];
        pageViewController = [[UIPageViewController alloc] initWithTransitionStyle:UIPageViewControllerTransitionStyleScroll
                                                             navigationOrientation:UIPageViewControllerNavigationOrientationHorizontal
                                                                           options: options];
        TVGuidancePageViewController *initialViewController =[self viewControllerAtIndex:0];// 得到第一页
        NSArray *viewControllers =[NSArray arrayWithObject:initialViewController];
        [pageViewController setViewControllers:viewControllers
                                     direction:UIPageViewControllerNavigationDirectionForward
                                      animated:NO
                                    completion:nil];
        [self addChildViewController:pageViewController];
        [self.view addSubview:pageViewController.view];
        pageViewController.delegate = self;
        pageViewController.dataSource = self;
        [pageViewController.view setFrame:self.view.bounds];
        pageViewController;
    });
    self.pageViewController = pageViewController;
    
    
    UIPageControl * pageControl = ({
        UIPageControl * pageControl = [[UIPageControl alloc] init];
        [self.view addSubview:pageControl];
        pageControl.backgroundColor = [UIColor grayColor];
        pageControl.numberOfPages = 4;
        pageControl.translatesAutoresizingMaskIntoConstraints = NO;
        [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:[pageControl(==200)]" options:0 metrics:nil views:NSDictionaryOfVariableBindings(pageControl)]];
        [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[pageControl(==30)]-20-|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(pageControl)]];
        [self.view addConstraint:[NSLayoutConstraint constraintWithItem:pageControl attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeCenterX multiplier:1.0 constant:0.0]];
        pageControl;
    });
    self.pageControl = pageControl;
}

- (void)pMakeScrollView{
    UIScrollView * scrollView = ({
        UIScrollView * scrollView = [[UIScrollView alloc] init];
        scrollView.frame = self.view.bounds;
        scrollView.pagingEnabled = YES;
        scrollView.delaysContentTouches = NO;
        scrollView.showsHorizontalScrollIndicator = NO;
        scrollView.showsVerticalScrollIndicator = NO;
        scrollView.contentSize = CGSizeMake([self.pageItems count] * CGRectGetWidth(self.view.frame), scrollView.contentSize.height);
        [self.view addSubview:scrollView];
        scrollView.delegate = self;
        scrollView;
    });
    self.scrollView = scrollView;
    
    for (int i = 0; i < (self.pageItems.count < 2 ? self.pageItems.count : 2) ; i++) {
        TVGuidancePageViewController *dataViewController = [self viewControllerAtIndex:i];
        if (i == 0) {
            [dataViewController showAnimationWithDuration:kAnimationDuration];
        }
    }
    self.scrollView.contentSize = CGSizeMake(CGRectGetWidth(self.view.frame) * self.pageItems.count, CGRectGetHeight(self.view.frame));
}

#pragma mark - get view controller
- (TVGuidancePageViewController *)viewControllerAtIndex:(NSUInteger)index {
    if (([self.pageItems count] == 0) || (index >= [self.pageItems count])) {
        return nil;
    }
    TVGuidancePage * page = [self.pageItems objectAtIndex:index];
    TVGuidancePageViewController *dataViewController = nil;
    if ([self.reusePageControllers count] > 0){
        dataViewController = [self.reusePageControllers lastObject];
        [dataViewController updatePageWithIndex:index pageType:page.pageType];
        [self.reusePageControllers removeLastObject];
    }else {
        dataViewController =[[TVGuidancePageViewController alloc] initWithIndex:index pageType:page.pageType];
    }
    
    dataViewController.view.tag = index;
    
    [self.currentPageControllers setObject:dataViewController forKey:[@(index) stringValue]];
    [self adjustPageViewControllerPosication:dataViewController];
    
    return dataViewController;
}
- (TVGuidancePageViewController *)currentPageViewControllerWithIndex:(NSInteger)index{
    TVGuidancePageViewController * pageViewController = [self.currentPageControllers objectForKey:[@(index) stringValue]];
    if (!pageViewController) {
        pageViewController = [self viewControllerAtIndex:index];
    }
    return pageViewController;
}

#pragma mark -
- (void)adjustPageViewControllerPosication:(TVGuidancePageViewController *)pageViewController{
    CGRect frame =  CGRectMake(CGRectGetWidth(self.view.frame)*pageViewController.index, 0, CGRectGetWidth(self.view.frame), CGRectGetHeight(self.view.frame));
    [pageViewController.view setFrame:frame];
    [self.scrollView addSubview:pageViewController.view];
}
#pragma mark -
- (void)recyclePageControllerWithIndex:(NSInteger)index{
    TVGuidancePageViewController * pageViewController = [self currentPageViewControllerWithIndex:index];
    if (pageViewController) {
        [pageViewController.view removeFromSuperview];
        [self.currentPageControllers removeObjectForKey:[@(index) stringValue]];
        [self.reusePageControllers addObject:pageViewController];
    }
}


#pragma mark - UIScrollViewDelegate

//dragging

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    NSLog(@"-----------------------------------------> start");
    NSInteger currentPage = scrollView.contentOffset.x/CGRectGetWidth(self.view.frame);
    NSLog(@"%@ %ld",NSStringFromSelector(_cmd),(long)currentPage);
    __dragStartPointX = scrollView.contentOffset.x;
}
-  (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
    NSInteger currentPage = scrollView.contentOffset.x/CGRectGetWidth(self.view.frame);
    NSLog(@"%@ %ld",NSStringFromSelector(_cmd),(long)currentPage);
}



//scroll to top
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
//    CGFloat scrollingPosition = scrollView.contentOffset.x/CGRectGetWidth(self.view.frame);
//    NSInteger currentPage = (int)scrollingPosition;
//    
//    TVGuidancePageViewController * pageViewController = [self currentPageViewControllerWithIndex:currentPage];
//    [pageViewController showAnimationWithDuration:kAnimationDuration];
    [(TVGuidancePageViewController *)_currentViewController showAnimationWithDuration:kAnimationDuration];
    [(TVGuidancePageViewController *)_preViewController hiddenAnimationViews];
    [(TVGuidancePageViewController *)_nextViewController hiddenAnimationViews];
    
}
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    
    CGFloat scrollingPosition = scrollView.contentOffset.x/CGRectGetWidth(self.view.frame);
    NSInteger currentPage = (int)scrollingPosition;

    TVGuidancePageViewController * pageViewController = [self currentPageViewControllerWithIndex:currentPage];
    _currentViewController = pageViewController;
//    
    //pre
    _preViewController = nil;
    NSInteger pro_page = currentPage - 1;
    if (pro_page >=0) {
        TVGuidancePageViewController * pageViewController = [self currentPageViewControllerWithIndex:pro_page];
        _preViewController = pageViewController;
    }
    
    //next
    _nextViewController = nil;
    NSInteger next_page = currentPage + 1;
    if (next_page < [self.pageItems count]) {
        TVGuidancePageViewController * pageViewController = [self currentPageViewControllerWithIndex:next_page];
        _nextViewController = pageViewController;
    }
    
    //reuse pre next
    NSInteger pro_pro_page = currentPage - 2;
    NSInteger next_next_page = currentPage + 2;
    if (pro_pro_page >= 0) {
        [self recyclePageControllerWithIndex:pro_pro_page];
    }
    if (next_next_page < [self.pageItems count]) {
        [self recyclePageControllerWithIndex:next_next_page];
    }
}
- (BOOL)scrollViewShouldScrollToTop:(UIScrollView *)scrollView{
    return NO;
}

- (void)scrollViewDidScrollToTop:(UIScrollView *)scrollView{
    NSInteger currentPage = scrollView.contentOffset.x/CGRectGetWidth(self.view.frame);
    NSLog(@"%@ %ld",NSStringFromSelector(_cmd),(long)currentPage);
}


//zoom
//- (void)scrollViewDidZoom:(UIScrollView *)scrollView{
//    NSInteger currentPage = scrollView.contentOffset.x/CGRectGetWidth(self.view.frame);
//    NSLog(@"%@ %ld",NSStringFromSelector(_cmd),(long)currentPage);
//}
//
//- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView{
//    UIView * v = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 100, 100)];
//    v.backgroundColor = [UIColor redColor];
//    return v;
//}
//- (void)scrollViewWillBeginZooming:(UIScrollView *)scrollView withView:(UIView *)view {
//    NSInteger currentPage = scrollView.contentOffset.x/CGRectGetWidth(self.view.frame);
//    NSLog(@"%@ %ld",NSStringFromSelector(_cmd),(long)currentPage);
//}
//- (void)scrollViewDidEndZooming:(UIScrollView *)scrollView withView:(UIView *)view atScale:(CGFloat)scale{
//    NSInteger currentPage = scrollView.contentOffset.x/CGRectGetWidth(self.view.frame);
//    NSLog(@"%@ %ld",NSStringFromSelector(_cmd),(long)currentPage);
//}


//decelerating

- (void)scrollViewWillBeginDecelerating:(UIScrollView *)scrollView{
    NSInteger currentPage = scrollView.contentOffset.x/CGRectGetWidth(self.view.frame);
    NSLog(@"%@ %ld",NSStringFromSelector(_cmd),(long)currentPage);
}



#pragma mark- UIPageViewControllerDataSource

//- (TVGuidancePageViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerBeforeViewController:(TVGuidancePageViewController *)viewController{
//    
//    [viewController showAnimationWithDuration:kAnimationDuration];
//    NSUInteger index = viewController.index;
//    if ((index == 0) || (index == NSNotFound)) {
//        return nil;
//    }
//    
//    index--;
//    TVGuidancePageViewController  * proPageViewController = [self viewControllerAtIndex:index];
//    return proPageViewController;
//}
//
//- (TVGuidancePageViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerAfterViewController:(TVGuidancePageViewController *)viewController{
//    
//    [viewController showAnimationWithDuration:kAnimationDuration];
//    NSUInteger index = viewController.index;
//    if (index == NSNotFound) {
//        return nil;
//    }
//    
//    index++;
//    if (index == [self.pageItems count]) {
//        return nil;
//    }
//    TVGuidancePageViewController * nextPageViewController = [self viewControllerAtIndex:index];
//    return nextPageViewController;
//}

#pragma mark - get

- (NSMutableArray *)pageItems{
    if (!_pageItems) {
        _pageItems = [[NSMutableArray alloc] init];
    }
    return _pageItems;
}
- (NSMutableArray *)pageViewControllers{
    if (!_pageViewControllers) {
        _pageViewControllers = [[NSMutableArray alloc] init];
    }
    return _pageViewControllers;
}
- (NSMutableArray *)reusePageControllers{
    if (!_reusePageControllers) {
        _reusePageControllers = [[NSMutableArray alloc] init];
    }
    return _reusePageControllers;
}
- (NSMutableDictionary *)currentPageControllers{
    if (!_currentPageControllers) {
        _currentPageControllers = [[NSMutableDictionary alloc] init];
    }
    return _currentPageControllers;
}
@end

//
//  TVAnimationGuidanceViewController.m
//  TVGuidance
//
//  Created by lbencs on 15/7/13.
//  Copyright © 2015年 lben. All rights reserved.
//

#import "TVAnimationGuidanceViewController.h"
#import "TVGuidanceAnimationPageViewController.h"
#import "TVGuidanceAnimationUpPageViewController.h"
#import "TVGuidanceZoomAnimationPageViewController.h"
#import "TVGuidanceShakeAnimationPageViewController.h"
#import "TVGuidanceXXZoomAnimationPageViewController.h"
#import "UIViewController+BaseView.h"


@interface TVAnimationGuidanceViewController ()<UIScrollViewDelegate>
@property (strong, nonatomic) NSMutableArray * pageItems;
@property (weak, nonatomic) UIScrollView * scrollView;

@end

@implementation TVAnimationGuidanceViewController

- (instancetype)initWithItems:(NSArray *)items{
    self = [self init];
    if (self) {
        [self pConfigData];
    }
    return self;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self pConfigData];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self pMakeScrollView];
}

- (void)viewWillLayoutSubviews{
    [super viewWillLayoutSubviews];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self.pageItems[0] performSelector:@selector(startAnimation)];
    });
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


#pragma mark - uiscrollview delegate

- (void)scrollViewDidEndDecelerating:(nonnull UIScrollView *)scrollView{
    NSInteger index = scrollView.contentOffset.x/scrollView.frame.size.width;
    TVGuidanceAnimationPageViewController * ctl = [self.pageItems objectAtIndex:index];
    [ctl startAnimation];
}

#pragma mark - static mothed

- (void)pMakeScrollView{
    UIView * contentView = [UIView new];
    
    UIScrollView * scrollView = ({
        UIScrollView * scrollView = [[UIScrollView alloc] init];
        scrollView.pagingEnabled = YES;
        scrollView.delaysContentTouches = NO;
        scrollView.showsHorizontalScrollIndicator = NO;
        scrollView.showsVerticalScrollIndicator = NO;
        scrollView.delegate = self;
        [self.view addSubview:scrollView];
        scrollView.translatesAutoresizingMaskIntoConstraints = NO;
        [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[scrollView]|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(scrollView)]];
        [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[scrollView]|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(scrollView)]];
        
        [scrollView addSubview:contentView];
        contentView.translatesAutoresizingMaskIntoConstraints = NO;
        [scrollView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-0-[contentView]-0-|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(contentView)]];
        [scrollView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-0-[contentView]-0-|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(contentView)]];
        [scrollView addConstraint:[NSLayoutConstraint constraintWithItem:contentView attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:scrollView attribute:NSLayoutAttributeHeight multiplier:1.0 constant:0]];
       
        scrollView;
    });
    self.scrollView = scrollView;
 
    __block  UIView * leftView = contentView;
    [_pageItems enumerateObjectsUsingBlock:^(TVGuidanceAnimationPageViewController *obj, NSUInteger idx, BOOL * __nonnull stop) {
        [contentView addSubview:obj.view];
        UIView * currentView = obj.view;
        currentView.translatesAutoresizingMaskIntoConstraints = NO;
        if (leftView == contentView) {
            // left view  is the super view
            [contentView addConstraint:[NSLayoutConstraint constraintWithItem:currentView attribute:NSLayoutAttributeLeading relatedBy:0 toItem:leftView attribute:NSLayoutAttributeLeading multiplier:1.0 constant:0.0]];
        }else{
            [contentView addConstraint:[NSLayoutConstraint constraintWithItem:currentView attribute:NSLayoutAttributeLeading relatedBy:0 toItem:leftView attribute:NSLayoutAttributeTrailing multiplier:1.0 constant:0.0]];
        }
        [contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-0-[currentView]-0-|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(currentView)]];
        [scrollView addConstraint:[NSLayoutConstraint constraintWithItem:obj.view attribute:NSLayoutAttributeWidth relatedBy:0 toItem:scrollView attribute:NSLayoutAttributeWidth multiplier:1.0 constant:0.0]];
        
        leftView = currentView;
    }];
    [contentView addConstraint:[NSLayoutConstraint constraintWithItem:leftView attribute:NSLayoutAttributeTrailing relatedBy:NSLayoutRelationEqual toItem:contentView attribute:NSLayoutAttributeTrailing multiplier:1.0 constant:0.0]];
}

- (void)pConfigData{
    [self.pageItems addObjectsFromArray:@[
        [TVGuidanceAnimationUpPageViewController tvtt_nibViewController],
        [TVGuidanceZoomAnimationPageViewController tvtt_nibViewController],
        [TVGuidanceShakeAnimationPageViewController tvtt_nibViewController],
        [TVGuidanceXXZoomAnimationPageViewController tvtt_nibViewController]
    ]];
}

#pragma mark - getter setter

- (NSMutableArray *)pageItems{
    if (!_pageItems) {
        _pageItems = [[NSMutableArray alloc] init];
    }
    return _pageItems;
}

@end

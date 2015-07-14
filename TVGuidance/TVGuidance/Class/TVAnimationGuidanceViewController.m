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



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
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
        obj.view.translatesAutoresizingMaskIntoConstraints = NO;
        [contentView addConstraint:[NSLayoutConstraint constraintWithItem:obj.view attribute:NSLayoutAttributeLeading relatedBy:0 toItem:leftView attribute:NSLayoutAttributeLeading multiplier:1.0 constant:0.1]];
         [contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-0-[currentView]-0-|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(currentView)]];
        [scrollView addConstraint:[NSLayoutConstraint constraintWithItem:obj.view attribute:NSLayoutAttributeWidth relatedBy:0 toItem:scrollView attribute:NSLayoutAttributeWidth multiplier:1.0 constant:0.0]];
        leftView = currentView;
    }];
    [contentView addConstraint:[NSLayoutConstraint constraintWithItem:leftView attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:contentView attribute:NSLayoutAttributeRight multiplier:1.0 constant:0.0]];
}
- (void)pConfigData{
    TVGuidanceAnimationUpPageViewController * ctl_1 = [[TVGuidanceAnimationUpPageViewController alloc] initWithNibName:@"TVGuidanceAnimationUpPageViewController" bundle:nil];
    [self.pageItems addObject:ctl_1];
}

- (NSMutableArray *)pageItems{
    if (!_pageItems) {
        _pageItems = [[NSMutableArray alloc] init];
    }
    return _pageItems;
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end

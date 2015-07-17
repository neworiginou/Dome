//
//  TVGuidanceAnimationPageViewController.m
//  TVGuidance
//
//  Created by lben on 15/7/13.
//  Copyright (c) 2015年 lben. All rights reserved.
//

#import "TVGuidanceAnimationPageViewController.h"
#import "TVTTAnimationView.h"
#import <CoreGraphics/CoreGraphics.h>

@interface TVGuidanceAnimationPageViewController (){
    BOOL _isAnimationed;
    __strong IBOutletCollection(id) NSArray * _animationViews;
    __weak IBOutlet NSLayoutConstraint *_topSpaceConstraint;
    __weak IBOutlet NSLayoutConstraint *_centerImageBottomConstraint;
    __weak IBOutlet NSLayoutConstraint *_bottomSpaceConstraint;
}
@end

@implementation TVGuidanceAnimationPageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
- (void)viewWillLayoutSubviews{
    [super viewWillLayoutSubviews];
    if ([UIScreen mainScreen].bounds.size.height == 480) {
        _topSpaceConstraint.constant = 35;
        _centerImageBottomConstraint.constant = 33;
        _bottomSpaceConstraint.constant = 25;
    }
}
- (void)startAnimation{
    if (self.isAnimationed) return;
    [_animationViews makeObjectsPerformSelector:@selector(addAnimation)];
}
- (BOOL)isAnimationed{
    if (_isAnimationed) {
        return YES;
    }
    _isAnimationed = YES;
    return NO;
}
@end

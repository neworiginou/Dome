//
//  TVGuidanceAnimationPageViewController.m
//  TVGuidance
//
//  Created by lben on 15/7/13.
//  Copyright (c) 2015年 lben. All rights reserved.
//

#import "TVGuidanceAnimationPageViewController.h"

#import <CoreGraphics/CoreGraphics.h>

@interface TVGuidanceAnimationPageViewController (){
    BOOL _isAnimationed;
    
    __weak IBOutlet NSLayoutConstraint *_topSpaceConstraint;
    __weak IBOutlet NSLayoutConstraint *_bottomSpaceConstraint;
    __weak IBOutlet NSLayoutConstraint *_centerImageBottomConstraint;
}

@end

@implementation TVGuidanceAnimationPageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)startAnimationWithType:(TVGuidanceAnimationType)animationType{
    
}

- (void)viewWillLayoutSubviews{
    [super viewWillLayoutSubviews];
    if ([UIScreen mainScreen].bounds.size.height == 480) {
        _topSpaceConstraint.constant = 35;
        _centerImageBottomConstraint.constant = 33;
        _bottomSpaceConstraint.constant = 25;
    }
}

//- (CABasicAnimation *)pathAnimation{
//    CAKeyframeAnimation * animation = [CAKeyframeAnimation animation];
//    return animation;
//}

- (void)startAnimation{
}

- (BOOL)isAnimationed{
    if (_isAnimationed) {
        return YES;
    }
    _isAnimationed = YES;
    return NO;
}

//抖动动画
- (CAKeyframeAnimation *)shakeAnimation{
    CAKeyframeAnimation * animation = [CAKeyframeAnimation animation];
    animation.keyPath = @"position.y";
    animation.values = @[@0, @10, @-10,@10,@0];
    animation.keyTimes = @[@0,@(1/6.0),@(3/6.0),@(5/6.0),@1];
    animation.duration = YES;
    return animation;
}
@end

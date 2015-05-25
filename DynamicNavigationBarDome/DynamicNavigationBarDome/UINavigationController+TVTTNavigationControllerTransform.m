//
//  UINavigationController+TVTTNavigationControllerTransform.m
//  DynamicNavigationBarDome
//
//  Created by lben on 15/5/25.
//  Copyright (c) 2015年 lben. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>

#import "UINavigationController+TVTTNavigationControllerTransform.h"


static CALayer *TRVSStillLayer = nil;
static CALayer *TRVSTransitioningLayer = nil;
static CALayer *HeadLayer = nil;
static NSTimeInterval const TRVSTransitionDuration = .2f;

@interface TRVSNavigationControllerTransitionAnimiationDelegate : NSObject

- (void)animationDidStop:(CAAnimation *)animation finished:(BOOL)flag;
+ (TRVSNavigationControllerTransitionAnimiationDelegate *)sharedDelegate;

@end

@implementation TRVSNavigationControllerTransitionAnimiationDelegate

- (void)animationDidStop:(CAAnimation *)animation finished:(BOOL)flag {
    [TRVSStillLayer removeFromSuperlayer];
    [TRVSTransitioningLayer removeFromSuperlayer];
}

+ (TRVSNavigationControllerTransitionAnimiationDelegate *)sharedDelegate {
    static dispatch_once_t onceToken;
    __strong static id sharedDelegate = nil;
    dispatch_once(&onceToken, ^{ sharedDelegate = [[self alloc] init]; });
    return sharedDelegate;
}

@end

@interface UINavigationController ()<UIGestureRecognizerDelegate>

@end


@implementation UINavigationController (TVTTNavigationControllerTransform)
- (void)tvtt_pushViewController:(UIViewController *)viewController animated:(BOOL)animated{
    TRVSStillLayer = [self trvs_layerSnapshotWithTransform:CATransform3DIdentity];
    
    [self pushViewController:viewController animated:NO];
    
    TRVSTransitioningLayer =
    [self trvs_layerSnapshotWithTransform:CATransform3DIdentity];
    TRVSTransitioningLayer.frame = (CGRect) {
        {CGRectGetWidth(self.view.bounds), CGRectGetMinY(self.view.bounds)},
        self.view.bounds.size};
    
    [self.view.layer addSublayer:TRVSStillLayer];
    [self.view.layer addSublayer:TRVSTransitioningLayer];
    
    [CATransaction flush];
    
    [TRVSStillLayer addAnimation:
     [self trvs_animationWithTranslation:-CGRectGetWidth(self.view.bounds)]
                          forKey:nil];
    [TRVSTransitioningLayer addAnimation:
     [self trvs_animationWithTranslation:-CGRectGetWidth(self.view.bounds)]
                                  forKey:nil];
    [self.interactivePopGestureRecognizer addTarget:self action:@selector(handleGesture:)];

}

- (void)handleGesture:(UIGestureRecognizer *)gestureRecognizer{
    
    UIPanGestureRecognizer * panGestureRecognizer = (UIPanGestureRecognizer *)gestureRecognizer;
    static CGFloat start_x = 0;
    if (gestureRecognizer.state == UIGestureRecognizerStateBegan){
//        TRVSTransitioningLayer =
//        [self trvs_layerSnapshotWithTransform:CATransform3DIdentity]	;
//        TRVSTransitioningLayer.frame = (CGRect) {
//            {CGRectGetWidth(self.view.bounds), CGRectGetMinY(self.view.bounds)},
//            self.view.bounds.size};
//        
//        [self.view.layer addSublayer:TRVSStillLayer];
//        [self.view.layer addSublayer:TRVSTransitioningLayer];
//        
//        [CATransaction flush];
        HeadLayer = [[CALayer alloc] init];
        HeadLayer.frame = CGRectMake(0, 0, 320, 64);
        HeadLayer.backgroundColor = [UIColor blueColor].CGColor;
        [self.view.layer addSublayer:HeadLayer];
        
        CGPoint translation = [panGestureRecognizer translationInView:self.view];
        start_x = translation.x;
    }
    
    CGPoint translation = [panGestureRecognizer translationInView:self.view];
    dispatch_async(dispatch_get_main_queue(), ^{
        CGRect frame = HeadLayer.frame;
        frame.origin.x = translation.x;
        HeadLayer.frame = frame;
        
    });
    
    if (translation.x == 0) {
        [HeadLayer removeFromSuperlayer];
    }
    
    if (gestureRecognizer.state == UIGestureRecognizerStateCancelled||gestureRecognizer.state == UIGestureRecognizerStateEnded||gestureRecognizer.state == UIGestureRecognizerStateFailed) {
//        [HeadLayer removeFromSuperlayer];
    }
}

- (UIViewController *)tvtt_popViewControllerAnimated:(BOOL)animated{
    TRVSStillLayer = [self trvs_layerSnapshotWithTransform:CATransform3DIdentity];
    
    [self popViewControllerAnimated:NO];
    
    TRVSTransitioningLayer =
    [self trvs_layerSnapshotWithTransform:CATransform3DIdentity];
    TRVSTransitioningLayer.frame = (CGRect) {
        {-CGRectGetWidth(self.view.bounds), CGRectGetMinY(self.view.bounds)},
        self.view.bounds.size};
    
    [self.view.layer addSublayer:TRVSStillLayer];
    [self.view.layer addSublayer:TRVSTransitioningLayer];
    
    [CATransaction flush];
    
    [TRVSStillLayer addAnimation:
     [self trvs_animationWithTranslation:CGRectGetWidth(self.view.bounds)]
                          forKey:nil];
    [TRVSTransitioningLayer addAnimation:
     [self trvs_animationWithTranslation:CGRectGetWidth(self.view.bounds)]
                                  forKey:nil];
    return nil;
}



- (CALayer *)trvs_layerSnapshotWithTransform:(CATransform3D)transform {
    if (UIGraphicsBeginImageContextWithOptions) {
        UIGraphicsBeginImageContextWithOptions(
                                               self.view.bounds.size, NO, [UIScreen mainScreen].scale);
    } else {
        UIGraphicsBeginImageContext(self.view.bounds.size);
    }
    
    [self.view.layer renderInContext:UIGraphicsGetCurrentContext()];
    
    UIImage *snapshot = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    CALayer *snapshotLayer = [CALayer layer];
    snapshotLayer.transform = transform;
    snapshotLayer.anchorPoint = CGPointMake(1.f, 1.f);
    snapshotLayer.frame = self.view.bounds;
    snapshotLayer.contents = (id)snapshot.CGImage;
    
    return snapshotLayer;
}

#pragma mark - Private

- (CABasicAnimation *)trvs_animationWithTranslation:(CGFloat)translation {
    CABasicAnimation *animation =
    [CABasicAnimation animationWithKeyPath:@"transform"];
    animation.toValue = [NSValue
                         valueWithCATransform3D:CATransform3DTranslate(
                                                                       CATransform3DIdentity, translation, 0.f, 0.f)];
    animation.duration = TRVSTransitionDuration;
    animation.delegate =
    [TRVSNavigationControllerTransitionAnimiationDelegate sharedDelegate];
    animation.removedOnCompletion = NO;
    animation.fillMode = kCAFillModeForwards;
    animation.timingFunction =
    [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut];
    
    return animation;
}


@end

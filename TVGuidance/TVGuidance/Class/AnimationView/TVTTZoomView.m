//
//  TVTTZoomView.m
//  TVGuidance
//
//  Created by lben on 15/7/13.
//  Copyright (c) 2015年 lben. All rights reserved.
//

#import "TVTTZoomView.h"

static const NSInteger kZoomAnimationDurationTime = 1.0;

@interface TVTTZoomView (){
    __weak IBOutlet UIImageView * imageView;
}
@end

@implementation TVTTZoomView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        [self setupHierarchy];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self)
    {
        [self setupHierarchy];
    }
    return self;
}

- (void)awakeFromNib{
    [super awakeFromNib];
    [self setupHierarchy];
}

- (void)setupHierarchy{
    imageView.transform =  CGAffineTransformMakeScale(0.0, 0.0);
}

#pragma mark - zoom

- (void)addAnimationWithBeginTime:(CFTimeInterval)beginTime andFillMode:(NSString *)fillMode andRemoveOnCompletion:(BOOL)removedOnCompletion completion:(void (^)(BOOL finished))completionBlock
{
    CAMediaTimingFunction *easeOutTiming = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut];
    
    if (completionBlock)
    {
        CABasicAnimation *representativeAnimation = [CABasicAnimation animationWithKeyPath:@"not.a.real.key"];
        representativeAnimation.duration = kZoomAnimationDurationTime;
        representativeAnimation.delegate = self;
        [self.layer addAnimation:representativeAnimation forKey:@"Zoom"];
        [self.completionBlocksByAnimation setObject:completionBlock forKey:[self.layer animationForKey:@"Zoom"]];
    }
    CGFloat t = 1.5;
    CAKeyframeAnimation *iMG0002ScaleXAnimation = [CAKeyframeAnimation animationWithKeyPath:@"transform.scale.x"];
    iMG0002ScaleXAnimation.duration = kZoomAnimationDurationTime;
    iMG0002ScaleXAnimation.values = @[@(0.050), @(0.100), @(0.200), @(0.300), @(0.400), @(0.500), @(0.600), @(0.700), @(0.800), @(0.900), @(1.000)];
    iMG0002ScaleXAnimation.keyTimes = @[@(0.030/t), @(0.060/t), @(0.090/t), @(0.120/t), @(0.150/t), @(0.180/t), @(0.210/t), @(0.24/t),@(0.27/t),@(0.300/t),@(0.330/t)];
    iMG0002ScaleXAnimation.timingFunctions = @[easeOutTiming, easeOutTiming, easeOutTiming, easeOutTiming, easeOutTiming];
    iMG0002ScaleXAnimation.beginTime = beginTime;
    iMG0002ScaleXAnimation.fillMode = fillMode;
    iMG0002ScaleXAnimation.removedOnCompletion = removedOnCompletion;
    [[imageView layer] addAnimation:iMG0002ScaleXAnimation forKey:@"zoom_ScaleX"];
    
    CAKeyframeAnimation *iMG0002ScaleYAnimation = [CAKeyframeAnimation animationWithKeyPath:@"transform.scale.y"];
    iMG0002ScaleYAnimation.duration = kZoomAnimationDurationTime;
    iMG0002ScaleYAnimation.values = @[@(0.050), @(0.100), @(0.200), @(0.300), @(0.400), @(0.500), @(0.600), @(0.700), @(0.800), @(0.900), @(1.000)];
    iMG0002ScaleYAnimation.keyTimes = @[@(0.030/t), @(0.060/t), @(0.090/t), @(0.120/t), @(0.150/t), @(0.180/t), @(0.210/t), @(0.24/t),@(0.27/t),@(0.300/t),@(0.330/t)];
    iMG0002ScaleYAnimation.timingFunctions = @[easeOutTiming, easeOutTiming, easeOutTiming, easeOutTiming, easeOutTiming];
    iMG0002ScaleYAnimation.beginTime = beginTime;
    iMG0002ScaleYAnimation.fillMode = fillMode;
    iMG0002ScaleYAnimation.removedOnCompletion = removedOnCompletion;
    [[imageView layer] addAnimation:iMG0002ScaleYAnimation forKey:@"zoom_ScaleY"];
}

- (void)removeAnimation
{
    [self.layer removeAnimationForKey:@"Zoom"];
    [[imageView layer] removeAnimationForKey:@"zoom_ScaleX"];
    [[imageView layer] removeAnimationForKey:@"zoom_ScaleY"];
}

- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag{
    imageView.transform = CGAffineTransformMakeScale(1.0,1.0);
    void (^completion)(BOOL) = [self.completionBlocksByAnimation objectForKey:anim];
    [self.completionBlocksByAnimation removeObjectForKey:anim];
    if (completion)
    {
        completion(flag);
    }
}

@end

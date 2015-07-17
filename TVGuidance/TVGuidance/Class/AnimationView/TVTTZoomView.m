//
//  TVTTZoomView.m
//  TVGuidance
//
//  Created by lben on 15/7/13.
//  Copyright (c) 2015年 lben. All rights reserved.
//

#import "TVTTZoomView.h"

static const NSInteger kZoomAnimationDurationTime = 0.5;

@interface TVTTZoomView (){
    __weak IBOutlet UIImageView * imageView;
    UIDynamicAnimator * _dynamicAnimator;
}
@property (strong, nonatomic) IBOutletCollection(id) NSArray * arrays;
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
    imageView.layer.transform = CATransform3DMakeAffineTransform(CGAffineTransformMakeScale(0.0, 0.0));
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
    
    CGFloat t = 15.0;
    CAKeyframeAnimation *iMG0002ScaleXAnimation = [CAKeyframeAnimation animationWithKeyPath:@"transform.scale"];
    iMG0002ScaleXAnimation.duration = kZoomAnimationDurationTime;
    iMG0002ScaleXAnimation.values =   @[@(0.00),@(1.2), @(1.0)];
    iMG0002ScaleXAnimation.keyTimes = @[@(1/t), @(12/t),@(15/t)];
    iMG0002ScaleXAnimation.timingFunctions = @[easeOutTiming, easeOutTiming, easeOutTiming];
    iMG0002ScaleXAnimation.beginTime = beginTime;
    iMG0002ScaleXAnimation.fillMode = fillMode;
    iMG0002ScaleXAnimation.removedOnCompletion = removedOnCompletion;
    [[imageView layer] addAnimation:iMG0002ScaleXAnimation forKey:@"zoom_Scale"];
    imageView.layer.transform = CATransform3DMakeAffineTransform(CGAffineTransformMakeScale(1.0, 1.0));
}

- (void)removeAnimation
{
    [self.layer removeAnimationForKey:@"Zoom"];
    [[imageView layer] removeAnimationForKey:@"zoom_Scale"];
}

- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag{
    void (^completion)(BOOL) = [self.completionBlocksByAnimation objectForKey:anim];
    [self.completionBlocksByAnimation removeObjectForKey:anim];
    if (completion)
    {
        completion(flag);
    }
}

@end

//
//  TVTTPathView.m
//  TVGuidance
//
//  Created by lben on 15/7/13.
//  Copyright (c) 2015年 lben. All rights reserved.
//

#import "TVTTPathView.h"

@interface TVTTPathView (){
    TVTTPathDirection _startDirection;
    TVTTPathDirection _endDirection;
    __weak IBOutlet UIImageView * _imageView;
    __weak IBOutlet NSLayoutConstraint * _leftConstraint;
    __weak IBOutlet NSLayoutConstraint * _rightConstraint;
    __weak IBOutlet NSLayoutConstraint * _bottomConstraint;
    __weak IBOutlet NSLayoutConstraint * _topConstraint;
    
}
@property (strong, nonatomic) NSMapTable *completionBlocksByAnimation;
@end

@implementation TVTTPathView


- (void)addPathAnimation
{
    [self addPathAnimationWithBeginTime:0 andFillMode:kCAFillModeBoth andRemoveOnCompletion:NO completion:NULL];
}

- (void)addPathAnimationWithCompletion:(void (^)(BOOL finished))completionBlock
{
    [self addPathAnimationWithBeginTime:0 andFillMode:kCAFillModeBoth andRemoveOnCompletion:NO completion:completionBlock];
}

- (void)addPathAnimationAndRemoveOnCompletion:(BOOL)removedOnCompletion
{
    [self addPathAnimationWithBeginTime:0 andFillMode:removedOnCompletion ? kCAFillModeRemoved : kCAFillModeBoth andRemoveOnCompletion:removedOnCompletion completion:NULL];
}

- (void)addPathAnimationAndRemoveOnCompletion:(BOOL)removedOnCompletion completion:(void (^)(BOOL finished))completionBlock
{
    [self addPathAnimationWithBeginTime:0 andFillMode:removedOnCompletion ? kCAFillModeRemoved : kCAFillModeBoth andRemoveOnCompletion:removedOnCompletion completion:completionBlock];
}

- (void)addPathAnimationWithBeginTime:(CFTimeInterval)beginTime andFillMode:(NSString *)fillMode andRemoveOnCompletion:(BOOL)removedOnCompletion completion:(void (^)(BOOL finished))completionBlock
{
    CAMediaTimingFunction *easeOutTiming = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut];
    
    if (completionBlock)
    {
        CABasicAnimation *representativeAnimation = [CABasicAnimation animationWithKeyPath:@"not.a.real.key"];
        representativeAnimation.duration = 0.250;
        representativeAnimation.delegate = self;
        [self.layer addAnimation:representativeAnimation forKey:@"Path"];
        [self.completionBlocksByAnimation setObject:completionBlock forKey:[self.layer animationForKey:@"Path"]];
    }
    
    CGFloat xPosition = self.frame.size.width - _imageView.frame.size.width;
    CGFloat yPosition = self.frame.size.height - _imageView.frame.size.height;
    if (_endDirection == TVTTPathDirectionRightTop) {
        xPosition = -xPosition;
    }
    
    CAKeyframeAnimation *iMG0002TranslationXAnimation = [CAKeyframeAnimation animationWithKeyPath:@"transform.translation.x"];
    iMG0002TranslationXAnimation.duration = 0.250;
    iMG0002TranslationXAnimation.values = @[@(0.000), @(-xPosition)];
    iMG0002TranslationXAnimation.keyTimes = @[@(0.000), @(1.000)];
    iMG0002TranslationXAnimation.timingFunctions = @[easeOutTiming];
    iMG0002TranslationXAnimation.beginTime = beginTime;
    iMG0002TranslationXAnimation.fillMode = fillMode;
    iMG0002TranslationXAnimation.removedOnCompletion = removedOnCompletion;
    [[_imageView layer] addAnimation:iMG0002TranslationXAnimation forKey:@"path_TranslationX"];
    
    CAKeyframeAnimation *iMG0002TranslationYAnimation = [CAKeyframeAnimation animationWithKeyPath:@"transform.translation.y"];
    iMG0002TranslationYAnimation.duration = 0.250;
    iMG0002TranslationYAnimation.values = @[@(0.000), @(-yPosition)];
    iMG0002TranslationYAnimation.keyTimes = @[@(0.000), @(1.000)];
    iMG0002TranslationYAnimation.timingFunctions = @[easeOutTiming];
    iMG0002TranslationYAnimation.beginTime = beginTime;
    iMG0002TranslationYAnimation.fillMode = fillMode;
    iMG0002TranslationYAnimation.removedOnCompletion = removedOnCompletion;
    [[_imageView layer] addAnimation:iMG0002TranslationYAnimation forKey:@"path_TranslationY"];
}

- (void)removePathAnimation
{
    [self.layer removeAnimationForKey:@"Path"];
    [[_imageView layer] removeAnimationForKey:@"path_TranslationX"];
    [[_imageView layer] removeAnimationForKey:@"path_TranslationY"];
}



- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag{
    
    if (_endDirection == TVTTPathDirectionLeftTop) {
        [self removeConstraints:@[_rightConstraint,_bottomConstraint]];
    }else{
        [self removeConstraints:@[_leftConstraint,_bottomConstraint]];
    }
    [self layoutIfNeeded];
    
    void (^completion)(BOOL) = [self.completionBlocksByAnimation objectForKey:anim];
    [self.completionBlocksByAnimation removeObjectForKey:anim];
    if (completion)
    {
        completion(flag);
    }
}



- (instancetype)initWithStartDirection:(TVTTPathDirection *)startDirection endDirection:(TVTTPathDirection)endDirection image:(UIImage *)image{
    if (self = [super init]) {
        
    }
    return self;
}

- (void)setStartDirection:(TVTTPathDirection)startDirection endDirection:(TVTTPathDirection)endDirection{
    _startDirection = startDirection;
    _endDirection = endDirection;
}


@end

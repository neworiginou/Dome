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
}
@end

@implementation TVTTPathView

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
}

- (void)addAnimationWithBeginTime:(CFTimeInterval)beginTime andFillMode:(NSString *)fillMode andRemoveOnCompletion:(BOOL)removedOnCompletion completion:(void (^)(BOOL finished))completionBlock
{
    CAMediaTimingFunction *easeOutTiming = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut];
    
    if (completionBlock)
    {
        CABasicAnimation *representativeAnimation = [CABasicAnimation animationWithKeyPath:@"not.a.real.key"];
        representativeAnimation.duration = 0.200;
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
    iMG0002TranslationXAnimation.duration = 0.400;
    iMG0002TranslationXAnimation.values = @[@(0.000), @(-xPosition)];
    iMG0002TranslationXAnimation.keyTimes = @[@(0.000), @(1.000)];
    iMG0002TranslationXAnimation.timingFunctions = @[easeOutTiming];
    iMG0002TranslationXAnimation.beginTime = beginTime;
    iMG0002TranslationXAnimation.fillMode = fillMode;
    iMG0002TranslationXAnimation.removedOnCompletion = removedOnCompletion;
    [[_imageView layer] addAnimation:iMG0002TranslationXAnimation forKey:@"path_TranslationX"];
    
    CAKeyframeAnimation *iMG0002TranslationYAnimation = [CAKeyframeAnimation animationWithKeyPath:@"transform.translation.y"];
    iMG0002TranslationYAnimation.duration = 0.400;
    iMG0002TranslationYAnimation.values = @[@(0.000), @(-yPosition)];
    iMG0002TranslationYAnimation.keyTimes = @[@(0.000), @(1.000)];
    iMG0002TranslationYAnimation.timingFunctions = @[easeOutTiming];
    iMG0002TranslationYAnimation.beginTime = beginTime;
    iMG0002TranslationYAnimation.fillMode = fillMode;
    iMG0002TranslationYAnimation.removedOnCompletion = removedOnCompletion;
    [[_imageView layer] addAnimation:iMG0002TranslationYAnimation forKey:@"path_TranslationY"];
    
    _imageView.layer.transform = CATransform3DMakeAffineTransform(CGAffineTransformMakeTranslation(- xPosition, -yPosition));
}
- (void)removeAnimation
{
    [self.layer removeAnimationForKey:@"Path"];
    [[_imageView layer] removeAnimationForKey:@"path_TranslationX"];
    [[_imageView layer] removeAnimationForKey:@"path_TranslationY"];
}

- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag{
    
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

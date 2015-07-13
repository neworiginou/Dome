//
//  TVTTShakeView.m
//  TVGuidance
//
//  Created by lben on 15/7/13.
//  Copyright (c) 2015年 lben. All rights reserved.
//

#import "TVTTShakeView.h"
#import "UIView+Constraints.h"

static CGFloat kZoomAnimationDurationTime = 1.25;


@interface TVTTShakeView ()

@property (strong, nonatomic) NSMapTable *completionBlocksByAnimation;
@property (weak, nonatomic) NSLayoutConstraint * constraintOfCenterX;
@property (weak, nonatomic) NSLayoutConstraint * constraintofCenterY;
@end


@implementation TVTTShakeView

#pragma mark - Life Cycle

- (instancetype)init
{
    return [self initWithFrame:CGRectMake(0,0,1136,768)];
}

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

#pragma mark - Scaling

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    UIView *scalingView = self.viewsByName[@"__scaling__"];
    float xScale = self.bounds.size.width / scalingView.bounds.size.width;
    float yScale = self.bounds.size.height / scalingView.bounds.size.height;
    switch (self.contentMode) {
        case UIViewContentModeScaleToFill:
            break;
        case UIViewContentModeScaleAspectFill:
        {
            float scale = MAX(xScale, yScale);
            xScale = scale;
            yScale = scale;
            break;
        }
        default:
        {
            float scale = MIN(xScale, yScale);
            xScale = scale;
            yScale = scale;
            break;
        }
    }
    scalingView.transform = CGAffineTransformMakeScale(xScale, yScale);
    scalingView.center = CGPointMake(CGRectGetMidX(self.bounds), CGRectGetMidY(self.bounds));
}

#pragma mark - Setup

- (void)setupHierarchy
{
    self.completionBlocksByAnimation = [NSMapTable mapTableWithKeyOptions:NSPointerFunctionsOpaqueMemory valueOptions:NSPointerFunctionsStrongMemory];
    NSMutableDictionary *viewsByName = [NSMutableDictionary dictionary];
    NSBundle *bundle = [NSBundle bundleForClass:[self class]];
    
    UIImageView *iMG0002 = [UIImageView new];
    iMG0002.translatesAutoresizingMaskIntoConstraints = NO;
//    iMG0002.layer.anchorPoint = CGPointMake(0.500, 0.524);
    UIImage *imgIMG0002 = [UIImage imageNamed:@"launch_limage_log"];//[UIImage imageWithContentsOfFile:[bundle pathForResource:@"launch_limage_log.png" ofType:nil]];
    iMG0002.image = imgIMG0002;
//    iMG0002.contentMode = UIViewContentModeCenter;
//    iMG0002.layer.position = CGPointMake(568.032, 387.310);
//    iMG0002.transform = CGAffineTransformMakeScale(0.45, 0.24);
    [self addSubview:iMG0002];
    
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[iMG0002(==78)]" options:0 metrics:nil views:NSDictionaryOfVariableBindings(iMG0002)]];
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:[iMG0002(==78)]" options:0 metrics:nil views:NSDictionaryOfVariableBindings(iMG0002)]];
    _constraintOfCenterX = [NSLayoutConstraint constraintWithItem:iMG0002 attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeCenterX multiplier:1.0f constant:0];
    [self addConstraint:_constraintOfCenterX];
    _constraintofCenterY = [NSLayoutConstraint constraintWithItem:iMG0002 attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeCenterY multiplier:1.0 constant:.0];
    [self addConstraint:_constraintofCenterY];
    
    viewsByName[@"IMG_0002"] = iMG0002;
    
    self.viewsByName = viewsByName;
}

#pragma mark - shake

- (void)addShakeAnimation
{
    [self addShakeAnimationWithBeginTime:0 andFillMode:kCAFillModeBoth andRemoveOnCompletion:NO completion:NULL];
}

- (void)addShakeAnimationWithCompletion:(void (^)(BOOL finished))completionBlock
{
    [self addShakeAnimationWithBeginTime:0 andFillMode:kCAFillModeBoth andRemoveOnCompletion:NO completion:completionBlock];
}

- (void)addShakeAnimationAndRemoveOnCompletion:(BOOL)removedOnCompletion
{
    [self addShakeAnimationWithBeginTime:0 andFillMode:removedOnCompletion ? kCAFillModeRemoved : kCAFillModeBoth andRemoveOnCompletion:removedOnCompletion completion:NULL];
}

- (void)addShakeAnimationAndRemoveOnCompletion:(BOOL)removedOnCompletion completion:(void (^)(BOOL finished))completionBlock
{
    [self addShakeAnimationWithBeginTime:0 andFillMode:removedOnCompletion ? kCAFillModeRemoved : kCAFillModeBoth andRemoveOnCompletion:removedOnCompletion completion:completionBlock];
}

- (void)addShakeAnimationWithBeginTime:(CFTimeInterval)beginTime andFillMode:(NSString *)fillMode andRemoveOnCompletion:(BOOL)removedOnCompletion completion:(void (^)(BOOL finished))completionBlock
{
    CAMediaTimingFunction *easeInTiming = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn];
    CAMediaTimingFunction *easeOutTiming = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut];
    
    if (completionBlock)
    {
        CABasicAnimation *representativeAnimation = [CABasicAnimation animationWithKeyPath:@"not.a.real.key"];
        representativeAnimation.duration = 4.000;
        representativeAnimation.delegate = self;
        [self.layer addAnimation:representativeAnimation forKey:@"Shake"];
        [self.completionBlocksByAnimation setObject:completionBlock forKey:[self.layer animationForKey:@"Shake"]];
    }
    
    CAKeyframeAnimation *iMG0002TranslationYAnimation = [CAKeyframeAnimation animationWithKeyPath:@"transform.translation.y"];
    iMG0002TranslationYAnimation.duration = 4.000;
    iMG0002TranslationYAnimation.values = @[@(0.000), @(-32), @(32), @(-16), @(16), @(-8), @(8),@(0)];
    iMG0002TranslationYAnimation.keyTimes = @[@(0.000), @(0.030), @(0.060), @(0.090), @(0.120),@(0.150),@(0.180),@(0.201)];
    iMG0002TranslationYAnimation.timingFunctions = @[easeInTiming, easeOutTiming, easeInTiming, easeOutTiming];
    iMG0002TranslationYAnimation.beginTime = beginTime;
    iMG0002TranslationYAnimation.fillMode = fillMode;
    iMG0002TranslationYAnimation.removedOnCompletion = removedOnCompletion;
    [[self.viewsByName[@"IMG_0002"] layer] addAnimation:iMG0002TranslationYAnimation forKey:@"shake_TranslationY"];
}
- (void)removeShakeAnimation
{
    [self.layer removeAnimationForKey:@"Shake"];
    [[self.viewsByName[@"IMG_0002"] layer] removeAnimationForKey:@"shake_TranslationY"];
}


#pragma mark - zoom

- (void)addZoomAnimation
{
    [self addZoomAnimationWithBeginTime:0 andFillMode:kCAFillModeBoth andRemoveOnCompletion:NO completion:NULL];
}

- (void)addZoomAnimationWithCompletion:(void (^)(BOOL finished))completionBlock
{
    [self addZoomAnimationWithBeginTime:0 andFillMode:kCAFillModeBoth andRemoveOnCompletion:NO completion:completionBlock];
}

- (void)addZoomAnimationAndRemoveOnCompletion:(BOOL)removedOnCompletion
{
    [self addZoomAnimationWithBeginTime:0 andFillMode:removedOnCompletion ? kCAFillModeRemoved : kCAFillModeBoth andRemoveOnCompletion:removedOnCompletion completion:NULL];
}

- (void)addZoomAnimationAndRemoveOnCompletion:(BOOL)removedOnCompletion completion:(void (^)(BOOL finished))completionBlock
{
    [self addZoomAnimationWithBeginTime:0 andFillMode:removedOnCompletion ? kCAFillModeRemoved : kCAFillModeBoth andRemoveOnCompletion:removedOnCompletion completion:completionBlock];
}

- (void)addZoomAnimationWithBeginTime:(CFTimeInterval)beginTime andFillMode:(NSString *)fillMode andRemoveOnCompletion:(BOOL)removedOnCompletion completion:(void (^)(BOOL finished))completionBlock
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
    
    CAKeyframeAnimation *iMG0002ScaleXAnimation = [CAKeyframeAnimation animationWithKeyPath:@"transform.scale.x"];
    iMG0002ScaleXAnimation.duration = kZoomAnimationDurationTime;
    iMG0002ScaleXAnimation.values = @[@(0.000), @(0.100), @(0.200), @(0.300), @(0.400), @(0.500), @(0.600), @(0.700), @(0.800), @(0.900), @(1.000)];
    iMG0002ScaleXAnimation.keyTimes = @[@(0.000), @(0.050), @(0.100), @(0.150), @(0.200), @(0.250), @(0.300), @(0.35),@(0.40),@(0.450),@(0.500)];
    iMG0002ScaleXAnimation.timingFunctions = @[easeOutTiming, easeOutTiming, easeOutTiming, easeOutTiming, easeOutTiming];
    iMG0002ScaleXAnimation.beginTime = beginTime;
    iMG0002ScaleXAnimation.fillMode = fillMode;
    iMG0002ScaleXAnimation.removedOnCompletion = removedOnCompletion;
    [[self.viewsByName[@"IMG_0002"] layer] addAnimation:iMG0002ScaleXAnimation forKey:@"zoom_ScaleX"];
    
    CAKeyframeAnimation *iMG0002ScaleYAnimation = [CAKeyframeAnimation animationWithKeyPath:@"transform.scale.y"];
    iMG0002ScaleYAnimation.duration = kZoomAnimationDurationTime;
    iMG0002ScaleYAnimation.values = @[@(0.000), @(0.100), @(0.200), @(0.300), @(0.400), @(0.500), @(0.600), @(0.700), @(0.800), @(0.900), @(1.000)];
    iMG0002ScaleYAnimation.keyTimes = @[@(0.000), @(0.050), @(0.100), @(0.150), @(0.200), @(0.250), @(0.300), @(0.35),@(0.40),@(0.450),@(0.500)];
    iMG0002ScaleYAnimation.timingFunctions = @[easeOutTiming, easeOutTiming, easeOutTiming, easeOutTiming, easeOutTiming];
    iMG0002ScaleYAnimation.beginTime = beginTime;
    iMG0002ScaleYAnimation.fillMode = fillMode;
    iMG0002ScaleYAnimation.removedOnCompletion = removedOnCompletion;
    [[self.viewsByName[@"IMG_0002"] layer] addAnimation:iMG0002ScaleYAnimation forKey:@"zoom_ScaleY"];
}

- (void)removeZoomAnimation
{
    [self.layer removeAnimationForKey:@"Zoom"];
    [[self.viewsByName[@"IMG_0002"] layer] removeAnimationForKey:@"zoom_ScaleX"];
    [[self.viewsByName[@"IMG_0002"] layer] removeAnimationForKey:@"zoom_ScaleY"];
    [[self.viewsByName[@"IMG_0002"] layer] removeAnimationForKey:@"zoom_TranslationX"];
    [[self.viewsByName[@"IMG_0002"] layer] removeAnimationForKey:@"zoom_TranslationY"];
}

#pragma mark - path

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
    
    CAKeyframeAnimation *iMG0002TranslationXAnimation = [CAKeyframeAnimation animationWithKeyPath:@"transform.translation.x"];
    iMG0002TranslationXAnimation.duration = 0.250;
    iMG0002TranslationXAnimation.values = @[@(0.000), @(-80)];
    iMG0002TranslationXAnimation.keyTimes = @[@(0.000), @(1.000)];
    iMG0002TranslationXAnimation.timingFunctions = @[easeOutTiming];
    iMG0002TranslationXAnimation.beginTime = beginTime;
    iMG0002TranslationXAnimation.fillMode = fillMode;
    iMG0002TranslationXAnimation.removedOnCompletion = removedOnCompletion;
    [[self.viewsByName[@"IMG_0002"] layer] addAnimation:iMG0002TranslationXAnimation forKey:@"path_TranslationX"];
    
    CAKeyframeAnimation *iMG0002TranslationYAnimation = [CAKeyframeAnimation animationWithKeyPath:@"transform.translation.y"];
    iMG0002TranslationYAnimation.duration = 0.250;
    iMG0002TranslationYAnimation.values = @[@(0.000), @(-80)];
    iMG0002TranslationYAnimation.keyTimes = @[@(0.000), @(1.000)];
    iMG0002TranslationYAnimation.timingFunctions = @[easeOutTiming];
    iMG0002TranslationYAnimation.beginTime = beginTime;
    iMG0002TranslationYAnimation.fillMode = fillMode;
    iMG0002TranslationYAnimation.removedOnCompletion = removedOnCompletion;
    [[self.viewsByName[@"IMG_0002"] layer] addAnimation:iMG0002TranslationYAnimation forKey:@"path_TranslationY"];
}

- (void)removePathAnimation
{
    [self.layer removeAnimationForKey:@"Path"];
    [[self.viewsByName[@"IMG_0002"] layer] removeAnimationForKey:@"path_TranslationX"];
    [[self.viewsByName[@"IMG_0002"] layer] removeAnimationForKey:@"path_TranslationY"];
}



- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag{
    _constraintofCenterY.constant -= 80;
    _constraintOfCenterX.constant -= 80;
    [(UIView *)self.viewsByName[@"IMG_0002"] layoutIfNeeded];
    
    void (^completion)(BOOL) = [self.completionBlocksByAnimation objectForKey:anim];
    [self.completionBlocksByAnimation removeObjectForKey:anim];
    if (completion)
    {
        completion(flag);
    }
}

- (void)removeAllAnimations
{
    for (UIView *view in self.viewsByName.allValues)
    {
        [view.layer removeAllAnimations];
    }
    [self.layer removeAnimationForKey:@"Shake"];
    [self.layer removeAnimationForKey:@"Zoom"];
    [self.layer removeAnimationForKey:@"Path"];
}

@end

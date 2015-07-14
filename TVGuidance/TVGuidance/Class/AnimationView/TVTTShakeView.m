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


@interface TVTTShakeView (){
    __weak IBOutlet UIImageView * _imageView;
}
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
    
//    UIView *scalingView = self.viewsByName[@"__scaling__"];
//    float xScale = self.bounds.size.width / scalingView.bounds.size.width;
//    float yScale = self.bounds.size.height / scalingView.bounds.size.height;
//    switch (self.contentMode) {
//        case UIViewContentModeScaleToFill:
//            break;
//        case UIViewContentModeScaleAspectFill:
//        {
//            float scale = MAX(xScale, yScale);
//            xScale = scale;
//            yScale = scale;
//            break;
//        }
//        default:
//        {
//            float scale = MIN(xScale, yScale);
//            xScale = scale;
//            yScale = scale;
//            break;
//        }
//    }
//    scalingView.transform = CGAffineTransformMakeScale(xScale, yScale);
//    scalingView.center = CGPointMake(CGRectGetMidX(self.bounds), CGRectGetMidY(self.bounds));
}

#pragma mark - Setup

- (void)setupHierarchy
{
    self.completionBlocksByAnimation = [NSMapTable mapTableWithKeyOptions:NSPointerFunctionsOpaqueMemory valueOptions:NSPointerFunctionsStrongMemory];
//    
//    NSMutableDictionary *viewsByName = [NSMutableDictionary dictionary];
//    NSBundle *bundle = [NSBundle bundleForClass:[self class]];
//    
//    UIImageView *iMG0002 = [UIImageView new];
//    iMG0002.translatesAutoresizingMaskIntoConstraints = NO;
////    iMG0002.layer.anchorPoint = CGPointMake(0.500, 0.524);
//    UIImage *imgIMG0002 = [UIImage imageNamed:@"launch_limage_log"];//[UIImage imageWithContentsOfFile:[bundle pathForResource:@"launch_limage_log.png" ofType:nil]];
//    iMG0002.image = imgIMG0002;
////    iMG0002.contentMode = UIViewContentModeCenter;
////    iMG0002.layer.position = CGPointMake(568.032, 387.310);
////    iMG0002.transform = CGAffineTransformMakeScale(0.45, 0.24);
//    [self addSubview:iMG0002];
//    
//    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[iMG0002(==78)]" options:0 metrics:nil views:NSDictionaryOfVariableBindings(iMG0002)]];
//    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:[iMG0002(==78)]" options:0 metrics:nil views:NSDictionaryOfVariableBindings(iMG0002)]];
//    _constraintOfCenterX = [NSLayoutConstraint constraintWithItem:iMG0002 attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeCenterX multiplier:1.0f constant:0];
//    [self addConstraint:_constraintOfCenterX];
//    _constraintofCenterY = [NSLayoutConstraint constraintWithItem:iMG0002 attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeCenterY multiplier:1.0 constant:.0];
//    [self addConstraint:_constraintofCenterY];
//    
//    viewsByName[@"IMG_0002"] = iMG0002;
//    
//    self.viewsByName = viewsByName;
}

#pragma mark - shake

- (void)addAnimationWithBeginTime:(CFTimeInterval)beginTime andFillMode:(NSString *)fillMode andRemoveOnCompletion:(BOOL)removedOnCompletion completion:(void (^)(BOOL finished))completionBlock
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
    iMG0002TranslationYAnimation.values = @[@(0.000), @(-8), @(4), @(-4), @(4), @(-2), @(2),@(0)];
    iMG0002TranslationYAnimation.keyTimes = @[@(0.000), @(0.030), @(0.060), @(0.090), @(0.120),@(0.150),@(0.180),@(0.201)];
    iMG0002TranslationYAnimation.timingFunctions = @[easeInTiming, easeOutTiming, easeInTiming, easeOutTiming];
    iMG0002TranslationYAnimation.beginTime = beginTime;
    iMG0002TranslationYAnimation.fillMode = fillMode;
    iMG0002TranslationYAnimation.removedOnCompletion = removedOnCompletion;
    [[_imageView layer] addAnimation:iMG0002TranslationYAnimation forKey:@"shake_TranslationY"];
}
- (void)removeAnimation
{
    [self.layer removeAnimationForKey:@"Shake"];
    [[_imageView layer] removeAnimationForKey:@"shake_TranslationY"];
}

- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag{
    
    void (^completion)(BOOL) = [self.completionBlocksByAnimation objectForKey:anim];
    [self.completionBlocksByAnimation removeObjectForKey:anim];
    if (completion)
    {
        completion(flag);
    }
}

- (void)removeAllAnimations
{
    [_imageView.layer removeAllAnimations];
    [self.layer removeAnimationForKey:@"Shake"];
    [self.layer removeAnimationForKey:@"Zoom"];
    [self.layer removeAnimationForKey:@"Path"];
}

@end

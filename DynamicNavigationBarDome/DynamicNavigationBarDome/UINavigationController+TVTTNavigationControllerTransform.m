//
//  UINavigationController+TVTTNavigationControllerTransform.m
//  DynamicNavigationBarDome
//
//  Created by lben on 15/5/25.
//  Copyright (c) 2015年 lben. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>
#import <objc/runtime.h>
#import "UINavigationController+TVTTNavigationControllerTransform.h"
#import "CABasicAnimation+TVTTAnimationDelegateBlock.h"

static CALayer * TVTTBottomViewControllerMirrorImageView = nil;
static CALayer * TVTTTopViewControllerMirrorImageView = nil;

static CGFloat const TVTTTransitionSpeed = .3/200.0;
static CGFloat const TVTTTransitionMargin = 30.0;
static CGFloat const TVTTTransitionDuration = 2.3;

static UIViewController * TVTTChildViewController = nil;
static UIPanGestureRecognizer * TVTTPanGestureRecognizer;

static CGPoint TVTTStartTouchPoint;
static BOOL _isGestureMoving;

static const char * kBlockKey = "TVTT_ANIMATIOND_DID_FINISHED_BLOCK_KEY";
static const char * kMirrorImageViewsKey = "TVTT_MIRROR_IMAGE_VIEW_KEY";
static const char * kTopScreenMirrorImageViewKey = "TVTT_TOP_SCREEN_MIRROR_IMAGE_VIEW_KEY";
static const char * kBottomScreenMirrorImageViewKey = "TVTT_BOTTOM_SCREEN_MIRROR_IMAGE_VIEW_KEY";

@protocol UINavigationControllerAnimationDelegate<NSObject>
- (void)animationDidStart:(CAAnimation *)anim;
- (void)animationDidStop:(CAAnimation *)animation finished:(BOOL)flag;
@end


@interface UINavigationController ()<UIGestureRecognizerDelegate,UINavigationControllerAnimationDelegate>


@property (strong, nonatomic) NSMutableArray * ttMirrorImageViews;

@property (weak, nonatomic) CALayer * ttTopScreenMirrorImageView;
@property (weak, nonatomic) CALayer * ttBottomScreenMirrorImageView;
@end


@implementation UINavigationController (TVTTNavigationControllerTransform)

#pragma mark - Getter Setter

- (void)setTtMirrorImageViews:(NSMutableArray *)ttMirrorImageViews{
    objc_setAssociatedObject(self, kMirrorImageViewsKey, ttMirrorImageViews, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
- (NSMutableArray *)ttMirrorImageViews{
   return objc_getAssociatedObject(self, kMirrorImageViewsKey);
}
- (CALayer *)ttTopScreenMirrorImageView{
    return objc_getAssociatedObject(self, kTopScreenMirrorImageViewKey);
}
- (void)setTtTopScreenMirrorImageView:(CALayer *)ttTopScreenMirrorImageView{
    objc_setAssociatedObject(self, kTopScreenMirrorImageViewKey, ttTopScreenMirrorImageView, OBJC_ASSOCIATION_RETAIN);
}
- (CALayer *)ttBottomScreenMirrorImageView{
    return objc_getAssociatedObject(self, kBottomScreenMirrorImageViewKey);
}
- (void)setTtBottomScreenMirrorImageView:(CALayer *)ttBottomScreenMirrorImageView{
    objc_setAssociatedObject(self, kBottomScreenMirrorImageViewKey, ttBottomScreenMirrorImageView, OBJC_ASSOCIATION_RETAIN);
}

#pragma mark - push pop

- (void)tvtt_pushViewController:(UIViewController *)viewController animated:(BOOL)animated{
    
    if (!self.ttMirrorImageViews) {
        self.ttMirrorImageViews = @[].mutableCopy;
    }
    
    self.ttBottomScreenMirrorImageView = [self tvtt_layerSnapshotWithTransform:CATransform3DIdentity];
    [self.ttMirrorImageViews addObject:self.ttBottomScreenMirrorImageView];
    
    [self pushViewController:viewController animated:NO];
    
    self.ttTopScreenMirrorImageView = [self tvtt_layerSnapshotWithTransform:CATransform3DIdentity];
    self.ttTopScreenMirrorImageView.frame = (CGRect) {
        {
            CGRectGetWidth(self.view.bounds), CGRectGetMinY(self.view.bounds)
        },
        self.view.bounds.size
    };
    
    [self.view.layer addSublayer:self.ttBottomScreenMirrorImageView];
    [self.view.layer addSublayer:self.ttTopScreenMirrorImageView];
    
    [CATransaction flush];
    
//<<<<<<< HEAD
//    [TRVSStillLayer addAnimation:
//     [self trvs_animationWithTranslation:-CGRectGetWidth(self.view.bounds)]
//                          forKey:nil];
//    [TRVSTransitioningLayer addAnimation:
//     [self trvs_animationWithTranslation:-CGRectGetWidth(self.view.bounds)]
//                                  forKey:nil];
//    [self.interactivePopGestureRecognizer addTarget:self action:@selector(handleGesture:)];
//
//}
//
//- (void)handleGesture:(UIGestureRecognizer *)gestureRecognizer{
//    
//    UIPanGestureRecognizer * panGestureRecognizer = (UIPanGestureRecognizer *)gestureRecognizer;
//    static CGFloat start_x = 0;
//    if (gestureRecognizer.state == UIGestureRecognizerStateBegan){
////        TRVSTransitioningLayer =
////        [self trvs_layerSnapshotWithTransform:CATransform3DIdentity]	;
////        TRVSTransitioningLayer.frame = (CGRect) {
////            {CGRectGetWidth(self.view.bounds), CGRectGetMinY(self.view.bounds)},
////            self.view.bounds.size};
////        
////        [self.view.layer addSublayer:TRVSStillLaye˜r];
////        [self.view.layer addSublayer:TRVSTransitioningLayer];
////        
////        [CATransaction flush];
//        HeadLayer = [[CALayer alloc] init];
//        HeadLayer.frame = CGRectMake(0, 0, 320, 64);
//        HeadLayer.backgroundColor = [UIColor blueColor].CGColor;
//        [self.view.layer addSublayer:HeadLayer];
//        
//        CGPoint translation = [panGestureRecognizer translationInView:self.view];
//        start_x = translation.x;
//    }
//=======
    __weak typeof(self) wSelf = self;
    
    [self.ttBottomScreenMirrorImageView addAnimation: [self tvtt_animationWithTranslation:-CGRectGetWidth(self.view.bounds) animationFinished:^(CAAnimation *animation, BOOL flag) {
        [wSelf.ttBottomScreenMirrorImageView removeAllAnimations];
        [wSelf.ttBottomScreenMirrorImageView removeFromSuperlayer];
    }] forKey:nil];
    [self.ttTopScreenMirrorImageView addAnimation: [self tvtt_animationWithTranslation:-CGRectGetWidth(self.view.bounds) animationFinished:^(CAAnimation *animation, BOOL flag) {
        [wSelf.ttTopScreenMirrorImageView removeAllAnimations];
        [wSelf.ttTopScreenMirrorImageView removeFromSuperlayer];
    }] forKey:nil];
    
    
    //gesutre
    self.interactivePopGestureRecognizer.enabled = NO;
    TVTTPanGestureRecognizer = [[UIPanGestureRecognizer alloc] init];
    TVTTPanGestureRecognizer.delegate = self;
    [TVTTPanGestureRecognizer addTarget:self action:@selector(handleGesture:)];
    [self.view addGestureRecognizer:TVTTPanGestureRecognizer];
}

- (UIViewController *)tvtt_popViewControllerAnimated:(BOOL)animated{
    
    self.ttTopScreenMirrorImageView =[self tvtt_layerSnapshotWithTransform:CATransform3DIdentity];
    
    self.ttBottomScreenMirrorImageView = [self.ttMirrorImageViews lastObject];
    self.ttBottomScreenMirrorImageView.frame = (CGRect) {
        {
            -CGRectGetWidth(self.view.bounds), CGRectGetMinY(self.view.bounds)
        },
        self.view.bounds.size
    };
    
    
    [self.view.layer addSublayer:self.ttBottomScreenMirrorImageView];
    [self.view.layer addSublayer:self.ttTopScreenMirrorImageView];
    
    [CATransaction flush];
    
    __weak typeof(self) wSelf = self;
    
    [self.ttBottomScreenMirrorImageView addAnimation:[self tvtt_animationWithTranslation:CGRectGetWidth(self.view.bounds) animationFinished:^(CAAnimation *animation, BOOL flag) {
        [wSelf.ttTopScreenMirrorImageView removeAllAnimations];
        [wSelf.ttBottomScreenMirrorImageView removeFromSuperlayer];
    }] forKey:nil];
    
    [self.ttTopScreenMirrorImageView addAnimation:[self tvtt_animationWithTranslation:CGRectGetWidth(self.view.bounds) animationFinished:^(CAAnimation *animation, BOOL flag) {
        [wSelf.ttTopScreenMirrorImageView removeAllAnimations];
        [wSelf.ttTopScreenMirrorImageView removeFromSuperlayer];
        [self tvtt_popViewController];
        
    }]forKey:nil];
    
    self.interactivePopGestureRecognizer.enabled = YES;
    TVTTPanGestureRecognizer.delegate = nil;
    [TVTTPanGestureRecognizer removeTarget:self action:@selector(handleGesture:)];
    [self.view removeGestureRecognizer:TVTTPanGestureRecognizer];
    TVTTPanGestureRecognizer = nil;
    
    return nil;
}





#pragma mark - UINavigationBarDelegate

- (BOOL)navigationBar:(UINavigationBar *)navigationBar shouldPopItem:(UINavigationItem *)item {
    if([self.viewControllers count] < [navigationBar.items count]) {
        return YES;
    }
    if (TVTTPanGestureRecognizer) {
        [self tvtt_popViewControllerAnimated:YES];
    }else{
        [self popViewControllerAnimated:YES];
    }
    return NO;
}

#pragma mark - UIGestureRecognizerDelegate

- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer{
//    TVTTTopViewControllerMirrorImageView = [self tvtt_layerSnapshotWithTransform:CATransform3DIdentity];
    self.ttTopScreenMirrorImageView = [self tvtt_layerSnapshotWithTransform:CATransform3DIdentity];
    return YES;
}

#pragma mark - SEL

- (void)handleGesture:(UIPanGestureRecognizer *)panGestureRecognizer{
    
    CGPoint touchPoint = [panGestureRecognizer locationInView:self.view];
    
    __weak typeof(self) wSelf = self;
    
   if (panGestureRecognizer.state == UIGestureRecognizerStateBegan){
       
        TVTTStartTouchPoint = touchPoint;
       
        _isGestureMoving = TVTTStartTouchPoint.x <= TVTTTransitionMargin;
       
       self.ttBottomScreenMirrorImageView = [[self ttMirrorImageViews] lastObject];
       
       if (_isGestureMoving) {
           [self.view.layer addSublayer:self.ttBottomScreenMirrorImageView];
           [self.view.layer addSublayer:self.ttTopScreenMirrorImageView];
       }
       
    }else if (panGestureRecognizer.state == UIGestureRecognizerStateEnded){
        
        _isGestureMoving = NO;
        CGFloat movingDistance = touchPoint.x - TVTTStartTouchPoint.x;
        
        if (movingDistance < 0){[self tvtt_removeMirrorImageView];return;}
        
        if (movingDistance >= self.view.frame.size.width/2.0) {
            [self.ttTopScreenMirrorImageView addAnimation:[self tvtt_animationWithTranslation: + movingDistance animationFinished:^(CAAnimation *animation, BOOL flag) {
                [self tvtt_popViewController];
                [wSelf.ttTopScreenMirrorImageView removeAllAnimations];
                
                [wSelf.ttBottomScreenMirrorImageView removeFromSuperlayer];
                [wSelf.ttTopScreenMirrorImageView removeFromSuperlayer];
                wSelf.ttTopScreenMirrorImageView = nil;
                wSelf.ttBottomScreenMirrorImageView = nil;
            }]  forKey:nil];
            
        }else{
            
            [self.ttTopScreenMirrorImageView addAnimation:[self tvtt_animationWithTranslation: - movingDistance animationFinished:^(CAAnimation *animation, BOOL flag) {
                
                [wSelf.ttTopScreenMirrorImageView removeAllAnimations];
                [wSelf.ttBottomScreenMirrorImageView removeFromSuperlayer];
                [wSelf.ttTopScreenMirrorImageView removeFromSuperlayer];
                wSelf.ttTopScreenMirrorImageView = nil;
                wSelf.ttBottomScreenMirrorImageView = nil;
                
            }] forKey:nil];
        }
        
        return;
    }else if (panGestureRecognizer.state == UIGestureRecognizerStateCancelled){
        _isGestureMoving = NO;
        CGFloat movingDistance = touchPoint.x - TVTTStartTouchPoint.x;
        if (movingDistance < 0) return;
        
        
        return;
    }
    
   
    if (_isGestureMoving) {
        CGRect frame = self.ttTopScreenMirrorImageView.frame;
        CGFloat endX = touchPoint.x - TVTTStartTouchPoint.x;
        endX = endX < 0 ? 0 : endX;
        endX = endX > CGRectGetWidth(self.view.frame) ? CGRectGetWidth(self.view.frame):endX;
        frame.origin.x = endX;
        self.ttTopScreenMirrorImageView.frame = frame;
    }
}

#pragma mark - Private

- (void)tvtt_removeMirrorImageView{
    [self.ttTopScreenMirrorImageView removeFromSuperlayer];
    [self.ttBottomScreenMirrorImageView removeFromSuperlayer];
 }

- (void)tvtt_popViewController{
    [self popViewControllerAnimated:NO];
    [self.ttMirrorImageViews removeLastObject];
}

#pragma mark -  Get CurrentScreen ImageView

- (CALayer *)tvtt_layerSnapshotWithTransform:(CATransform3D)transform {
    
    UIGraphicsBeginImageContextWithOptions(self.view.bounds.size, NO, [UIScreen mainScreen].scale);
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

#pragma mark - Get Animation 
- (CABasicAnimation *)tvtt_animationWithTranslation:(CGFloat)translation duration:(CGFloat)duration animationFinished:(void(^)(CAAnimation * animation, BOOL flag))finishBlock{
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"transform"];
    animation.toValue = [NSValue valueWithCATransform3D:CATransform3DTranslate(CATransform3DIdentity, translation, 0.f, 0.f)];
    animation.duration = duration;
    [animation tvtt_setAnimationDidFinishBlock:finishBlock];
    animation.removedOnCompletion = NO;
    animation.fillMode = kCAFillModeForwards;
    animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut];
    return animation;
}

- (CABasicAnimation *)tvtt_animationWithTranslation:(CGFloat)translation speed:(CGFloat)speed animationFinished:(void(^)(CAAnimation * animation, BOOL flag))finishBlock{
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"transform"];
    animation.toValue = [NSValue valueWithCATransform3D:CATransform3DTranslate(CATransform3DIdentity, translation, 0.f, 0.f)];
    CGFloat duration = speed * translation;
    NSLog(@"%f---%f-->",translation,duration);
    animation.duration = duration > 0 ? duration : -duration;
    [animation tvtt_setAnimationDidFinishBlock:finishBlock];
    animation.removedOnCompletion = NO;
    animation.fillMode = kCAFillModeForwards;
    animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut];
    return animation;
}
- (CABasicAnimation *)tvtt_animationWithTranslation:(CGFloat)translation animationFinished:(void(^)(CAAnimation * animation, BOOL flag))finishBlock{
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"transform"];
    animation.toValue = [NSValue valueWithCATransform3D:CATransform3DTranslate(CATransform3DIdentity, translation, 0.f, 0.f)];
    CGFloat duration = TVTTTransitionSpeed * translation;
    NSLog(@"%f---%f-->",translation,duration);
    animation.duration = duration > 0 ? duration : -duration;
    [animation tvtt_setAnimationDidFinishBlock:finishBlock];
    animation.removedOnCompletion = NO;
    animation.fillMode = kCAFillModeForwards;
    animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut];
    return animation;
}
- (CABasicAnimation *)tvtt_animationWithTranslation:(CGFloat)translation{
    return [self tvtt_animationWithTranslation:translation animationFinished:nil];
}

@end

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

static CGFloat const TVTTTransitionSpeed = .2/200.0;
static CGFloat const TVTTTransitionMargin = 30.0;

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

@property (copy, nonatomic) void(^ tvtt_animationDidFinishedBlock)(CAAnimation * animation, BOOL flag);

@property (strong, nonatomic) NSMutableArray * tvtt_mirrorImageViews;

@property (weak, nonatomic) CALayer * tvtt_topScreenMirrorImageView;
@property (weak, nonatomic) CALayer * tvtt_bottomScreenMirrorImageView;
@end


@implementation UINavigationController (TVTTNavigationControllerTransform)

#pragma mark - Getter Setter

- (void (^)(CAAnimation *, BOOL))tvtt_animationDidFinishedBlock{
    return objc_getAssociatedObject(self, kBlockKey);
}
- (void)setTvtt_animationDidFinishedBlock:(void (^)(CAAnimation *, BOOL))tvtt_animationDidFinishedBlock{
    objc_setAssociatedObject(self, kBlockKey, tvtt_animationDidFinishedBlock, OBJC_ASSOCIATION_COPY_NONATOMIC);
}
- (void)setTvtt_mirrorImageViews:(NSMutableArray *)tvtt_mirrorImageViews{
    objc_setAssociatedObject(self, kMirrorImageViewsKey, tvtt_mirrorImageViews, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
- (NSMutableArray *)tvtt_mirrorImageViews{
   return objc_getAssociatedObject(self, kMirrorImageViewsKey);
}
- (CALayer *)tvtt_topScreenMirrorImageView{
    return objc_getAssociatedObject(self, kTopScreenMirrorImageViewKey);
}
- (void)setTvtt_topScreenMirrorImageView:(CALayer *)tvtt_topScreenMirrorImageView{
    objc_setAssociatedObject(self, kTopScreenMirrorImageViewKey, tvtt_topScreenMirrorImageView, OBJC_ASSOCIATION_ASSIGN);
}
- (CALayer *)tvtt_bottomScreenMirrorImageView{
    return objc_getAssociatedObject(self, kBottomScreenMirrorImageViewKey);
}
- (void)setTvtt_bottomScreenMirrorImageView:(CALayer *)tvtt_bottomScreenMirrorImageView{
    objc_setAssociatedObject(self, kBottomScreenMirrorImageViewKey, tvtt_bottomScreenMirrorImageView, OBJC_ASSOCIATION_ASSIGN);
}


#pragma mark  - UINavigationControllerAnimationDelegate

//- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag{
//    
//    if ([self tvtt_animationDidFinishedBlock]) {
//        dispatch_async(dispatch_get_main_queue(), ^{
//            [self tvtt_animationDidFinishedBlock](anim,flag);
//        });
//    }
//    
//    [self.tvtt_topScreenMirrorImageView removeFromSuperlayer];
//    [self.tvtt_bottomScreenMirrorImageView removeFromSuperlayer];
////    self.tvtt_bottomScreenMirrorImageView = nil;
////    self.tvtt_topScreenMirrorImageView = nil;
//}
//- (void)animationDidStart:(CAAnimation *)anim{
//    
//}

#pragma mark - push pop

- (void)tvtt_pushViewController:(UIViewController *)viewController animated:(BOOL)animated{
    
    if (!self.tvtt_mirrorImageViews) {
        self.tvtt_mirrorImageViews = @[].mutableCopy;
    }
    self.tvtt_bottomScreenMirrorImageView = [self tvtt_layerSnapshotWithTransform:CATransform3DIdentity];
    [self.tvtt_mirrorImageViews addObject:self.tvtt_bottomScreenMirrorImageView];
    
    [self pushViewController:viewController animated:NO];
    
    self.tvtt_topScreenMirrorImageView = [self tvtt_layerSnapshotWithTransform:CATransform3DIdentity];
    self.tvtt_topScreenMirrorImageView.frame = (CGRect) {
        {
            CGRectGetWidth(self.view.bounds), CGRectGetMinY(self.view.bounds)
        },
        self.view.bounds.size
    };
    
    [self.view.layer addSublayer:self.tvtt_bottomScreenMirrorImageView];
    [self.view.layer addSublayer:self.tvtt_topScreenMirrorImageView];
    
    [CATransaction flush];
    
    __weak typeof(self) wSelf = self;
    [self.tvtt_bottomScreenMirrorImageView addAnimation:[self tvtt_animationWithTranslation:-CGRectGetWidth(self.view.bounds) animationFinished:^(CAAnimation *animation, BOOL flag) {
        [wSelf.tvtt_bottomScreenMirrorImageView removeFromSuperlayer];
    }] forKey:nil];
    [self.tvtt_topScreenMirrorImageView addAnimation: [self tvtt_animationWithTranslation:-CGRectGetWidth(self.view.bounds) animationFinished:^(CAAnimation *animation, BOOL flag) {
        [wSelf.tvtt_topScreenMirrorImageView removeFromSuperlayer];
    }] forKey:nil];
    
    
    //gesutre
//    self.interactivePopGestureRecognizer.enabled = NO;
//    TVTTPanGestureRecognizer = [[UIPanGestureRecognizer alloc] init];
//    TVTTPanGestureRecognizer.delegate = self;
//    [TVTTPanGestureRecognizer addTarget:self action:@selector(handleGesture:)];
//    [self.view addGestureRecognizer:TVTTPanGestureRecognizer];
}
- (UIViewController *)tvtt_popViewControllerAnimated:(BOOL)animated{
    
    self.tvtt_bottomScreenMirrorImageView = [self.tvtt_mirrorImageViews lastObject];
    self.tvtt_bottomScreenMirrorImageView.frame = (CGRect) {
        {
            -CGRectGetWidth(self.view.bounds), CGRectGetMinY(self.view.bounds)
        },
        self.view.bounds.size
    };
    
    self.tvtt_topScreenMirrorImageView =[self tvtt_layerSnapshotWithTransform:CATransform3DIdentity];
    
    [self.view.layer addSublayer:self.tvtt_bottomScreenMirrorImageView];
    [self.view.layer addSublayer:self.tvtt_topScreenMirrorImageView];
    [self.tvtt_mirrorImageViews removeLastObject];
    
    [CATransaction flush];
    
    __weak typeof(self) wSelf = self;
    [self.tvtt_bottomScreenMirrorImageView addAnimation:[self tvtt_animationWithTranslation:CGRectGetWidth(self.view.bounds) animationFinished:^(CAAnimation *animation, BOOL flag) {
        [wSelf.tvtt_bottomScreenMirrorImageView removeFromSuperlayer];
    }] forKey:nil];
    [self.tvtt_topScreenMirrorImageView addAnimation:[self tvtt_animationWithTranslation:CGRectGetWidth(self.view.bounds) animationFinished:^(CAAnimation *animation, BOOL flag) {
        [wSelf.tvtt_topScreenMirrorImageView removeFromSuperlayer];
        [self popViewControllerAnimated:NO];
    }]forKey:nil];
    
//    self.interactivePopGestureRecognizer.enabled = YES;
//    TVTTPanGestureRecognizer.delegate = nil;
//    [TVTTPanGestureRecognizer removeTarget:self action:@selector(handleGesture:)];
//    [self.view removeGestureRecognizer:TVTTPanGestureRecognizer];
//    TVTTPanGestureRecognizer = nil;
    
    return nil;
}

#pragma mark - UINavigationBarDelegate

- (BOOL)navigationBar:(UINavigationBar *)navigationBar shouldPopItem:(UINavigationItem *)item {
    if([self.viewControllers count] < [navigationBar.items count]) {
        return YES;
    }
//    if (TVTTPanGestureRecognizer) {
        [self tvtt_popViewControllerAnimated:YES];
//    }else{
//        [self popViewControllerAnimated:YES];
//    }
    return NO;
}

#pragma mark - UIGestureRecognizerDelegate

- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer{
    TVTTTopViewControllerMirrorImageView = [self tvtt_layerSnapshotWithTransform:CATransform3DIdentity];
    return YES;
}

#pragma mark - SEL

- (void)handleGesture:(UIPanGestureRecognizer *)panGestureRecognizer{
    
    CGPoint touchPoint = [panGestureRecognizer locationInView:self.view];
    
    __weak typeof(self) wSelf = self;
    
   if (panGestureRecognizer.state == UIGestureRecognizerStateBegan){
        TVTTStartTouchPoint = touchPoint;
       
//        _isGestureMoving = TVTTStartTouchPoint.x <= TVTTTransitionMargin;
       _isGestureMoving = YES;
       TVTTTopViewControllerMirrorImageView.backgroundColor = [UIColor redColor].CGColor;
       
       if (_isGestureMoving) {
           TVTTChildViewController = [self popViewControllerAnimated:NO];
           
           TVTTBottomViewControllerMirrorImageView = [self tvtt_layerSnapshotWithTransform:CATransform3DIdentity];
           
           [self.view.layer addSublayer:TVTTBottomViewControllerMirrorImageView];
           [self.view.layer addSublayer:TVTTTopViewControllerMirrorImageView];
       }
       
    }else if (panGestureRecognizer.state == UIGestureRecognizerStateEnded){
        _isGestureMoving = NO;
        CGFloat movingDistance = touchPoint.x - TVTTStartTouchPoint.x;
        
        if (movingDistance < 0){[self tvtt_removeMirrorImageView];[self pushViewController:TVTTChildViewController animated:NO];return;}
        
        if (movingDistance >= self.view.frame.size.width/2.0) {
            [TVTTTopViewControllerMirrorImageView addAnimation:[self tvtt_animationWithTranslation: + movingDistance animationFinished:^(CAAnimation *animation, BOOL flag) {
            }]  forKey:nil];
            
        }else{
            
            [TVTTTopViewControllerMirrorImageView addAnimation:[self tvtt_animationWithTranslation: - movingDistance animationFinished:^(CAAnimation *animation, BOOL flag) {
                if (TVTTChildViewController) {
                    [wSelf pushViewController:TVTTChildViewController animated:NO];
                }
                TVTTChildViewController = nil;
                [wSelf setTvtt_animationDidFinishedBlock:nil];
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
        CGRect frame = TVTTTopViewControllerMirrorImageView.frame;
        CGFloat endX = touchPoint.x - TVTTStartTouchPoint.x;
        endX = endX < 0 ? 0 : endX;
        endX = endX > CGRectGetWidth(self.view.frame) ? CGRectGetWidth(self.view.frame):endX;
        frame.origin.x = endX;
        TVTTTopViewControllerMirrorImageView.frame = frame;
    }
}



#pragma mark - Private

- (void)tvtt_removeMirrorImageView{
    [TVTTTopViewControllerMirrorImageView removeFromSuperlayer];
    [TVTTBottomViewControllerMirrorImageView removeFromSuperlayer];
    TVTTBottomViewControllerMirrorImageView = nil;
    TVTTTopViewControllerMirrorImageView = nil;
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
- (CABasicAnimation *)tvtt_animationWithTranslation:(CGFloat)translation animationFinished:(void(^)(CAAnimation * animation, BOOL flag))finishBlock{
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"transform"];
    animation.toValue = [NSValue valueWithCATransform3D:CATransform3DTranslate(CATransform3DIdentity, translation, 0.f, 0.f)];
    CGFloat duration = TVTTTransitionSpeed * translation;
    animation.duration = duration > 0 ? duration : -duration;
    [animation tvtt_setAnimationDidFinishBlock:finishBlock];
    animation.removedOnCompletion = NO;
    animation.fillMode = kCAFillModeForwards;
//    animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut];
    return animation;
}
- (CABasicAnimation *)tvtt_animationWithTranslation:(CGFloat)translation{
    return [self tvtt_animationWithTranslation:translation animationFinished:nil];
}

@end

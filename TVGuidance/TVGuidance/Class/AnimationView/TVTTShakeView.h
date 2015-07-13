//
//  TVTTShakeView.h
//  TVGuidance
//
//  Created by lben on 15/7/13.
//  Copyright (c) 2015年 lben. All rights reserved.
//

#import <UIKit/UIKit.h>

IB_DESIGNABLE
@interface TVTTShakeView : UIView

@property (strong, nonatomic) NSDictionary *viewsByName;

// shake
- (void)addShakeAnimation;
- (void)addShakeAnimationWithCompletion:(void (^)(BOOL finished))completionBlock;
- (void)addShakeAnimationAndRemoveOnCompletion:(BOOL)removedOnCompletion;
- (void)addShakeAnimationAndRemoveOnCompletion:(BOOL)removedOnCompletion completion:(void (^)(BOOL finished))completionBlock;
- (void)addShakeAnimationWithBeginTime:(CFTimeInterval)beginTime andFillMode:(NSString *)fillMode andRemoveOnCompletion:(BOOL)removedOnCompletion completion:(void (^)(BOOL finished))completionBlock;
- (void)removeShakeAnimation;


// zoom
- (void)addZoomAnimation;
- (void)addZoomAnimationWithCompletion:(void (^)(BOOL finished))completionBlock;
- (void)addZoomAnimationAndRemoveOnCompletion:(BOOL)removedOnCompletion;
- (void)addZoomAnimationAndRemoveOnCompletion:(BOOL)removedOnCompletion completion:(void (^)(BOOL finished))completionBlock;
- (void)addZoomAnimationWithBeginTime:(CFTimeInterval)beginTime andFillMode:(NSString *)fillMode andRemoveOnCompletion:(BOOL)removedOnCompletion completion:(void (^)(BOOL finished))completionBlock;
- (void)removeZoomAnimation;


// path
- (void)addPathAnimation;
- (void)addPathAnimationWithCompletion:(void (^)(BOOL finished))completionBlock;
- (void)addPathAnimationAndRemoveOnCompletion:(BOOL)removedOnCompletion;
- (void)addPathAnimationAndRemoveOnCompletion:(BOOL)removedOnCompletion completion:(void (^)(BOOL finished))completionBlock;
- (void)addPathAnimationWithBeginTime:(CFTimeInterval)beginTime andFillMode:(NSString *)fillMode andRemoveOnCompletion:(BOOL)removedOnCompletion completion:(void (^)(BOOL finished))completionBlock;
- (void)removePathAnimation;

- (void)removeAllAnimations;
@end

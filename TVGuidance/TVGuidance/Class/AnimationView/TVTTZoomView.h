//
//  TVTTZoomView.h
//  TVGuidance
//
//  Created by lben on 15/7/13.
//  Copyright (c) 2015年 lben. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TVTTZoomView : UIView
// zoom
- (void)addZoomAnimation;
- (void)addZoomAnimationWithCompletion:(void (^)(BOOL finished))completionBlock;
- (void)addZoomAnimationAndRemoveOnCompletion:(BOOL)removedOnCompletion;
- (void)addZoomAnimationAndRemoveOnCompletion:(BOOL)removedOnCompletion completion:(void (^)(BOOL finished))completionBlock;
- (void)addZoomAnimationWithBeginTime:(CFTimeInterval)beginTime andFillMode:(NSString *)fillMode andRemoveOnCompletion:(BOOL)removedOnCompletion completion:(void (^)(BOOL finished))completionBlock;
- (void)removeZoomAnimation;
@end

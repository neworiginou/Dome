//
//  TVTTAnimationView.h
//  TVGuidance
//
//  Created by lben on 15/7/13.
//  Copyright © 2015年 lben. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TVTTAnimationView : UIView

@property (strong, nonatomic) NSDictionary *viewsByName;

@property (strong, nonatomic) NSMapTable *completionBlocksByAnimation;


- (void)addAnimation;
- (void)addAnimationWithCompletion:(void (^)(BOOL finished))completionBlock;
- (void)addAnimationAndRemoveOnCompletion:(BOOL)removedOnCompletion;
- (void)addAnimationAndRemoveOnCompletion:(BOOL)removedOnCompletion completion:(void (^)(BOOL finished))completionBlock;
- (void)addAnimationWithBeginTime:(CFTimeInterval)beginTime andFillMode:(NSString *)fillMode andRemoveOnCompletion:(BOOL)removedOnCompletion completion:(void (^)(BOOL finished))completionBlock;


@end

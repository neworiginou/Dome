//
//  TVTTAnimationView.m
//  TVGuidance
//
//  Created by lben on 15/7/13.
//  Copyright © 2015年 lben. All rights reserved.
//

#import "TVTTAnimationView.h"



@implementation TVTTAnimationView


- (void)addAnimation
{
    [self addAnimationWithBeginTime:0 andFillMode:kCAFillModeBoth andRemoveOnCompletion:NO completion:NULL];
}

- (void)addAnimationWithCompletion:(void (^)(BOOL finished))completionBlock
{
    [self addAnimationWithBeginTime:0 andFillMode:kCAFillModeBoth andRemoveOnCompletion:NO completion:completionBlock];
}

- (void)addAnimationAndRemoveOnCompletion:(BOOL)removedOnCompletion
{
    [self addAnimationWithBeginTime:0 andFillMode:removedOnCompletion ? kCAFillModeRemoved : kCAFillModeBoth andRemoveOnCompletion:removedOnCompletion completion:NULL];
}

- (void)addAnimationAndRemoveOnCompletion:(BOOL)removedOnCompletion completion:(void (^)(BOOL finished))completionBlock
{
    [self addAnimationWithBeginTime:0 andFillMode:removedOnCompletion ? kCAFillModeRemoved : kCAFillModeBoth andRemoveOnCompletion:removedOnCompletion completion:completionBlock];
}

@end

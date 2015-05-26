//
//  CABasicAnimation+TVTTAnimationDelegateBlock.h
//  DynamicNavigationBarDome
//
//  Created by lben on 15/5/26.
//  Copyright (c) 2015年 lben. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>


@interface CABasicAnimation (TVTTAnimationDelegateBlock)


- (void)tvtt_setAnimationDidFinishBlock:(void (^)(CAAnimation *, BOOL))ttAnimationDidFinishBlock;
- (void)tvtt_setAnimationDidStart:(void (^)(CAAnimation *))ttAnimationDidStart;
@end

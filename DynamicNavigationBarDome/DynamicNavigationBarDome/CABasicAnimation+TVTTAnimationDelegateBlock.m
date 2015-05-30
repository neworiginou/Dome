//
//  CABasicAnimation+TVTTAnimationDelegateBlock.m
//  DynamicNavigationBarDome
//
//  Created by lben on 15/5/26.
//  Copyright (c) 2015年 lben. All rights reserved.
//

#import "CABasicAnimation+TVTTAnimationDelegateBlock.h"
#import <objc/runtime.h>

@interface CABasicAnimation()
@property (copy, nonatomic) void(^ttAnimationDidFinishBlock)(CAAnimation * anim, BOOL flag);
@property (copy, nonatomic) void(^ttAnimationDidStart)(CAAnimation * anim);
@end

@implementation CABasicAnimation (TVTTAnimationDelegateBlock)

- (void)tvtt_setAnimationDidFinishBlock:(void (^)(CAAnimation *, BOOL))ttAnimationDidFinishBlock{
    if (!self.delegate) self.delegate = self;
    objc_setAssociatedObject(self, "ttAnimationDidFinishBlock", ttAnimationDidFinishBlock, OBJC_ASSOCIATION_COPY_NONATOMIC);
}
- (void)tvtt_setAnimationDidStart:(void (^)(CAAnimation *))ttAnimationDidStart{
    if (!self.delegate) self.delegate = self;
    objc_setAssociatedObject(self, "ttAnimationDidStart", ttAnimationDidStart, OBJC_ASSOCIATION_COPY_NONATOMIC);
}
- (void (^)(CAAnimation *))ttAnimationDidStart{
    return objc_getAssociatedObject(self, "ttAnimationDidStart");
}
- (void (^)(CAAnimation *, BOOL))ttAnimationDidFinishBlock{
    return objc_getAssociatedObject(self, "ttAnimationDidFinishBlock");
}

- (void)animationDidStart:(CAAnimation *)anim{
    if (self.ttAnimationDidStart) {
        self.ttAnimationDidStart(anim);
    }
}
- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag{
    if (self.ttAnimationDidFinishBlock) {
        self.ttAnimationDidFinishBlock(anim,flag);
    }
}

@end

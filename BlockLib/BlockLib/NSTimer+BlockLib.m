//
//  NSTimer+BlockLib.m
//  BlockLib
//
//  Created by lbencs on 15/5/30.
//  Copyright (c) 2015年 lbencs. All rights reserved.
//

#import "NSTimer+BlockLib.h"


static void(^ActionBlock)();


@implementation NSTimer (BlockLib)


+ (NSTimer *)bl_scheduledTimerWithTimeInterval:(NSTimeInterval)ti userInfo:(id)userInfo repeats:(BOOL)yesOrNo action:(void(^)())actionBlock{
    NSTimer * timer = [self scheduledTimerWithTimeInterval:ti target:self selector:@selector(action) userInfo:userInfo repeats:yesOrNo];
    ActionBlock = actionBlock;
    return timer;
}

+ (void)action{
    if (ActionBlock) {
        ActionBlock();
    }
}



@end

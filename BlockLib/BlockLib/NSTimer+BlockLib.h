//
//  NSTimer+BlockLib.h
//  BlockLib
//
//  Created by lbencs on 15/5/30.
//  Copyright (c) 2015年 lbencs. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSTimer (BlockLib)
+ (NSTimer *)bl_scheduledTimerWithTimeInterval:(NSTimeInterval)ti userInfo:(id)userInfo repeats:(BOOL)yesOrNo action:(void(^)())actionBlock;
@end

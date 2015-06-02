//
//  UIControl+BlockLib.h
//  BlockLib
//
//  Created by lben on 15/6/1.
//  Copyright (c) 2015年 lbencs. All rights reserved.


//
//  copy from " 张 玺 on 12-9-10"
//  https://github.com/zhangxigithub/BlockUI

#import <UIKit/UIKit.h>

@interface UIControl (BlockLib)

- (void)bl_handleControlEvent:(UIControlEvents)controlEvent action:(void(^)(id sender))actionBlock;

- (void)bl_removeHandleControlEvent:(UIControlEvents)controlEvent action:(void(^)(id sender))actionBlock;
@end

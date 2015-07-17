//
//  TVGuidanceAnimationPageViewController.h
//  TVGuidance
//
//  Created by lben on 15/7/13.
//  Copyright (c) 2015年 lben. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TVGuidanceAnimationPageViewController : UIViewController
/*
 * 需要动画效果的UI元素
 */
@property (nonatomic, assign, readonly, getter=isAnimationed)  BOOL animationed;

- (void)startAnimation;

@end

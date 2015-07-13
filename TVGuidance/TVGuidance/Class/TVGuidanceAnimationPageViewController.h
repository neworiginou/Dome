//
//  TVGuidanceAnimationPageViewController.h
//  TVGuidance
//
//  Created by lben on 15/7/13.
//  Copyright (c) 2015年 lben. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, TVGuidanceAnimationType) {
    TVGuidanceAnimationTypePath,
};


@interface TVGuidanceAnimationPageViewController : UIViewController

/*
 * 需要动画效果的UI元素
 */
@property (nonatomic, strong) NSArray * animatinItems;


- (void)startAnimationWithType:(TVGuidanceAnimationType)animationType;

@end

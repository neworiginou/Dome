//
//  TVGuidancePageViewController.h
//  TVGuidance
//
//  Created by lben on 15/6/15.
//  Copyright (c) 2015年 lben. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "TVGuidancePage.h"

@interface TVGuidancePageViewController : UIViewController
@property (assign, nonatomic) NSInteger index;
@property (assign, nonatomic) TVGuidancePageType pageType;
- (instancetype)initWithIndex:(NSInteger)index pageType:(TVGuidancePageType)pageType;
- (void)updatePageWithIndex:(NSInteger)index pageType:(TVGuidancePageType)pageType;
- (void)showAnimationWithDuration:(CGFloat)duration;
- (void)hiddenAnimationViews;
@end

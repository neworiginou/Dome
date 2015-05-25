//
//  UINavigationController+TVTTNavigationControllerTransform.h
//  DynamicNavigationBarDome
//
//  Created by lben on 15/5/25.
//  Copyright (c) 2015年 lben. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface UINavigationController (TVTTNavigationControllerTransform)
- (void)tvtt_pushViewController:(UIViewController *)viewController animated:(BOOL)animated;
- (UIViewController *)tvtt_popViewControllerAnimated:(BOOL)animated;
@end

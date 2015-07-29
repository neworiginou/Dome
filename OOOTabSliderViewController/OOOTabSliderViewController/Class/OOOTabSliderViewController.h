//
//  OOOTabSliderViewController.h
//  OOOTabSliderViewController
//
//  Created by lben on 15/7/29.
//  Copyright (c) 2015年 lben. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface OOOTabSliderViewController : NSObject
@property (nonatomic, strong) NSArray *subViewController; /**> tab的Viewcontrollers */

- (void)addParentController:(UIViewController *)viewController;
@end

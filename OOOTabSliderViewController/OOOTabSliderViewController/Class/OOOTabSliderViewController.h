//
//  OOOTabSliderViewController.h
//  OOOTabSliderViewController
//
//  Created by lben on 15/7/29.
//  Copyright (c) 2015年 lben. All rights reserved.
//

#import <UIKit/UIKit.h>

@class OOOTabSliderViewController;

@protocol OOOTabSliderViewControllerDataSource <NSObject>
@required
- (NSArray *)sliderViewControllerSubViewControllers:(OOOTabSliderViewController *)viewController;
@end

@interface OOOTabSliderViewController : UIViewController <OOOTabSliderViewControllerDataSource>
@property (nonatomic, strong) NSArray *subViewController; /**> tab的Viewcontrollers */

@property (nonatomic, strong) id <OOOTabSliderViewControllerDataSource>dataSource;
@end

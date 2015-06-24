//
//  TVGuidanceViewController.h
//  TVGuidance
//
//  Created by lben on 15/6/12.
//  Copyright (c) 2015年 lben. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, TVGuidanceStyle) {
    TVGuidanceStyleLiner = 0,
    TVGuidanceStyleCircle,
};

@interface TVGuidanceViewController : UIViewController
@property (assign, nonatomic) TVGuidanceStyle guidanceStyle;
- (instancetype)initWithItems:(NSArray *)items;
@end

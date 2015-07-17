//
//  UIViewController+BaseView.m
//  TVGuidance
//
//  Created by lbencs on 15/7/15.
//  Copyright © 2015年 lben. All rights reserved.
//

#import "UIViewController+BaseView.h"

@implementation UIViewController (BaseView)
+ (instancetype)tvtt_nibViewController{
    return [[self alloc] initWithNibName:NSStringFromClass(self) bundle:nil];
}
@end

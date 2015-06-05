//
//  UIAlertView+BlockLib.h
//  BlockLib
//
//  Created by lben on 15/6/1.
//  Copyright (c) 2015年 lbencs. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIAlertView (BlockLib)

- (instancetype)initWithTitle:(NSString *)title message:(NSString *)message clickedButtonAtIndex:(void(^)(UIAlertView *alertView, NSInteger buttonIndex))atindexBlock cancelButtonTitle:(NSString *)cancelButtonTitle otherButtonTitles:(NSString *)otherButtonTitles, ... NS_REQUIRES_NIL_TERMINATION NS_EXTENSION_UNAVAILABLE_IOS("Use UIAlertController instead.");

@end

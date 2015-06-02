//
//  UIActionSheet+BlockLib.h
//  BlockLib
//
//  Created by lben on 15/6/1.
//  Copyright (c) 2015年 lbencs. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIActionSheet (BlockLib)
- (instancetype)initWithTitle:(NSString *)title clickedButtonAtIndex:(void(^)(UIActionSheet * actionSheet, NSInteger buttonIndex))actionBlock cancelButtonTitle:(NSString *)cancelButtonTitle destructiveButtonTitle:(NSString *)destructiveButtonTitle otherButtonTitles:(NSString *)otherButtonTitles, ... NS_REQUIRES_NIL_TERMINATION NS_EXTENSION_UNAVAILABLE_IOS("Use UIAlertController instead.");
@end

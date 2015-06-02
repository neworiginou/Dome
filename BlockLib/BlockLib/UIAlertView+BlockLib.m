//
//  UIAlertView+BlockLib.m
//  BlockLib
//
//  Created by lben on 15/6/1.
//  Copyright (c) 2015年 lbencs. All rights reserved.
//

#import "UIAlertView+BlockLib.h"
#import <objc/runtime.h>

@interface UIAlertView ()<UIAlertViewDelegate>

@end

@implementation UIAlertView (BlockLib)

- (instancetype)initWithTitle:(NSString *)title message:(NSString *)message clickedButtonAtIndex:(void(^)(UIAlertView *alertView, NSInteger buttonIndex))actionBlock cancelButtonTitle:(NSString *)cancelButtonTitle otherButtonTitles:(NSString *)otherButtonTitles, ... NS_REQUIRES_NIL_TERMINATION NS_EXTENSION_UNAVAILABLE_IOS("Use UIAlertController instead."){
    
    self = [self initWithTitle:title message:message delegate:self cancelButtonTitle:cancelButtonTitle otherButtonTitles:otherButtonTitles, nil];
    
    if (self) {
        
        objc_setAssociatedObject(self, "kClickedButtonActionKey", actionBlock, OBJC_ASSOCIATION_COPY_NONATOMIC);
        
        if (otherButtonTitles) {
            va_list args;
            va_start(args, otherButtonTitles);
            {
                NSString * buttonTitle = nil;
                while ((buttonTitle = va_arg(args, NSString*))) {
                    [self addButtonWithTitle:buttonTitle];
                }
            }
            va_end(args);
        }
    }
    
    return self;
}

#pragma mark - UIAlertViewDelegate

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    void(^actionBlock)(UIAlertView *alertView, NSInteger buttonIndex) = objc_getAssociatedObject(self, "kClickedButtonActionKey");
    if (actionBlock) actionBlock(alertView, buttonIndex);
}

@end

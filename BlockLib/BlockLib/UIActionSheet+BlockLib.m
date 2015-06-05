//
//  UIActionSheet+BlockLib.m
//  BlockLib
//
//  Created by lben on 15/6/1.
//  Copyright (c) 2015年 lbencs. All rights reserved.
//

#import "UIActionSheet+BlockLib.h"
#import <objc/runtime.h>

@interface UIActionSheet ()<UIActionSheetDelegate>

@end

@implementation UIActionSheet (BlockLib)

- (instancetype)initWithTitle:(NSString *)title clickedButtonAtIndex:(void (^)(UIActionSheet *, NSInteger))actionBlock cancelButtonTitle:(NSString *)cancelButtonTitle destructiveButtonTitle:(NSString *)destructiveButtonTitle otherButtonTitles:(NSString *)otherButtonTitles, ...{
    
    self = [self initWithTitle:title delegate:self cancelButtonTitle:cancelButtonTitle destructiveButtonTitle:destructiveButtonTitle otherButtonTitles:otherButtonTitles, nil];
    if (self) {
        objc_setAssociatedObject(self, "kActionSheetViewActionBlockKey", actionBlock, OBJC_ASSOCIATION_COPY_NONATOMIC);
        if (otherButtonTitles) {
            va_list args;
            va_start(args, otherButtonTitles);
            {
                NSString * buttonTitle = nil;
                while ((buttonTitle = va_arg(args, NSString *))) {
                    [self addButtonWithTitle:buttonTitle];
                }
            }
            va_end(args);
        }
    }
    return self;
}

#pragma mark - UIActionSheetDelegate
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex{
    void (^actionBlock)(UIActionSheet *, NSInteger) = objc_getAssociatedObject(self, "kActionSheetViewActionBlockKey");
    if (actionBlock) actionBlock(actionSheet,buttonIndex);
}


@end

//
//  UIView+Constraints.m
//  TVGuidance
//
//  Created by lben on 15/7/13.
//  Copyright © 2015年 lben. All rights reserved.
//

#import "UIView+Constraints.h"

@implementation UIView (Constraints)

- (NSLayoutConstraint *)tvtt_leftConstraint{
   __block NSLayoutConstraint * leftConstraint = nil;
    [self.constraints enumerateObjectsUsingBlock:^(__kindof NSLayoutConstraint * __nonnull obj, NSUInteger idx, BOOL * __nonnull stop) {
        if ((obj.firstItem == self && obj.firstAttribute == NSLayoutAttributeLeft) || (obj.secondItem == self && obj.secondAttribute == NSLayoutAttributeLeft)) {
            * stop = YES;
            leftConstraint = obj;
        }
    }];
    return leftConstraint;
}
- (NSLayoutConstraint *)tvtt_constraintOfAttributeCenterX{
    __block NSLayoutConstraint * constraintOfAttributeCenterX = nil;
    [self.constraints enumerateObjectsUsingBlock:^(__kindof NSLayoutConstraint * __nonnull obj, NSUInteger idx, BOOL * __nonnull stop) {
        if ((obj.firstItem == self && obj.secondAttribute == NSLayoutAttributeCenterX) || (obj.secondItem == self && obj.secondAttribute == NSLayoutAttributeCenterX)) {
            * stop = YES;
            constraintOfAttributeCenterX = obj;
        }
    }];
    return constraintOfAttributeCenterX;
}
- (NSLayoutConstraint *)tvtt_constraintOfAttributeCenterY{
    __block NSLayoutConstraint * constraintOfAttributeCenterY = nil;
    [self.constraints enumerateObjectsUsingBlock:^(__kindof NSLayoutConstraint * __nonnull obj, NSUInteger idx, BOOL * __nonnull stop) {
        if ((obj.firstItem == self && obj.secondAttribute == NSLayoutAttributeCenterY) || (obj.secondItem == self && obj.secondAttribute == NSLayoutAttributeCenterY)) {
            * stop = YES;
            constraintOfAttributeCenterY = obj;
        }
    }];
    return constraintOfAttributeCenterY;
}
@end

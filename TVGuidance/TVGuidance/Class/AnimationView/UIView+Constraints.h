//
//  UIView+Constraints.h
//  TVGuidance
//
//  Created by lben on 15/7/13.
//  Copyright © 2015年 lben. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (Constraints)
- (NSLayoutConstraint *)tvtt_leftConstraint;
- (NSLayoutConstraint *)tvtt_rightConstraint;
- (NSLayoutConstraint *)tvtt_topConstraint;
- (NSLayoutConstraint *)tvtt_bottomConstraint;
- (NSLayoutConstraint *)tvtt_tringConstraint;
- (NSLayoutConstraint *)tvtt_lidingConstraint;
- (NSLayoutConstraint *)tvtt_constraintOfAttributeCenterX;
- (NSLayoutConstraint *)tvtt_constraintOfAttributeCenterY;
@end

//
//  UIButton+BaseView.m
//  TVGuidance
//
//  Created by lbencs on 15/7/15.
//  Copyright © 2015年 lben. All rights reserved.
//

#import "UIButton+BaseView.h"

@implementation UIButton (BaseView)
@dynamic tvtt_nomalImageName;
@dynamic tvtt_pressImageName;

- (void)setTvtt_nomalImageName:(NSString *)tvtt_nomalImageName{
    [self setImage:[UIImage imageNamed:tvtt_nomalImageName] forState:UIControlStateNormal];
}
- (void)setTvtt_pressImageName:(NSString *)tvtt_pressImageName{
    [self setImage:[UIImage imageNamed:tvtt_pressImageName] forState:UIControlStateHighlighted];
}
@end

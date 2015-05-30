//
//  UIButton+TVTTButtonBlock.h
//  iOS6MasonryDome
//
//  Created by lben on 15/5/28.
//  Copyright (c) 2015年 lben. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIButton (TVTTButtonBlock)
- (void)tvtt_buttonActionBlock:(void(^)(UIButton * button))btnBlock forControlEvents:(UIControlEvents)controlEvent;
@end

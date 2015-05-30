//
//  TVTTProgressView.h
//  CoreGraphicsDome
//
//  Created by lben on 15/5/29.
//  Copyright (c) 2015年 lben. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TVTTProgressView : UIView

@property (assign, nonatomic) CGFloat progress;
@property (assign, nonatomic) CGFloat progressWidth;

@property (strong, nonatomic) NSString * displayText;

@property (strong, nonatomic) UIFont * textFont;

@property (strong, nonatomic) UIColor * progressColor;
@end

//
//  TVTTProgressView.h
//  CoreGraphicsDome
//
//  Created by lben on 15/5/29.
//  Copyright (c) 2015年 lben. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, TVTTProgressViewStyle) {
    TVTTProgressViewStyleProgress = 1,
    TVTTProgressViewStyleProgressWillStart,
    TVTTProgressViewStyleProgressWasEnd,
};


@interface TVTTProgressView : UIView

@property (assign, nonatomic) CGFloat progress;
@property (assign, nonatomic) CGFloat progressWidth;

@property (strong, nonatomic) NSString * displayText;

@property (strong, nonatomic) UIFont * textFont;

@property (strong, nonatomic) UIColor * progressColor;

@property (assign, nonatomic) TVTTProgressViewStyle * viewStyle;
@end

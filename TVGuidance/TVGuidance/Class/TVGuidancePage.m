//
//  TVGuidancePage.m
//  TVGuidance
//
//  Created by lben on 15/6/12.
//  Copyright (c) 2015年 lben. All rights reserved.
//

#import "TVGuidancePage.h"

@interface TVGuidancePage ()
@end

@implementation TVGuidancePage

- (void)initWithMessage:(NSString *)message pictureName:(NSString *)picName duation:(CGFloat)duation animationType:(TVGuidancePageAnimationType)animationType{
}
- (TVGuidancePage *)initWithBackgroundPictureName:(NSString *)picName duation:(CGFloat)duation centerImageName:(NSString *)centerImageName animationType:(TVGuidancePageType)animationType{
    return [self initWithBackgroundPictureName:picName duation:duation centerImageName:centerImageName bottomImageName:nil animationType:animationType];
}
- (TVGuidancePage *)initWithBackgroundPictureName:(NSString *)picName duation:(CGFloat)duation centerImageName:(NSString *)centerImageName bottomImageName:(NSString *)bottomImageName animationType:(TVGuidancePageType)animationType{
    self = [super init];
    if (self) {
        _backgroundImageName = picName;
        _centerImageName = centerImageName;
        _bottomImageName = bottomImageName;
        _pageType = animationType;
    }
    return self;
}
@end

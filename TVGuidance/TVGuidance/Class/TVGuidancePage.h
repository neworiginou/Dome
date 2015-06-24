//
//  TVGuidancePage.h
//  TVGuidance
//
//  Created by lben on 15/6/12.
//  Copyright (c) 2015年 lben. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, TVGuidancePageAnimationType) {
    TVGuidancePageAnimationType_1,
};

typedef NS_ENUM(NSInteger, TVGuidancePageType) {
    TVGuidancePageTypeLaunchHome,
    TVGuidancePageTypeLaunch,
};

@interface TVGuidancePage : NSObject

@property (readonly, copy, nonatomic) NSString * backgroundImageName;
@property (readonly, copy, nonatomic) NSString * centerImageName;
@property (readonly, copy, nonatomic) NSString * bottomImageName;
@property (readonly, assign, nonatomic) TVGuidancePageType pageType;

- (void)initWithMessage:(NSString *)message pictureName:(NSString *)picName duation:(CGFloat)duation animationType:(TVGuidancePageAnimationType)animationType;

- (TVGuidancePage *)initWithBackgroundPictureName:(NSString *)picName duation:(CGFloat)duation centerImageName:(NSString*)centerImageName animationType:(TVGuidancePageType)animationType;

- (TVGuidancePage *)initWithBackgroundPictureName:(NSString *)picName duation:(CGFloat)duation centerImageName:(NSString *)centerImageName bottomImageName:(NSString *)bottomImageName animationType:(TVGuidancePageType)animationType;
@end

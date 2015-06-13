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


@interface TVGuidancePage : NSObject


- (void)initWithMessage:(NSString *)message pictureName:(NSString *)picName duation:(CGFloat)duation animationType:(TVGuidancePageAnimationType)animationType;

- (TVGuidancePage *)initWithBackgroundPictureName:(NSString *)picName duation:(CGFloat)duation centerImageName:(NSString*)centerImageName animationType:(TVGuidancePageAnimationType)animationType;

- (TVGuidancePage *)initWithBackgroundPictureName:(NSString *)picName duation:(CGFloat)duation centerImageName:(NSString *)centerImageName bottomImageName:(NSString *)bottomImageName animationType:(TVGuidancePageAnimationType)animationType;
@end

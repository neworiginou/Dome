//
//  UIView+TVTTDrawTools.h
//  CoreGraphicsDome
//
//  Created by lben on 15/5/29.
//  Copyright (c) 2015年 lben. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (TVTTDrawTools)


- (void)drawCircleAtPoint:(CGPoint)point radius:(CGFloat)radius startAngle:(CGFloat)startAngle endAngle:(CGFloat)endAngle bgColor:(CGColorRef)baColor clockWise:(int)clockwise;
@end

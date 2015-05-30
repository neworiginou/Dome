//
//  UIView+TVTTDrawTools.m
//  CoreGraphicsDome
//
//  Created by lben on 15/5/29.
//  Copyright (c) 2015年 lben. All rights reserved.
//

#import "UIView+TVTTDrawTools.h"

@implementation UIView (TVTTDrawTools)

- (void)drawCircleAtPoint:(CGPoint)point radius:(CGFloat)radius startAngle:(CGFloat)startAngle endAngle:(CGFloat)endAngle bgColor:(CGColorRef)baColor clockWise:(int)clockwise{
    CGContextRef ctx = UIGraphicsGetCurrentContext();
//    CGContextSetFillColorWithColor(ctx, [UIColor blueColor].CGColor);
    CGContextSetStrokeColorWithColor(ctx, baColor);
    CGContextSetLineWidth(ctx, 10);
    CGContextAddArc(ctx, point.x, point.y, radius, startAngle, endAngle, clockwise);
//    CGContextFillPath(ctx);
    CGContextDrawPath(ctx, kCGPathStroke);
}
@end

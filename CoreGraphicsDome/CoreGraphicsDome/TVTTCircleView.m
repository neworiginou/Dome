//
//  TVTTCircleView.m
//  CoreGraphicsDome
//
//  Created by lben on 15/5/25.
//  Copyright (c) 2015年 lben. All rights reserved.
//

#import "TVTTCircleView.h"

@implementation TVTTCircleView

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    [super drawRect:rect];
    
    CGRect drawRect = rect;
    
    [self drawRectangle:rect color:[UIColor blueColor].CGColor];
    
    drawRect = (CGRect){rect.origin.x + 5,rect.origin.y + 15,rect.size.width - 10,rect.size.height - 20};
    [self drawEllipse:drawRect];
    
    CGFloat x = drawRect.size.width/2.0 + 5;
    CGFloat y = (drawRect.size.height - 20)/5.0 + 30;
    
    [self drawCircleAtX:x - 15 Y:y];
    
    [self drawCircleAtX:x + 15 Y:y];
    
    [self drawTriangleAtX:x Y:y + 10];
    
    CGRect mRect = (CGRect){x - 15,y + 35,30,10};
    [self drawRectangle:mRect color:[UIColor blackColor].CGColor];
    
    [self drawCurveAtX:rect.size.width/2.0 Y:20];
    
}

- (void)drawRectangle:(CGRect)rect color:(CGColorRef)color{
    CGContextRef bgCtx =  UIGraphicsGetCurrentContext();
    CGContextAddRect(bgCtx, rect);
    CGContextSetFillColorWithColor(bgCtx, color);
    CGContextFillPath(bgCtx);
}

- (void)drawEllipse:(CGRect)rect{
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    CGContextAddEllipseInRect(ctx, rect);
    CGContextSetFillColorWithColor(ctx, [UIColor orangeColor].CGColor);
    CGContextFillPath(ctx);
}

- (void)drawCircleAtX:(CGFloat)x Y:(CGFloat)y{
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(ctx, [UIColor blackColor].CGColor);
    CGContextAddArc(ctx, x, y, 8, 0, 2*M_PI, 1);
    CGContextFillPath(ctx);
}
- (void)drawTriangleAtX:(CGFloat)x Y:(CGFloat)y{
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    CGContextBeginPath(ctx);
    CGContextMoveToPoint(ctx, x, y);
    CGContextAddLineToPoint(ctx, x - 10, y + 20);
    CGContextAddLineToPoint(ctx, x + 10, y + 20);
    CGContextClosePath(ctx);
    CGContextSetFillColorWithColor(ctx, [UIColor blackColor].CGColor);
    CGContextFillPath(ctx);
}

- (void)drawCurveAtX:(CGFloat)x Y:(CGFloat)y{
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    CGContextBeginPath(ctx);
    CGContextMoveToPoint(ctx, x, y);
    /**
     *  @brief 在指定点追加二次贝塞尔曲线，通过控制点和结束点指定曲线。
     *         关于曲线的点的控制见下图说明，图片来源苹果官方网站。参数按顺序说明
     *  @param c   当前图形
     *  @param cpx 曲线控制点的x坐标
     *  @param cpy 曲线控制点的y坐标
     *  @param x   指定点的x坐标值
     *  @param y   指定点的y坐标值
     */
    CGContextAddQuadCurveToPoint(ctx, x+10, y - 10, x - 20, y-20);
    CGContextSetLineWidth(ctx, 10);
    CGContextSetStrokeColorWithColor(ctx, [UIColor brownColor].CGColor);
    CGContextStrokePath(ctx);
}
@end

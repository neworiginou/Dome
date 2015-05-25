//
//  TVTTAffineTransformView.m
//  CoreGraphicsDome
//
//  Created by lben on 15/5/25.
//  Copyright (c) 2015年 lben. All rights reserved.
//

#import "TVTTAffineTransformView.h"

@implementation TVTTAffineTransformView


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    UIImage * image = [UIImage imageNamed:@"QQ20150513-1"];
    
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    
    CGContextSaveGState(ctx);
    CGContextTranslateCTM(ctx, 0, rect.size.height);
    CGContextScaleCTM(ctx, 1.0f, -1.0f);
    CGContextTranslateCTM(ctx, 0, 0);
    
    UIGraphicsBeginImageContext(rect.size);

    [image drawInRect:CGRectMake(0, 0, rect.size.width, rect.size.height)];
    CGImageRef cgImage = image.CGImage;
    
    CGContextDrawImage(ctx, CGRectMake(0, 0, rect.size.width, rect.size.height), cgImage);
    
    UIImage * _newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
}

@end

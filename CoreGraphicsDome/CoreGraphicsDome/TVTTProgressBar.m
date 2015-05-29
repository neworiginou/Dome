//
//  TVTTProgressBar.m
//  CoreGraphicsDome
//
//  Created by lben on 15/5/29.
//  Copyright (c) 2015年 lben. All rights reserved.
//

#import "TVTTProgressBar.h"
#import "UIView+TVTTDrawTools.h"

@interface TVTTProgressBar ()

@end

@implementation TVTTProgressBar



// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.

///  异步调用的两个函
//- (void)setNeedsDisplay{   调用  drawRect 方法       绘画
//
//}
- (void)drawRect:(CGRect)rect {
    // Drawing code
    
    [self drawBackgroundColor:[UIColor whiteColor].CGColor rect:rect];
    
    CGRect circleProgressRect = UIEdgeInsetsInsetRect(rect, UIEdgeInsetsMake(10, 10,10, 10));
    [self drawCircleProgressWithBackgroundColor:[UIColor lightGrayColor].CGColor displayColor:[UIColor blueColor].CGColor drawRect:circleProgressRect width:5 progress:0.7];
    CGPoint centerPoint = CGPointMake(rect.origin.x + (rect.size.width / 2.0), rect.origin.y + (rect.size.height / 2.0));
    [self drawCircleProgressWithBackgroundColor:[UIColor lightGrayColor].CGColor displayColor:[UIColor blueColor].CGColor centerPoint:centerPoint radius:45 width:5 progress:_progress];
    
    
    CGRect textRect = UIEdgeInsetsInsetRect(rect, UIEdgeInsetsMake(33, 20,33, 20));
    NSString * text = @"1000\n体验金";
    UIFont * font = [UIFont systemFontOfSize:14];
    NSMutableParagraphStyle *style = [[NSParagraphStyle defaultParagraphStyle] mutableCopy];
    [style setAlignment:NSTextAlignmentCenter];
    NSDictionary * attributes = @{NSFontAttributeName:font,
                                  NSParagraphStyleAttributeName:style};
    CGSize  textSize = [text sizeWithAttributes:attributes];
    textRect = (CGRect){(textRect.size.width - textSize.width)/2.0 + textRect.origin.x, (textRect.size.height - textSize.height)/2 + textRect.origin.y,textSize};
   
    
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(ctx, [UIColor yellowColor].CGColor);
    CGContextAddRect(ctx, textRect);
    CGContextFillPath(ctx);
    
    //设置画笔线条粗细
    CGContextSetLineWidth(ctx, 1.0);
    //设置矩形填充颜色：红色
    CGContextSetRGBFillColor (ctx, 1.0, 0.0, 0.0, 1.0);
    
    if ([text respondsToSelector:@selector(drawInRect:withAttributes:)])
        [text drawInRect:textRect withAttributes:attributes];
    else
        [text drawInRect:textRect withFont:nil lineBreakMode:UILineBreakModeClip alignment:UITextAlignmentCenter];
    
    
//    [text drawAtPoint:centerPoint withAttributes:@{}];
    
//    text drawWithRect:textRect options:NSStringDrawingTruncatesLastVisibleLine attributes:@{} context:nil
  
}

///

- (void)setProgress:(CGFloat)progress{
    _progress = progress;
    [UIView animateWithDuration:2.0 animations:^{
        [self setNeedsDisplay];
    }];
}



//通过 调用 UI控件的 setNeedsLayout方法，调用layoutSubviews
//- (void)setNeedsLayout{   调用  layoutSubviews 方法     显示
//    
//}

/*
 addSubview 被调用时：target view（一定会），以及被添加的 view（第一次调用会）
 更改 UIView 的 frame 时：被更改 frame 的 view（frame 与之前不同时）
 对于 UIScrollView 而言，滚动式：scroll view
 设备的 orientation 改变时：涉及改变的 UIViewController 的 root view
 使用 CGAffineTransformScale 改变 view 的 transform 属性时，view 的 superview：被改变的 view
 第一次调用 addSubview 的时候，target view 和被添加到 target view 的 view 的 layoutSubviews 方法会被调用。在已经添加完毕后，若 target view 已经拥有该被添加 view，则只有 target view 的 layoutSubviews 方法会被调用。“and all the subviews of the target”这句话是错误的。
 只有 UIView 处于 key window 的 UIView 树中时，该 UIView 的 layoutSubviews 方法才有可能被调用。不在树中的不会被调用。这也是为什么 Stackoverflow 上的讨论中这个答案的第二点会被提出。
 */
- (void)layoutSubviews{
    NSLog(@"J");
}


//- (void)didMoveToSuperview{
//    
//}
//- (void)didMoveToWindow{
//    
//}
//- (void)didAddSubview:(UIView *)subview{
//    
//}





//- (void)layoutSublayersOfLayer:(CALayer *)layer{
//    
//}





- (CGSize)textSize:(NSString *)text font:(UIFont *)font{
//    if ([text respondsToSelector:@selector(sizeWithAttributes:)]) {
//        return [text sizeWithAttributes:@{}];
//    }else
    return [text sizeWithAttributes:nil];
        return [text sizeWithFont:font];
}

- (void)drawCircleProgressWithBackgroundColor:(CGColorRef)bkColorRef displayColor:(CGColorRef)disColorRef centerPoint:(CGPoint)cPoint radius:(CGFloat)radius width:(CGFloat)width progress:(CGFloat)progress{
    [self drawCircleAtPoint:cPoint radius:radius startAngle:.0 endAngle:M_PI*2 bgColor:bkColorRef clockWise:1];
    [UIView animateWithDuration:1.5 animations:^{
        [self drawCircleAtPoint:cPoint radius:radius startAngle:.0 endAngle:M_PI*2*progress bgColor:disColorRef clockWise:1];
    }];
}
- (void)drawCircleProgressWithBackgroundColor:(CGColorRef)bkColorRef displayColor:(CGColorRef)disColorRef drawRect:(CGRect)rect width:(CGFloat)width progress:(CGFloat)progress{
}

- (void)drawBackgroundColor:(CGColorRef )color rect:(CGRect)rect{
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    CGContextAddRect(ctx, rect);
    CGContextSetFillColorWithColor(ctx, color);
    CGContextFillPath(ctx);
}

@end

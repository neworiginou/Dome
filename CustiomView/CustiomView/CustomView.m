//
//  CustomView.m
//  CustiomView
//
//  Created by lbencs on 15/4/17.
//  Copyright (c) 2015年 lbencs. All rights reserved.
//

#import "CustomView.h"

int curX;
int curY;

@implementation CustomView

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder{
    self = [super initWithCoder:aDecoder];
    if (self) {
        
    }
    return self;
}

- (void)awakeFromNib{
    
}

- (void)drawRect:(CGRect)rect {
    // 获取绘图上下文
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    // 设置填充颜色
    CGContextSetFillColorWithColor(ctx, [[UIColor redColor] CGColor]);
    // 以触碰点为圆心，绘制一个圆形
    CGContextFillEllipseInRect(ctx, CGRectMake(curX - 10, curY - 10, 20, 20));
}
- (void)setFrame:(CGRect)frame{
    
}

- (void)layoutSubviews{
    
}

- (void)didAddSubview:(UIView *)subview{
    
}
- (void)willRemoveSubview:(UIView *)subview{
    
}
- (void)willMoveToSuperview:(UIView *)newSuperview{
    
}
- (void)didMoveToSuperview{
    
}
- (void)willMoveToWindow:(UIWindow *)newWindow{
    
}
- (void)didMoveToWindow{
    
}
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    
}
- (void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event{
    
}
- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event{
    
}
- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event{
    // 获取触碰事件的UITouch事件
    UITouch *touch = [touches anyObject];
    // 得到触碰事件在当前组件上的触碰点
    CGPoint lastTouch = [touch locationInView:self];
    // 获取触碰点的坐标
    curX = lastTouch.x;
    curY = lastTouch.y;
    // 通知该组件重绘
    [self setNeedsDisplay];
}

@end

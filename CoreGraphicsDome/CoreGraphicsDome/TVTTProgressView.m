//
//  TVTTProgressView.m
//  CoreGraphicsDome
//
//  Created by lben on 15/5/29.
//  Copyright (c) 2015年 lben. All rights reserved.
//

#import "TVTTProgressView.h"


@interface TVTTProgressView (){
    CAShapeLayer *_testLayer;
}
@property (weak, nonatomic) CAShapeLayer * trackLayer;
@property (strong, nonatomic) UIBezierPath * trackPath;
@property (weak, nonatomic) CAShapeLayer * progressLayer;
@property (strong, nonatomic) UIBezierPath * progressPath;
@property (weak, nonatomic) CATextLayer * textLayer;
@end

@implementation TVTTProgressView

- (instancetype)init
{
    self = [super init];
    if (self) {
        //        [self makeLayer];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self) {
        //        [self makeLayer];
    }
    return self;
}


- (void)makeLayer{
    __weak typeof(self) weakSelf = self;
    
    if (!self.trackLayer) {
        [self makeTrackLayerFinished:^(CAShapeLayer *layer, UIBezierPath *path) {
            weakSelf.trackLayer = layer;
            weakSelf.trackPath = path;
        }];
    }
    
    if (!self.progressLayer) {
        [self makeTrackLayerFinished:^(CAShapeLayer *layer, UIBezierPath *path) {
            weakSelf.progressLayer = layer;
            weakSelf.progressPath = path;
            weakSelf.progressLayer.strokeColor = [UIColor blueColor].CGColor;
        }];
    }
    
    if (self.displayText && [self.displayText length] > 0) {
        CATextLayer * textLayer = [[CATextLayer alloc] init];
        textLayer.font = (__bridge CFTypeRef)([UIFont systemFontOfSize:14]);
        textLayer.fontSize = 14;
        textLayer.alignmentMode = @"center";
        textLayer.foregroundColor = [UIColor blueColor].CGColor;
        UIFont * font = [UIFont systemFontOfSize:14];
        NSMutableParagraphStyle *style = [[NSParagraphStyle defaultParagraphStyle] mutableCopy];
        [style setAlignment:NSTextAlignmentCenter];
        NSDictionary * attributes = @{NSFontAttributeName:font,
                                      NSParagraphStyleAttributeName:style};
        CGSize  textSize = [self.displayText sizeWithAttributes:attributes];
        textLayer.frame = (CGRect){(CGRectGetWidth(self.frame) - textSize.width)/2.0, (CGRectGetHeight(self.frame) - textSize.height)/2.0,textSize};
        textLayer.string = self.displayText;
        [self.layer addSublayer:textLayer];
    }
    
    [self.progressPath removeAllPoints];
    [self.progressPath addArcWithCenter:CGPointMake((CGRectGetWidth(self.frame)/2.0), CGRectGetHeight(self.frame)/2.0) radius:(CGRectGetWidth(self.frame)/2.0 - 10) startAngle:-M_PI_2 endAngle:M_PI*2*self.progress - M_PI_2 clockwise:YES];
    self.progressLayer.path = self.progressPath.CGPath;
    [self.progressLayer addAnimation:[self pathAnimationWithDuration:self.progress] forKey:@"strokeEndAnimation"];
}


- (CABasicAnimation *)pathAnimationWithDuration:(CGFloat)duration{
    CABasicAnimation * pathAnimation = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
    pathAnimation.duration = duration;
    pathAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn];
    pathAnimation.fromValue = [NSNumber numberWithFloat:0.0f];
    pathAnimation.toValue = [NSNumber numberWithFloat:1.0f];
    pathAnimation.autoreverses = NO;
    return pathAnimation;
}


- (void)makeTrackLayerFinished:(void(^)(CAShapeLayer *layer, UIBezierPath * path))finishedBlock{
    CAShapeLayer * layer = [[CAShapeLayer alloc] init];
    layer.lineWidth = 5;
    layer.fillColor = nil;
    layer.strokeColor = [UIColor lightGrayColor].CGColor;
    layer.frame = self.bounds;
    [self.layer addSublayer:layer];
    UIBezierPath * trackPath = [[UIBezierPath alloc] init];
    [trackPath addArcWithCenter:CGPointMake((CGRectGetWidth(self.frame)/2.0), CGRectGetHeight(self.frame)/2.0) radius:(CGRectGetWidth(self.frame)/2.0 - 10) startAngle:-M_PI_2 endAngle:M_PI*2 - M_PI_2 clockwise:YES];
    layer.path = trackPath.CGPath;
    finishedBlock(layer,trackPath);
}

- (void)setProgress:(CGFloat)progress{
    _progress = progress;
    [self setNeedsLayout];
}
//- (void)setProgressWidth:(CGFloat)progressWidth{
//    _progressWidth = progressWidth;
//    [self setNeedsLayout];
//}
//- (void)setDisplayText:(NSString *)displayText{
//    _displayText = displayText;
//    [self setNeedsLayout];
//}
//- (void)makeTracklayer:(CAShapeLayer **)shapeLayer bezierPath:(UIBezierPath **)path progress:(CGFloat *)progress{
//    CAShapeLayer * trackLayer = ({
//        CAShapeLayer * layer = [[CAShapeLayer alloc] init];
//        layer.backgroundColor = [UIColor lightGrayColor].CGColor;
//        layer.frame = self.bounds;
//        [self.layer addSublayer:layer];
//        UIBezierPath * trackPath = [[UIBezierPath alloc] init];
//        [trackPath addArcWithCenter:CGPointMake((CGRectGetWidth(self.frame)/2.0 + CGRectGetMinX(self.frame)), CGRectGetHeight(self.frame)/2.0 + CGRectGetMinY(self.frame)) radius:(CGRectGetWidth(self.frame)/2.0 - 5) startAngle:0.0 endAngle:M_PI*2 clockwise:YES];
//        layer.path = trackPath.CGPath;
////        *path = trackPath;
//        layer;
//    });
////    *shapeLayer = trackLayer;
//    *progress = 1;
//}


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
//- (void)drawRect:(CGRect)rect {
//    [self makeLayer];
//}

- (void)layoutSubviews{
    [super layoutSubviews];
    [self makeLayer];
}

@end

//
//  TVTSlider.m
//  TVTMeasureSlider
//
//  Created by lben on 15/7/28.
//  Copyright (c) 2015年 lben. All rights reserved.
//

#import "TVTSlider.h"

@interface TVTSlider ()
@property (strong, nonatomic) UIImage * thumbImage;
@end

@implementation TVTSlider
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (instancetype)initWithFrame:(CGRect)frame{
    
    if (self = [super initWithFrame:frame]) {
//        self.backgroundColor = [UIColor clearColor];
        self.backgroundColor = [UIColor clearColor];
        [self addTarget:self action:@selector(sliderValueChanged:) forControlEvents:UIControlEventTouchDragInside|UIControlEventTouchDown];
        self.minimumValue = 0;
        self.maximumValue = 10;
        self.value = 0.5;
    }
    return self;
}

-(void)sliderValueChanged:(id)sender{
    if (!self.thumbImage) {
        return;
    }
    UIGraphicsBeginImageContextWithOptions(_thumbImage.size, NO, 0);
    [_thumbImage drawAtPoint:CGPointMake(0, 0)];
//    [_highlightedStateTextColor set];
//    NSString *value = [NSString stringWithFormat:@"%0.0f",self.value];
//    CGSize size = [value sizeWithFont:[UIFont systemFontOfSize:16]];
//    if(!_isHighlightedStateTextPositionCustom){
//        _highlightedStateTextPosition = CGPointMake(_thumbImage.size.width/2 - size.width/2, 0);
//    }
//    [value drawAtPoint:_highlightedStateTextPosition withFont:_highlightedStateTextFont];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    [self setThumbImage:image forState:UIControlStateHighlighted];
    UIGraphicsEndImageContext();

}
@end

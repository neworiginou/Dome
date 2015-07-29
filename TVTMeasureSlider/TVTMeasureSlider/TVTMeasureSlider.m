//
//  TVTMeasureSlider.m
//  TVTMeasureSlider
//
//  Created by lben on 15/7/28.
//  Copyright (c) 2015年 lben. All rights reserved.
//

#import "TVTMeasureSlider.h"
#import "TVTSlider.h"

@interface TVTMeasureSlider ()
@property (weak, nonatomic) TVTSlider * tvSliderView;

@property (strong, nonatomic) UIImage * markImage;
@property (strong, nonatomic) UIColor * markTextColor;

@property (strong, nonatomic) NSArray * markTextArray;


@property (nonatomic, copy) void(^measureSliderCallBackBlock)(CGFloat progress); /**> 进度回调函数 */
@end

@implementation TVTMeasureSlider

- (id)init {
    self = [super init];
    if(self) {
        [self initializeSlider];
    }
    return self;
}

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self initializeSlider];
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if(self) {
//        [self initializeSlider];
    }
    return self;
}

- (void)awakeFromNib{
    [self initializeSlider];
}

- (void)initializeSlider{
    _markImage = [UIImage imageNamed:@"marker.png"];
    _markTextColor = [UIColor blackColor];
    
    self.backgroundColor = [UIColor clearColor];
    
    TVTSlider * sliderView = [[TVTSlider alloc] initWithFrame:CGRectMake(15, self.frame.size.height/2, self.frame.size.width-30,30)];
    [sliderView setThumbImage:[UIImage imageNamed:@"slider_normal"] forState:UIControlStateNormal];
    [sliderView setMinimumTrackImage:[[UIImage imageNamed:@"slider_blue"] resizableImageWithCapInsets:UIEdgeInsetsMake(0, 16, 0, 16)] forState:UIControlStateNormal];
    [sliderView setMaximumTrackImage:[[UIImage imageNamed:@"slider_gray"] resizableImageWithCapInsets:UIEdgeInsetsMake(0, 16, 0, 16)] forState:UIControlStateNormal];
    sliderView.continuous = NO;
    [sliderView addTarget:self action:@selector(valueChanged:) forControlEvents:UIControlEventValueChanged|UIControlEventTouchDragInside];
    [self addSubview:sliderView];
    _tvSliderView = sliderView;
    
    _markTextArray = @[@"1000.00元",@"10000.00元",@"50000.00元",@"100000.00元"];
}

- (void)setMeasureCallBack:(void (^)(CGFloat))measureCallBack{
    _measureSliderCallBackBlock = measureCallBack;
}

- (void)valueChanged:(id)sender {
    double value =_tvSliderView.value;
    NSLog(@"%f",value);
    if (self.measureSliderCallBackBlock) {
        self.measureSliderCallBackBlock(value);
    }
}
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    float scaleFactor = _tvSliderView.frame.size.width / ([_markTextArray count] - 1);
    [_markTextColor set];
    
    for(int index = 0 ; index < [_markTextArray count] ; index ++){
        
        float x = (scaleFactor * index) + CGRectGetMinX(_tvSliderView.frame);
        float y = _tvSliderView.center.y + _markImage.size.height +12;
        
        UIImageView *markerImageView  = [[UIImageView alloc] initWithImage:_markImage];
        markerImageView.frame = CGRectMake(x, y, _markImage.size.width, _markImage.size.height);
        
        [self insertSubview:markerImageView belowSubview:_tvSliderView];
        
        NSString *value = _markTextArray[index];
        CGSize size = [value sizeWithFont:[UIFont systemFontOfSize:10]];
        CGFloat offset_x = 0;
        if (index == 0) {
            offset_x = 15;
        }else if (index == _markTextArray.count - 1){
            offset_x = -25;
        }
        [value drawAtPoint:CGPointMake(markerImageView.frame.origin.x - (size.width/2) + offset_x, markerImageView.frame.origin.y + markerImageView.frame.size.height + 10) withFont:[UIFont systemFontOfSize:12]];
    }
}

@end

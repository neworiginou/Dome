//
//  UIScrollView+TUTRefresh.m
//  RefreshLoadView
//
//  Created by lbencs on 1/7/15.
//  Copyright (c) 2015 aikaola. All rights reserved.
//

#import "UIScrollView+TUTRefresh.h"
#import <objc/runtime.h>

#define LOG_FUN NSLog(@"%@",NSStringFromSelector(_cmd));

static NSString * const kRefreshDateIdentify = @"TUTRefreshTimeUserDefautIdentify";

//父控件的
static NSString * const TUTRefreshContentOffset = @"contentOffset";



static char  TUTRefreshHeaderViewKey;
static char  TUTRefreshFooterViewKey;

static char  TUTRefreshHeaderViewCallBackBlockKey;
static char  TUTRefreshFooterViewCallBackBlockKey;

@interface UIScrollView ()<UIScrollViewDelegate>
@property (weak, nonatomic) TUTRefreshHeaderView * headerView;
@property (weak, nonatomic) TUTRefreshFooterView * footerView;

@property (copy, nonatomic) void(^TUTRefreshHeaderCallBackBlock)();
@property (copy, nonatomic) void(^TUTRefreshFooterCallBackBlock)();
@end


@implementation UIScrollView (TUTRefresh)

- (void)addHeaderRefreshCallBack:(void (^)())refreshBlock{
    TUTRefreshHeaderView * headerView = [[TUTRefreshHeaderView alloc] init];
    [self addSubview:headerView];
    self.headerView = headerView;
    self.headerView.backgroundColor = [UIColor redColor];
    self.delegate = self;
    self.TUTRefreshHeaderCallBackBlock = refreshBlock;
}
- (void)addFooterRefreshCallBack:(void (^)())refreshBlock{
    TUTRefreshFooterView * footerView = [[TUTRefreshFooterView alloc] init];
    [self addSubview:footerView];
    self.footerView = footerView;
    self.delegate = self;
    self.TUTRefreshFooterCallBackBlock = refreshBlock;
}

- (void)stopHeaderRefreshing{
    
}

- (void)startHeaderRefreshing{
    
}
- (void)stopFooterRefreshing{
    
}

- (void)setRefreshHeaderView{
    
}



#pragma mark - delegate


#pragma mark - getter setter 

- (void)setTUTRefreshFooterCallBackBlock:(void (^)())TUTRefreshFooterCallBackBlock{
    objc_setAssociatedObject(self, &TUTRefreshFooterViewCallBackBlockKey, TUTRefreshFooterCallBackBlock, OBJC_ASSOCIATION_COPY);
}
- (void)setTUTRefreshHeaderCallBackBlock:(void (^)())TUTRefreshHeaderCallBackBlock{
    objc_setAssociatedObject(self, &TUTRefreshHeaderViewCallBackBlockKey, TUTRefreshHeaderCallBackBlock, OBJC_ASSOCIATION_COPY);
}
- (void (^)())TUTRefreshFooterCallBackBlock{
    return objc_getAssociatedObject(self, &TUTRefreshFooterViewCallBackBlockKey);
}
- (void (^)())TUTRefreshHeaderCallBackBlock{
    return objc_getAssociatedObject(self, &TUTRefreshHeaderViewCallBackBlockKey);
}
- (void)setHeaderView:(TUTRefreshHeaderView *)headerView{
    objc_setAssociatedObject(self, &TUTRefreshHeaderViewKey, headerView, OBJC_ASSOCIATION_ASSIGN);
}
- (void)setFooterView:(TUTRefreshHeaderView *)footerView{
    objc_setAssociatedObject(self, &TUTRefreshFooterViewKey, footerView, OBJC_ASSOCIATION_ASSIGN);
}
- (TUTRefreshFooterView *)footerView{
   return objc_getAssociatedObject(self, &TUTRefreshFooterViewKey);
}
- (TUTRefreshHeaderView *)headerView{
    return objc_getAssociatedObject(self, &TUTRefreshHeaderViewKey);
}

#pragma mark 0
- (NSString *)getLatestRefreshDateString{
    return nil;
}

@end


@implementation TUTRefreshView

- (void)willMoveToSuperview:(UIView *)newSuperview{
    [super willMoveToSuperview:newSuperview];
    [self.superview removeObserver:self forKeyPath:TUTRefreshContentOffset];
    if (newSuperview) {
        [newSuperview addObserver:self forKeyPath:TUTRefreshContentOffset options:NSKeyValueObservingOptionNew context:nil];
    }
}

@end


@implementation TUTRefreshHeaderView

//刷新操作提示
- (UILabel *)statusLabel
{
    if (!_statusLabel) {
        _statusLabel = [[UILabel alloc] initWithFrame:CGRectMake(135,15, 160, 14)];
        _statusLabel.backgroundColor = [UIColor clearColor];
        _statusLabel.font = [UIFont systemFontOfSize:14.f];
        _statusLabel.textColor = [UIColor blackColor];
    }
    return _statusLabel;
}
//时间
- (UILabel *)timeLabel
{
    if (!_timeLabel) {
        CGRect timeLabelFrame = self.statusLabel.frame;
        timeLabelFrame.origin.y += CGRectGetHeight(timeLabelFrame) + 6;
        _timeLabel = [[UILabel alloc] initWithFrame:timeLabelFrame];
        _timeLabel.backgroundColor = [UIColor clearColor];
        _timeLabel.font = [UIFont systemFontOfSize:11.f];
        _timeLabel.textColor = [UIColor colorWithWhite:0.659 alpha:1.000];
        
    }
    return _timeLabel;
}
//刷新圆圈
- (TUTRefreshCircleView *)circleView
{
    if (!_circleView) {
        _circleView = [[TUTRefreshCircleView alloc] initWithFrame:CGRectMake(110,15,CLLRefreshCircleViewHeight,CLLRefreshCircleViewHeight)];
    }
    return _circleView;
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self.backgroundColor = [UIColor whiteColor];
        [self addSubview:self.statusLabel];
        [self addSubview:self.timeLabel];
        [self addSubview:self.circleView];
    }
    return self;
}


- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context{
    LOG_FUN
    
}

@end

@implementation TUTRefreshFooterView

- (UILabel *)statusLabel {
    if (!_statusLabel) {
        _statusLabel = [[UILabel alloc] initWithFrame:CGRectMake(135,(self.bounds.size.height - 14) * 0.5, 160, 14)];
        _statusLabel.backgroundColor = [UIColor clearColor];
        _statusLabel.font = [UIFont systemFontOfSize:14.f];
        _statusLabel.textColor = [UIColor blackColor];
    }
    return _statusLabel;
}
- (UIActivityIndicatorView *)indicatorView {
    if (!_indicatorView) {
        _indicatorView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
        _indicatorView.frame = CGRectMake(110,(self.bounds.size.height - 20) * 0.5,20,20);
        _indicatorView.hidesWhenStopped = YES;
    }
    return _indicatorView;
}
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        [self addSubview:self.indicatorView];
        [self addSubview:self.statusLabel];
    }
    return self;
}

- (void)resetView
{
    if (_indicatorView.isAnimating) {
        [_statusLabel sizeToFit];
        CGRect tmpFrame = _indicatorView.frame;
        tmpFrame.origin.x = (self.bounds.size.width - tmpFrame.size.width - _statusLabel.frame.size.width - 5) * 0.5;
        tmpFrame.origin.y = (self.bounds.size.height - tmpFrame.size.height) * 0.5;
        _indicatorView.frame = tmpFrame;
        
        tmpFrame.origin.x = _indicatorView.frame.origin.x + _indicatorView.frame.size.width + 5;
        tmpFrame.origin.y = (self.bounds.size.height - _statusLabel.frame.size.height) * 0.5;
        tmpFrame.size = _statusLabel.frame.size;
        _statusLabel.frame = tmpFrame;
    }else {
        [_statusLabel sizeToFit];
        CGRect tmpFrame = _statusLabel.frame;
        tmpFrame.origin.x = (self.bounds.size.width - tmpFrame.size.width ) * 0.5;
        tmpFrame.origin.y = (self.bounds.size.height - tmpFrame.size.height) * 0.5;
        _statusLabel.frame = tmpFrame;
    }
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context{
//    LOG_FUN
}
@end

@implementation TUTRefreshCircleView
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        _heightBeginToRefresh = 50;
        _offsetY = 0;
        
        self.backgroundColor = [UIColor clearColor];
    }
    return self;
}


+ (CABasicAnimation*)repeatRotateAnimation {
    CABasicAnimation *rotateAni = [CABasicAnimation animationWithKeyPath: @"transform.rotation.z"];
    rotateAni.duration = 0.25;
    rotateAni.cumulative = YES;
    rotateAni.removedOnCompletion = NO;
    rotateAni.fillMode = kCAFillModeForwards;
    rotateAni.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
    rotateAni.toValue = [NSNumber numberWithFloat:M_PI / 2];
    rotateAni.repeatCount = MAXFLOAT;
    
    return rotateAni;
}

- (void)drawRect:(CGRect)rect {
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetStrokeColorWithColor(context, [UIColor colorWithRed:173 / 255.0 green:53 / 255.0 blue:60 / 255.0 alpha:1].CGColor);
    CGContextSetLineWidth(context, 1.f);
    
    static CGFloat radius = 9;
    if (!_isRefreshViewOnTableView) {
        static CGFloat startAngle = M_PI / 2;
        CGFloat endAngle = (ABS(_offsetY) / _heightBeginToRefresh) * (M_PI * 19 / 10) + startAngle;
        CGContextAddArc(context, CGRectGetWidth(self.frame) / 2, CGRectGetHeight(self.frame) / 2, radius, startAngle, endAngle, 0);
    } else {
        static CGFloat startAngle = 3 * M_PI / 2.0;
        CGFloat endAngle = (ABS(_offsetY) / _heightBeginToRefresh) * (M_PI * 19 / 10) + startAngle;
        CGContextAddArc(context, CGRectGetWidth(self.frame) / 2, CGRectGetHeight(self.frame) / 2, radius, startAngle, endAngle, 0);
    }
    CGContextDrawPath(context, kCGPathStroke);
}
@end
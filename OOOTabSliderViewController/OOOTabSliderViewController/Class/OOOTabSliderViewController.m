//
//  OOOTabSliderViewController.m
//  OOOTabSliderViewController
//
//  Created by lben on 15/7/29.
//  Copyright (c) 2015年 lben. All rights reserved.
//

#import "OOOTabSliderViewController.h"
#import "OOOViewController.h"

static CGFloat const kOOOTabSliderViewControllerTitleSliderViewHeight = 44;

@interface OOOTabLabel : UIView

@property (nonatomic, weak) UILabel *titleLabel; /**> title label */
@property (nonatomic, strong) UITapGestureRecognizer *tapGestureRecognizer;
@property (nonatomic, copy) void(^tapCallBack)(NSInteger index);
@property (nonatomic, assign) NSInteger index;

- (void)refershLabelWithIsSelected:(BOOL)isSelected;
@end

@implementation OOOTabLabel

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self makeUp];
        [self addGestureRecognizer];
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder{
    if (self = [super initWithCoder:aDecoder]) {
        [self makeUp];
        [self addGestureRecognizer];
    }
    return self;
}

- (void)refershLabelWithIsSelected:(BOOL)isSelected{
    if (isSelected) {
        self.titleLabel.textColor = [UIColor colorWithRed:0.259f green:0.812f blue:0.784f alpha:1.00f];
    }else{
        self.titleLabel.textColor = [UIColor colorWithRed:0.376f green:0.376f blue:0.376f alpha:1.00f];
    }
}
- (void)addGestureRecognizer{
    UITapGestureRecognizer * tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapGestureRecognizer:)];
    [self addGestureRecognizer:tapGestureRecognizer];
}
- (void)tapGestureRecognizer:(UITapGestureRecognizer *)tapGestureRecognizer{
    if (self.tapCallBack) {
        self.tapCallBack(self.index);
    }
}
- (void)makeUp{
    UILabel * label = ({
        UILabel * label = [[UILabel alloc] init];
        label.textColor = [UIColor whiteColor];
        label.textAlignment = NSTextAlignmentCenter;
        [self addSubview:label];
        label.translatesAutoresizingMaskIntoConstraints = NO;
        [self addConstraints:
         [NSLayoutConstraint
          constraintsWithVisualFormat:@"H:|-[label]-|"
          options:0
          metrics:nil
          views:NSDictionaryOfVariableBindings(label)]];
        [self addConstraints:
         [NSLayoutConstraint
          constraintsWithVisualFormat:@"V:|-[label]-|"
          options:0
          metrics:nil
          views:NSDictionaryOfVariableBindings(label)]];
        label;
    });
    self.titleLabel = label;
    self.backgroundColor = [UIColor colorWithRed:0.945f green:0.945f blue:0.945f alpha:1.00f];
}

@end

@interface OOOSliderView : UIView

@property (nonatomic, strong) NSArray *tabTitleItems;
@property (nonatomic, strong) NSMutableArray *tabTitleViews;
@property (nonatomic, weak) CAShapeLayer *indicatorLayer;
@property (nonatomic, strong) UIBezierPath *path;
@property (nonatomic, copy) void(^selectedTabCallBack)(NSInteger index);

- (void)updateSliderViewWithItems:(NSArray *)items;
- (void)refershSliderViewByIndex:(NSInteger)index;

@end

@implementation OOOSliderView

- (void)updateSliderViewWithItems:(NSArray *)items{
    self.tabTitleItems = items;
    [self makeUpTabTitleViews];
}

- (void)layoutSubviews{
    [super layoutSubviews];
    [self makeUpIndicatorLayer];
    [self makeBottomLine];
    [self refershSliderViewByIndex:0];
}
- (void)makeBottomLine{
    CALayer *lineLayer = [[CALayer alloc] init];
    lineLayer.frame = CGRectMake(0, CGRectGetHeight(self.frame), CGRectGetWidth(self.frame), 0.3);
    lineLayer.backgroundColor = [UIColor lightGrayColor].CGColor;
    lineLayer.backgroundColor = [UIColor colorWithRed:0.882f green:0.882f blue:0.882f alpha:1.00f].CGColor;
    [self.layer addSublayer:lineLayer];
}
- (void)makeUpIndicatorLayer{
    CAShapeLayer * indicatorLayer = ({
        CAShapeLayer * indicatorLayer = [[CAShapeLayer alloc] init];
        indicatorLayer.frame = CGRectMake(0, CGRectGetHeight(self.frame)-1, CGRectGetWidth(self.frame), 2);
        [self.layer addSublayer:indicatorLayer];
        indicatorLayer.strokeColor = [UIColor greenColor].CGColor;
        indicatorLayer.fillColor = [UIColor clearColor].CGColor;
        indicatorLayer.lineWidth = 2;
        indicatorLayer;
    });
    self.indicatorLayer = indicatorLayer;
}

- (void)updateIndicatorLayerByIndex:(NSInteger)index{
    if (!_path) {
        _path = [[UIBezierPath alloc] init];
    }
    [_path removeAllPoints];
    CGFloat tabWith = CGRectGetWidth(self.frame)/[self.tabTitleItems count];
    [_path moveToPoint:CGPointMake(tabWith*index + 10, 0)];
    [_path addLineToPoint:CGPointMake(tabWith*(index+1)-10, 0)];
    self.indicatorLayer.path = [_path CGPath];
}
- (void)makeUpTabTitleViews{
    __weak typeof(self) weakSelf = self;
    __block UIView * leftView = self;
    [self.tabTitleItems enumerateObjectsUsingBlock:^(NSString *titleStr, NSUInteger idx, BOOL *stop) {
        OOOTabLabel * label = ({
            OOOTabLabel * label = [[OOOTabLabel alloc] init];
            label.titleLabel.text = titleStr;
            label.index = idx;
            [weakSelf addSubview:label];
            label.translatesAutoresizingMaskIntoConstraints = NO;
            [weakSelf addConstraints:
             [NSLayoutConstraint constraintsWithVisualFormat:@"V:|-0-[label]-0-|"
                                                     options:0
                                                     metrics:nil
                                                       views:NSDictionaryOfVariableBindings(label)]];
            if (leftView != weakSelf) {
                [weakSelf addConstraints:
                 [NSLayoutConstraint constraintsWithVisualFormat:@"H:[leftView]-0-[label]"
                                                         options:0
                                                         metrics:nil
                                                           views:NSDictionaryOfVariableBindings(leftView,label)]];
                [weakSelf addConstraint:
                 [NSLayoutConstraint constraintWithItem:leftView
                                              attribute:NSLayoutAttributeWidth
                                              relatedBy:0
                                                 toItem:label
                                              attribute:NSLayoutAttributeWidth multiplier:1.0f constant:0]];
            }else{
                [weakSelf addConstraints:
                 [NSLayoutConstraint constraintsWithVisualFormat:@"H:|-0-[label]"
                                                         options:0
                                                         metrics:nil
                                                           views:NSDictionaryOfVariableBindings(leftView,label)]];
            }
            label;
        });
        [label setTapCallBack:^(NSInteger index) {
            [weakSelf refershSliderViewByIndex:index];
            if (weakSelf.selectedTabCallBack) {
                weakSelf.selectedTabCallBack(index);
            }
        }];
        [weakSelf.tabTitleViews addObject:label];
        leftView = label;
    }];
    
    [self addConstraint:
     [NSLayoutConstraint constraintWithItem:leftView
                                  attribute:NSLayoutAttributeRight
                                  relatedBy:NSLayoutRelationGreaterThanOrEqual
                                     toItem:self
                                  attribute:NSLayoutAttributeRight
                                 multiplier:1.0f
                                   constant:0]];

}

- (void)refershSliderViewByIndex:(NSInteger)index{
    [self.tabTitleViews enumerateObjectsUsingBlock:^(OOOTabLabel *obj, NSUInteger idx, BOOL *stop) {
        [obj refershLabelWithIsSelected:(idx == index)];
    }];
    [self updateIndicatorLayerByIndex:index];
}

- (NSMutableArray *)tabTitleViews{
    if (!_tabTitleViews) {
        _tabTitleViews = [[NSMutableArray alloc] init];
    }
    return _tabTitleViews;
}

@end

@interface OOOTabSliderViewController ()<UIScrollViewDelegate>
@property (weak, nonatomic) OOOSliderView *titleSliderView;

@property (weak, nonatomic) UIScrollView *scrollView;
@property (weak, nonatomic) UIView *contentView;

@property (weak, nonatomic) NSLayoutConstraint *scrollContentViewHeightConstraint;

@property (assign, nonatomic) NSInteger currentTabIndex;
@end

@implementation OOOTabSliderViewController

- (void)viewDidLoad{
    [super viewDidLoad];
    self.dataSource = self;
    self.view.backgroundColor = [UIColor whiteColor];
    if ([self respondsToSelector:@selector(edgesForExtendedLayout)]){
        self.edgesForExtendedLayout = UIRectEdgeNone;
    }
}

- (void)viewWillLayoutSubviews{
    [super viewWillLayoutSubviews];
    [self ooo_makeUpTitleSliderView];
    [self ooo_makeUpScrollView];
    [self ooo_makeUpContentView];
    
    __weak typeof(self) weakSelf = self;
    [self.titleSliderView setSelectedTabCallBack:^(NSInteger index) {
        [weakSelf ooo_scrollToTab:index];
    }];
}

#pragma mark - OOOTabSliderViewControllerDataSource

- (NSArray *)sliderViewControllerSubViewControllers:(OOOTabSliderViewController *)viewController{

    OOOViewController * vc1 = [[OOOViewController alloc] init];
    vc1.title = @"tab1";
    vc1.view.backgroundColor = [UIColor redColor];
    
    OOOViewController * vc2 = [[OOOViewController alloc] init];
    vc2.title = @"tab2";
    vc2.view.backgroundColor = [UIColor grayColor];
    
    return @[vc1,vc2];
}

- (void)ooo_makeUpContentView{
    
    if (self.dataSource && [self.dataSource respondsToSelector:@selector(sliderViewControllerSubViewControllers:)]) {
        self.subViewController = [self.dataSource sliderViewControllerSubViewControllers:self];
    }else{
        NSAssert(NO, @"dataSource could not be nil");
    }
    
    UIView * contentView = ({
        UIView * contentView = [[UIView alloc] init];
        contentView.backgroundColor = [UIColor clearColor];
        [_scrollView addSubview:contentView];
        contentView.translatesAutoresizingMaskIntoConstraints = NO;
        [_scrollView addConstraints:
         [NSLayoutConstraint constraintsWithVisualFormat:@"H:|-0-[contentView]-0-|"
                                                 options:0
                                                 metrics:nil
                                                   views:NSDictionaryOfVariableBindings(contentView)]];
        [_scrollView addConstraints:
         [NSLayoutConstraint constraintsWithVisualFormat:@"V:|-0-[contentView]-0-|"
                                                 options:0
                                                 metrics:nil
                                                   views:NSDictionaryOfVariableBindings(contentView)]];
        
        [_scrollView addConstraint:
         [NSLayoutConstraint constraintWithItem:contentView
                                      attribute:NSLayoutAttributeWidth
                                      relatedBy:0
                                         toItem:_scrollView
                                      attribute:NSLayoutAttributeWidth
                                     multiplier:self.subViewController.count
                                       constant:0]];
        [_scrollView addConstraint:
         [NSLayoutConstraint constraintWithItem:contentView
                                      attribute:NSLayoutAttributeHeight
                                      relatedBy:0
                                         toItem:_scrollView
                                      attribute:NSLayoutAttributeHeight
                                     multiplier:1.0f
                                       constant:0]];
        contentView;
    });
    self.contentView = contentView;
    NSMutableArray * titleItems = [[NSMutableArray alloc] init];
    CGFloat viewWidth = [UIScreen mainScreen].bounds.size.width;
    __weak typeof(self) weakSelf = self;
    [self.subViewController enumerateObjectsUsingBlock:^(UIViewController *obj, NSUInteger idx, BOOL *stop) {
        UIView * subView = obj.view;
        [weakSelf.contentView addSubview:subView];
        subView.translatesAutoresizingMaskIntoConstraints = NO;
        CGFloat leading = viewWidth * idx;
        [weakSelf.contentView addConstraints:
         [NSLayoutConstraint constraintsWithVisualFormat:@"H:|-leading-[subView(viewWidth)]"
                                                 options:0
                                                 metrics:@{@"leading":@(leading),@"viewWidth":@(viewWidth)}
                                                   views:NSDictionaryOfVariableBindings(subView)]];
        [weakSelf.contentView addConstraints:
         [NSLayoutConstraint constraintsWithVisualFormat:@"V:|-0-[subView]-0-|"
                                                 options:0
                                                 metrics:nil
                                                   views:NSDictionaryOfVariableBindings(subView)]];
        [titleItems addObject:obj.title];
    }];
    
    
    [self.titleSliderView updateSliderViewWithItems:titleItems];
}
- (void)ooo_makeUpTitleSliderView{
    
    OOOSliderView *titleSliderView = ({
        OOOSliderView *titleSliderView  = [[OOOSliderView alloc] init];
        [self.view addSubview:titleSliderView];
        titleSliderView.translatesAutoresizingMaskIntoConstraints = NO;
        [self.view addConstraints:
         [NSLayoutConstraint constraintsWithVisualFormat:@"H:|-0-[titleSliderView]-0-|"
                                                 options:0
                                                 metrics:nil
                                                   views:NSDictionaryOfVariableBindings(titleSliderView)]];
        [self.view addConstraints:
         [NSLayoutConstraint constraintsWithVisualFormat:@"V:|-0-[titleSliderView(kOOOTabSliderViewControllerTitleSliderViewHeight)]"
                                                 options:0
                                                 metrics:@{@"kOOOTabSliderViewControllerTitleSliderViewHeight":@(kOOOTabSliderViewControllerTitleSliderViewHeight)}
                                                   views:NSDictionaryOfVariableBindings(titleSliderView)]];
        titleSliderView;
    });
    self.titleSliderView = titleSliderView;
}
- (void)ooo_makeUpScrollView{
    UIScrollView * scrollView = ({
        UIScrollView * scrollView = [[UIScrollView alloc] init];
        scrollView.pagingEnabled = YES;
        scrollView.delegate = self;
        [self.view addSubview:scrollView];
        scrollView.translatesAutoresizingMaskIntoConstraints = NO;
        [self.view addConstraints:
         [NSLayoutConstraint constraintsWithVisualFormat:@"H:|-0-[scrollView]-0-|"
                                                 options:0
                                                 metrics:nil
                                                   views:NSDictionaryOfVariableBindings(scrollView)]];
        [self.view addConstraints:
         [NSLayoutConstraint constraintsWithVisualFormat:@"V:[_titleSliderView]-0-[scrollView]-0-|"
                                                 options:0
                                                 metrics:nil
                                                   views:NSDictionaryOfVariableBindings(_titleSliderView,scrollView)]];
        scrollView;
    });
    self.scrollView = scrollView;
}

- (void)ooo_scrollToTab:(NSInteger)index{
    [UIView animateWithDuration:0.2
                    animations:^{
                        self.scrollView.contentOffset = CGPointMake(CGRectGetWidth(self.scrollView.frame)*index, 0);
                    }];
}

#pragma mark - UIScrollViewDelegate
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    self.currentTabIndex = scrollView.contentOffset.x/scrollView.frame.size.width;
    [self.titleSliderView refershSliderViewByIndex:self.currentTabIndex];
}

@end



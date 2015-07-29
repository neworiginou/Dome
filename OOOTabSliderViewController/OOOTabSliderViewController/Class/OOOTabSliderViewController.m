//
//  OOOTabSliderViewController.m
//  OOOTabSliderViewController
//
//  Created by lben on 15/7/29.
//  Copyright (c) 2015年 lben. All rights reserved.
//

#import "OOOTabSliderViewController.h"

@interface OOOTabLabel : UIView

@property (nonatomic, weak) UILabel *titleLabel; /**> title label */

@end

@implementation OOOTabLabel

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder{
    if (self = [super initWithCoder:aDecoder]) {
    }
    return self;
}

@end

@interface OOOSliderView : UIView

@property (nonatomic, strong) NSArray *tabTitleItems;

- (void)updateSliderViewWithItems:(NSArray *)items;
- (void)refershSliderViewByIndex:(NSInteger)index;

@end

@implementation OOOSliderView

- (void)updateSliderViewWithItems:(NSArray *)items{
    self.tabTitleItems = items;
    CGFloat tabTitleWidth = CGRectGetWidth(self.frame) / [self.tabTitleItems count];
    __weak typeof(self) weakSelf = self;
    __block UIView * leftView = self;
    [self.tabTitleItems enumerateObjectsUsingBlock:^(NSString *titleStr, NSUInteger idx, BOOL *stop) {
        OOOTabLabel * label = [[OOOTabLabel alloc] init];
        [weakSelf addSubview:label];
        label.translatesAutoresizingMaskIntoConstraints = NO;
        [weakSelf addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-0-[label]-0-|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(leftView,label)]];
        weakSelf addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[]" options:<#(NSLayoutFormatOptions)#> metrics:<#(NSDictionary *)#> views:<#(NSDictionary *)#>]
    }];
}
- (void)refershSliderViewByIndex:(NSInteger)index{
    
}

@end

@interface OOOTabSliderViewController ()
@property (strong, nonatomic) UIView * contentView;
@property (strong, nonatomic) OOOSliderView * titleSliderView;
@end

@implementation OOOTabSliderViewController


- (instancetype)init{
    if (self = [super init]) {
        _contentView = [[UIView alloc] init];
        _contentView.backgroundColor = [UIColor redColor];
        _titleSliderView = [[OOOSliderView alloc] init];
        _titleSliderView.backgroundColor = [UIColor blackColor];
        [_contentView addSubview:_titleSliderView];
        
        _titleSliderView.translatesAutoresizingMaskIntoConstraints = NO;
        [_contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-0-[_titleSliderView]-0-|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_titleSliderView)]];
        [_contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-0-[_titleSliderView(44)]" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_titleSliderView)]];
    }
    return self;
}

- (void)addParentController:(UIViewController *)viewController{
    _contentView.frame = viewController.view.bounds;
    [viewController.view addSubview:self.contentView];
}

@end



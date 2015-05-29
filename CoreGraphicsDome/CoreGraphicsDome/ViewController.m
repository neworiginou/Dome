//
//  ViewController.m
//  CoreGraphicsDome
//
//  Created by lben on 15/5/25.
//  Copyright (c) 2015年 lben. All rights reserved.
//

#import "ViewController.h"
#import "TVTTCircleView.h"
#import "TVTTProgressBar.h"
#import "TVTTProgressView.h"
#import "TVTTAffineTransformView.h"


@interface ViewController ()
@property (weak, nonatomic) TVTTProgressBar * progressBar;
@property (weak, nonatomic) TVTTProgressView * progressView;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    TVTTCircleView * circleView = [[TVTTCircleView alloc] init];
    circleView.translatesAutoresizingMaskIntoConstraints = NO;
    [self.view addSubview:circleView];
    [circleView addConstraints:@[[NSLayoutConstraint constraintWithItem:circleView
                                                              attribute:NSLayoutAttributeWidth
                                                              relatedBy:NSLayoutRelationEqual
                                                                 toItem:nil
                                                              attribute:NSLayoutAttributeNotAnAttribute
                                                             multiplier:1.0
                                                               constant:100],
                                [NSLayoutConstraint constraintWithItem:circleView
                                                             attribute:NSLayoutAttributeHeight
                                                             relatedBy:NSLayoutRelationEqual
                                                                toItem:nil
                                                             attribute:NSLayoutAttributeNotAnAttribute
                                                            multiplier:1.0
                                                              constant:100],
                                 ]];
    [self.view addConstraints:@[[NSLayoutConstraint constraintWithItem:circleView
                                                             attribute:NSLayoutAttributeTop
                                                             relatedBy:NSLayoutRelationEqual
                                                                toItem:self.view
                                                             attribute:NSLayoutAttributeTop
                                                            multiplier:1.0
                                                              constant:20],
                                [NSLayoutConstraint constraintWithItem:circleView
                                                             attribute:NSLayoutAttributeCenterX
                                                             relatedBy:NSLayoutRelationEqual
                                                                toItem:self.view
                                                             attribute:NSLayoutAttributeCenterX
                                                            multiplier:1.0
                                                              constant:0]]];
    
    
    
    TVTTAffineTransformView * transformView = [[TVTTAffineTransformView alloc] init];
    transformView.translatesAutoresizingMaskIntoConstraints = NO;
    [self.view addSubview:transformView];
    
    NSDictionary *views = NSDictionaryOfVariableBindings(self.view,transformView,circleView);
    NSDictionary *metrics = @{@"padding":@20.0};
    NSString * h_vfl = @"H:[transformView(==100.0)]";
    NSString * v_vfl = @"V:[circleView]-padding-[transformView(100)]";
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:v_vfl options:0 metrics:metrics views:views]];
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:h_vfl options:0 metrics:nil views:views]];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:transformView attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeCenterX multiplier:1.0 constant:0]];

    
    
    TVTTProgressBar * progressBar = [[TVTTProgressBar alloc] init];
    progressBar.translatesAutoresizingMaskIntoConstraints = NO;
    [self.view addSubview:progressBar];
    NSDictionary * views_1 = NSDictionaryOfVariableBindings(transformView,progressBar);
    NSString * p_h_vfl = @"H:[progressBar(==100.0)]";
    NSString * p_v_vfl = @"V:[transformView]-padding-[progressBar(==100.0)]";
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:p_h_vfl options:0 metrics:metrics views:views_1]];
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:p_v_vfl options:0 metrics:metrics views:views_1]];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:progressBar attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeCenterX multiplier:1.0 constant:0]];
    _progressBar = progressBar;
    _progressBar.progress = .9;
    
    TVTTProgressView * progressView = [[TVTTProgressView alloc] init];
//    progressView.backgroundColor = [UIColor blackColor];
    progressView.translatesAutoresizingMaskIntoConstraints = NO;
    [self.view addSubview:progressView];
    NSDictionary * views_2 = NSDictionaryOfVariableBindings(progressView,progressBar);
    NSString * p_2_h_vfl = @"H:[progressView(==100.0)]";
    NSString * p_2_v_vfl = @"V:[progressBar]-padding-[progressView(==100.0)]";
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:p_2_h_vfl options:0 metrics:metrics views:views_2]];
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:p_2_v_vfl options:0 metrics:metrics views:views_2]];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:progressView attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeCenterX multiplier:1.0 constant:0]];
    [progressView setProgress:.3];
    _progressView = progressView;
    _progressView.displayText = @"1000\n哈哈哈";
    
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"OK" style:0 target:self action:@selector(leftBarButtonItemBtnClick)];
    
    
}
- (void)leftBarButtonItemBtnClick{
//    [_progressBar setNeedsDisplay];
//    [_progressBar setNeedsLayout];
    _progressBar.progress = .3;
    _progressView.progress = .9;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

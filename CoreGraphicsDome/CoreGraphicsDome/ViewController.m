//
//  ViewController.m
//  CoreGraphicsDome
//
//  Created by lben on 15/5/25.
//  Copyright (c) 2015年 lben. All rights reserved.
//

#import "ViewController.h"
#import "TVTTCircleView.h"
#import "TVTTAffineTransformView.h"


@interface ViewController ()

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

    
    
    

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

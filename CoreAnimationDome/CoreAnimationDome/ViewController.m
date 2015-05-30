//
//  ViewController.m
//  CoreAnimationDome
//
//  Created by lbencs on 15/5/19.
//  Copyright (c) 2015年 lbencs. All rights reserved.
//

#import "ViewController.h"
#import <Foundation/Foundation.h>
#import <QuartzCore/QuartzCore.h>

#import <QuartzCore/CALayer.h>
@interface ViewController ()

@end

@implementation ViewController


- (void)viewDidLoad {
    [super viewDidLoad];

    CALayer * layer = [[CALayer alloc] init];
    layer.frame = CGRectMake(100, 200, 100, 100);
    layer.backgroundColor = [[UIColor blueColor] CGColor];
    [self.view.layer addSublayer:layer];


    UIView * view = [[UIView alloc] initWithFrame:CGRectMake(250, 200, 100, 100)];
    view.backgroundColor = [UIColor blueColor];
    [self.view addSubview:view];


    CALayer * mainLayer = [[CALayer alloc] init];
    [self.view.layer addSublayer:mainLayer];
    
    [mainLayer addSublayer:nil];

    layer.backgroundColor = [[UIColor blueColor]CGColor];
    layer.frame = CGRectMake(0, 0, 100, 100);
    [self.view.layer addSublayer:layer];

    UIControl * control = [[UIControl alloc] initWithFrame:CGRectMake(105, 0, 100, 100)];
    control.backgroundColor = [UIColor blueColor];
    CALayer * controlLayer = [CALayer layer];
    controlLayer.frame = CGRectMake(10, 10, 80, 80);
    controlLayer.backgroundColor = [[UIColor redColor] CGColor];
    [control.layer addSublayer:controlLayer];
    [self.view addSubview:control];
    
}



- (void)viewDidLayoutSubviews{
    
}
- (void)layoutSublayersOfLayer:(CALayer *)layer{
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end

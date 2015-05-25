//
//  ViewController.m
//  CoreAnimationDome
//
//  Created by lbencs on 15/5/19.
//  Copyright (c) 2015年 lbencs. All rights reserved.
//

#import "ViewController.h"
//#import <QuartzCore/QuartzCore.h>

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
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

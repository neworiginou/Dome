//
//  ViewController.m
//  CoreAnimationDome
//
//  Created by lbencs on 15/5/19.
//  Copyright (c) 2015年 lbencs. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    CALayer * layer = [CALayer layer];
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
    UIView;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

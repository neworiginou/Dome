//
//  ViewController.m
//  OOOTabSliderViewController
//
//  Created by lben on 15/7/29.
//  Copyright (c) 2015年 lben. All rights reserved.
//

#import "ViewController.h"
#import "OOOViewController.h"
#import "OOOTabSliderViewController.h"

@interface ViewController ()
@property (strong, nonatomic) OOOTabSliderViewController * sliderViewController;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    OOOViewController * vc1 = [[OOOViewController alloc] init];
    vc1.title = @"tab1";
    vc1.view.backgroundColor = [UIColor redColor];
    
    OOOViewController * vc2 = [[OOOViewController alloc] init];
    vc2.title = @"tab2";
    vc2.view.backgroundColor = [UIColor grayColor];
    
    OOOTabSliderViewController * sliderViewController = [[OOOTabSliderViewController alloc] init];
    sliderViewController.subViewController = @[vc1,vc2];
    self.sliderViewController = sliderViewController;
}

- (void)viewWillLayoutSubviews{
    [super viewWillLayoutSubviews];
}


- (void)viewDidLayoutSubviews{
    [super viewDidLayoutSubviews];
    [self.sliderViewController addParentController:self];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

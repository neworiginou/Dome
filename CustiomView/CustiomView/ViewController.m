//
//  ViewController.m
//  CustiomView
//
//  Created by lbencs on 15/4/17.
//  Copyright (c) 2015年 lbencs. All rights reserved.
//

#import "ViewController.h"

#import "CustomView.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    CustomView * c = [[CustomView alloc] initWithFrame:CGRectMake(0, 0, 200, 200)];
    c.backgroundColor = [UIColor yellowColor];
    [self.view addSubview:c];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

//
//  ViewController.m
//  ViewWillApperance
//
//  Created by lben on 15/7/20.
//  Copyright © 2015年 lben. All rights reserved.
//

#import "ViewController.h"
#import "ContainerViewController.h"
@interface ViewController (){
    ContainerViewController * _containerViewController;
}

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
//    [headerViewController willMoveToParentViewController:self];
//    [headerViewController beginAppearanceTransition:YES animated:NO];
//    headerViewController.myParentViewController = self;
//    [view addSubview:headerViewController.view];
//    [headerViewController didMoveToParentViewController:self];
//    [headerViewController endAppearanceTransition];
    
    ContainerViewController * containerViewController = [[ContainerViewController alloc] init];
    containerViewController.view.frame = self.view.bounds;
    [containerViewController willMoveToParentViewController:self];
    [containerViewController beginAppearanceTransition:YES animated:NO];
    [self.view addSubview:containerViewController.view];
    [containerViewController didMoveToParentViewController:self];
    [containerViewController endAppearanceTransition];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end

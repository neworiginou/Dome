//
//  XIBDetailViewController.m
//  DynamicNavigationBarDome
//
//  Created by lben on 15/5/25.
//  Copyright (c) 2015年 lben. All rights reserved.
//

#import "XIBDetailViewController.h"
#import "UINavigationController+TVTTNavigationControllerTransform.h"

@interface XIBDetailViewController ()

@end

@implementation XIBDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.navigationController.view.backgroundColor = [UIColor redColor];
    
//    CALayer * layer = [CALayer layer];
//    layer.frame = self.view.bounds;
//    layer.backgroundColor = [UIColor yellowColor].CGColor;
//    [self.navigationController.view.layer addSublayer:layer];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}



/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end

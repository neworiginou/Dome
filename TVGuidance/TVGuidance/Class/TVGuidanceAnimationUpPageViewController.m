//
//  TVGuidanceAnimationUpPageViewController.m
//  TVGuidance
//
//  Created by lben on 15/7/13.
//  Copyright (c) 2015年 lben. All rights reserved.
//

#import "TVGuidanceAnimationUpPageViewController.h"

@interface TVGuidanceAnimationUpPageViewController (){
    
    __weak IBOutlet UIImageView *left_1_ImageView;
}

@end

@implementation TVGuidanceAnimationUpPageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    CABasicAnimation * animation = [CABasicAnimation animation];
    animation.keyPath = @"";
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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

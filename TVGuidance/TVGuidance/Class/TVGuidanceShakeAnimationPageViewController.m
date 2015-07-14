//
//  TVGuidanceShakeAnimationPageViewController.m
//  TVGuidance
//
//  Created by lben on 15/7/14.
//  Copyright © 2015年 lben. All rights reserved.
//

#import "TVGuidanceShakeAnimationPageViewController.h"

#import "TVTTShakeView.h"

@interface TVGuidanceShakeAnimationPageViewController (){
    
    __weak IBOutlet TVTTShakeView *_view_1;
    __weak IBOutlet TVTTShakeView *_view_2;
    __weak IBOutlet TVTTShakeView *_view_3;
    __weak IBOutlet TVTTShakeView *_view_4;
}

@end

@implementation TVGuidanceShakeAnimationPageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}
- (void)startAnimation{
    if (self.isAnimationed) {
        return;
    }
    [_view_1 addAnimationAndRemoveOnCompletion:YES completion:^(BOOL finished) {}];
    [_view_2 addAnimationAndRemoveOnCompletion:YES completion:^(BOOL finished) {}];
    [_view_3 addAnimationAndRemoveOnCompletion:YES completion:^(BOOL finished) {}];
    [_view_4 addAnimationAndRemoveOnCompletion:YES completion:^(BOOL finished) {}];
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

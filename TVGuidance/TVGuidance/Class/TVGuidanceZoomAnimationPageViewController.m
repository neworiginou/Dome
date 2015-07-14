//
//  TVGuidanceZoomAnimationPageViewController.m
//  TVGuidance
//
//  Created by lben on 15/7/14.
//  Copyright © 2015年 lben. All rights reserved.
//

#import "TVGuidanceZoomAnimationPageViewController.h"
#import "TVTTZoomView.h"

@interface TVGuidanceZoomAnimationPageViewController (){
    
    __weak IBOutlet TVTTZoomView *_view_1;
    __weak IBOutlet TVTTZoomView *_view_2;
    __weak IBOutlet TVTTZoomView *_view_3;
    __weak IBOutlet TVTTZoomView *_view_4;
    __weak IBOutlet TVTTZoomView *_view_5;
}

@end

@implementation TVGuidanceZoomAnimationPageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}
- (void)startAnimation{
    if (self.isAnimationed) {
        return;
    }
    [_view_5 addAnimationAndRemoveOnCompletion:YES completion:^(BOOL finished) {}];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.05 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [_view_4 addAnimationAndRemoveOnCompletion:YES completion:^(BOOL finished) {}];
    });
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.10 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [_view_3 addAnimationAndRemoveOnCompletion:YES completion:^(BOOL finished) {}];
    });
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.15 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [_view_1 addAnimationAndRemoveOnCompletion:YES completion:^(BOOL finished) {}];
    });
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.20 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [_view_2 addAnimationAndRemoveOnCompletion:YES completion:^(BOOL finished) {}];
    });
    
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

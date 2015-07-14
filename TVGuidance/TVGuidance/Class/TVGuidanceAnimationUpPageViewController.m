//
//  TVGuidanceAnimationUpPageViewController.m
//  TVGuidance
//
//  Created by lben on 15/7/13.
//  Copyright (c) 2015年 lben. All rights reserved.
//

#import "TVGuidanceAnimationUpPageViewController.h"
#import "TVTTPathView.h"

@interface TVGuidanceAnimationUpPageViewController (){
    
    __weak IBOutlet UIImageView *left_1_ImageView;
    __weak IBOutlet TVTTPathView *_left_1_view;
    __weak IBOutlet TVTTPathView *_left_2_view;
    __weak IBOutlet TVTTPathView *_left_3_view;
    __weak IBOutlet TVTTPathView *_right_2_view;
    __weak IBOutlet TVTTPathView *_right_1_view;
}

@end

@implementation TVGuidanceAnimationUpPageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [_left_1_view setStartDirection:TVTTPathDirectionRightBottom endDirection:TVTTPathDirectionLeftTop];
    [_left_2_view setStartDirection:TVTTPathDirectionRightBottom endDirection:TVTTPathDirectionLeftTop];
    [_left_3_view setStartDirection:TVTTPathDirectionRightBottom endDirection:TVTTPathDirectionLeftTop];
    [_right_1_view setStartDirection:TVTTPathDirectionLeftBottom endDirection:TVTTPathDirectionRightTop];
    [_right_2_view setStartDirection:TVTTPathDirectionLeftBottom endDirection:TVTTPathDirectionRightTop];
    
    [self startAnimation];
}

- (void)startAnimation{
    [_left_1_view addPathAnimationAndRemoveOnCompletion:YES completion:^(BOOL finished) {}];
    [_left_2_view addPathAnimationAndRemoveOnCompletion:YES completion:^(BOOL finished) {}];
    [_left_3_view addPathAnimationAndRemoveOnCompletion:YES completion:^(BOOL finished) {}];
    [_right_1_view addPathAnimationAndRemoveOnCompletion:YES completion:^(BOOL finished) {}];
    [_right_2_view addPathAnimationAndRemoveOnCompletion:YES completion:^(BOOL finished) {}];
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

//
//  TVGuidanceXXZoomAnimationPageViewController.m
//  TVGuidance
//
//  Created by lben on 15/7/14.
//  Copyright © 2015年 lben. All rights reserved.
//

#import "TVGuidanceXXZoomAnimationPageViewController.h"

#import "TVTTZoomView.h"

@interface TVGuidanceXXZoomAnimationPageViewController (){
    __weak IBOutlet TVTTZoomView * _view_1;
    __weak IBOutlet TVTTZoomView * _view_2;
    __weak IBOutlet TVTTZoomView * _view_3;
    __weak IBOutlet TVTTZoomView * _view_4;
    __weak IBOutlet TVTTZoomView * _view_5;
    __weak IBOutlet TVTTZoomView * _view_6;
    __weak IBOutlet UIButton *button;
}

@end

@implementation TVGuidanceXXZoomAnimationPageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [button setImage:[UIImage imageNamed:@"guidance_btn_normal"] forState:UIControlStateNormal];
    [button setImage:[UIImage imageNamed:@"guidance_btn_pre"] forState:UIControlStateHighlighted];
}
- (void)startAnimation{
    if (self.isAnimationed) {
        return;
    }
    [_view_1 addAnimationAndRemoveOnCompletion:YES completion:^(BOOL finished) {}];
    [_view_2 addAnimationAndRemoveOnCompletion:YES completion:^(BOOL finished) {}];
    [_view_3 addAnimationAndRemoveOnCompletion:YES completion:^(BOOL finished) {}];
    [_view_4 addAnimationAndRemoveOnCompletion:YES completion:^(BOOL finished) {}];
    [_view_5 addAnimationAndRemoveOnCompletion:YES completion:^(BOOL finished) {}];
    [_view_6 addAnimationAndRemoveOnCompletion:YES completion:^(BOOL finished) {}];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)btnClick:(id)sender {
}

@end

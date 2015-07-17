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
    __strong IBOutletCollection(id) NSArray * _animationViews;
 }

@end

@implementation TVGuidanceZoomAnimationPageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}
- (void)startAnimation{
    if (self.isAnimationed) return;
    [_animationViews enumerateObjectsUsingBlock:^(TVTTZoomView  *obj, NSUInteger idx, BOOL * __nonnull stop) {
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.05 * obj.tag * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [obj addAnimation];
        });
    }];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end

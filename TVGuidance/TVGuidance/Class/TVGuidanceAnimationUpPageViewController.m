//
//  TVGuidanceAnimationUpPageViewController.m
//  TVGuidance
//
//  Created by lben on 15/7/13.
//  Copyright (c) 2015年 lben. All rights reserved.
//

#import "TVGuidanceAnimationUpPageViewController.h"
#import "TVTTPathView.h"


#define suffix @[@"iphone4",@"iphone5"]
#define NSStringWithDifferentIphone(NSString) [NSString stringByAppendingString:[[UIScreen mainScreen] bounds].size.height == 480 ? suffix[0]:suffix[1]]

@interface TVGuidanceAnimationUpPageViewController (){
    __strong IBOutletCollection(id) NSArray * _animationViews;
    __weak IBOutlet UIImageView *_backgroundImageView;
}
@end

@implementation TVGuidanceAnimationUpPageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _backgroundImageView.image = [UIImage imageNamed:NSStringWithDifferentIphone(@"guidance_background_image_page_1_")];
}
- (void)startAnimation{
    if (self.isAnimationed) return;
    [_animationViews enumerateObjectsUsingBlock:^(TVTTPathView * obj, NSUInteger idx, BOOL * stop) {
        if (obj.tag == 0) {
            [obj setStartDirection:TVTTPathDirectionRightBottom endDirection:TVTTPathDirectionLeftTop];
        }else{
            [obj setStartDirection:TVTTPathDirectionLeftBottom endDirection:TVTTPathDirectionRightTop];
        }
        [obj addAnimation];
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end

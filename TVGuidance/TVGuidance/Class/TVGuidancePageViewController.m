//
//  TVGuidancePageViewController.m
//  TVGuidance
//
//  Created by lben on 15/6/15.
//  Copyright (c) 2015年 lben. All rights reserved.
//

#import "TVGuidancePageViewController.h"


#define Iphone_4 [UIScreen mainScreen].bounds.size.width == 320

@interface TVGuidancePageViewController ()
@property (weak, nonatomic) UIImageView * backgorundImageView;

@property (weak, nonatomic) UIImageView * centerTextImageView;

//home
@property (weak, nonatomic) UIImageView * homeLogImageView;
@property (weak, nonatomic) UIImageView * homeLaunchImageTextView;
@property (weak, nonatomic) UIImageView * homeLaunchBottomLogView;
@property (weak, nonatomic) UIButton * homeLaunchBottomButtonView;


@end

@implementation TVGuidancePageViewController

- (instancetype)initWithIndex:(NSInteger)index pageType:(TVGuidancePageType)pageType{
    self = [super init];
    if (self) {
        _index = index;
        _pageType = pageType;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self pMakeView];
}

- (void)pMakeView{
    
    [self pMakeBackgroundImageView];
    
    if (_pageType == TVGuidancePageTypeLaunchHome) {
        [self pMakeEnterPageView];
        
        self.centerTextImageView.hidden = YES;
        
        self.homeLogImageView.hidden = NO;
        self.homeLaunchImageTextView.hidden = NO;
        self.homeLaunchBottomLogView.hidden = NO;
        self.homeLaunchBottomButtonView.hidden = NO;
    }else if (_pageType == TVGuidancePageTypeLaunch){
        [self pMakeLaunch];
        
        self.centerTextImageView.hidden = NO;

        self.homeLogImageView.hidden = YES;
        self.homeLaunchImageTextView.hidden = YES;
        self.homeLaunchBottomLogView.hidden = YES;
        self.homeLaunchBottomButtonView.hidden = YES;
    }
}

- (void)updatePageWithIndex:(NSInteger)index pageType:(TVGuidancePageType)pageType{
    _index = index;
    _pageType = pageType;
    [self pMakeView];
}

- (void)showAnimationWithDuration:(CGFloat)duration{
    [UIView animateWithDuration:duration animations:^{
        if (_pageType == TVGuidancePageTypeLaunch) {
            self.centerTextImageView.alpha = 1;
        }else{
            self.homeLogImageView.alpha = 1;
            self.homeLaunchBottomLogView.alpha = 1;
            self.homeLaunchImageTextView.alpha = 1;
            self.homeLaunchBottomButtonView.alpha = 1;
        }
    }];
}
- (void)hiddenAnimationViews{
    if (_pageType == TVGuidancePageTypeLaunch) {
        self.centerTextImageView.alpha = 0;
    }else{
        self.homeLogImageView.alpha = 0;
        self.homeLaunchBottomLogView.alpha = 0;
        self.homeLaunchImageTextView.alpha = 0;
        self.homeLaunchBottomButtonView.alpha = 0;
    }
 }

- (void)pMakeBackgroundImageView{
    
    if (!self.backgorundImageView) {
        UIImageView * imageView = ({
            UIImageView * imageView = [[UIImageView alloc] initWithFrame:self.view.bounds];
            [self.view addSubview:imageView];
            imageView;
        });
        self.backgorundImageView = imageView;
    }
    NSString * backgroundImage = @"launch_homeImage_page_";
    backgroundImage = [backgroundImage stringByAppendingFormat:@"%d_",_index+1];
    if (Iphone_4) {
        backgroundImage = [backgroundImage stringByAppendingString:@"iphone4"];
    }else{
        backgroundImage = [backgroundImage stringByAppendingString:@"iphone5"];
    }
    self.backgorundImageView.image = [UIImage imageNamed:backgroundImage];
}

- (void)pMakeLaunch{
    CGFloat centerTextImageViewWidth = 120.0;
    CGFloat centerTextImageViewHeight = 0;
    NSString * centerTextImageName = @"launch_center_text_";
    
    centerTextImageName = [centerTextImageName stringByAppendingFormat:@"%d_",_index+1];
    if (Iphone_4) {
        if (_index < 2) {
            centerTextImageViewHeight = 335.0;
        }else{
            centerTextImageViewHeight = 365.0;
        }
        centerTextImageName = [centerTextImageName stringByAppendingString:@"iphone4"];
    }else{
        if (_index < 2) {
            centerTextImageViewHeight = 350.0;
        }else{
            centerTextImageViewHeight = 375.0;
        }
        centerTextImageName = [centerTextImageName stringByAppendingString:@"iphone5"];
    }
    
    if (!self.centerTextImageView) {
        UIImageView * imageView = ({
            UIImageView * imageView = [[UIImageView alloc] init];
            imageView.alpha = 0;
            imageView.translatesAutoresizingMaskIntoConstraints = NO;
            [self.view addSubview:imageView];
            [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:[imageView(==centerTextImageViewWidth)]" options:0 metrics:@{@"centerTextImageViewWidth":@(centerTextImageViewWidth)} views:NSDictionaryOfVariableBindings(imageView)]];
            [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-0-[imageView(==centerTextImageViewHeight)]" options:0 metrics:@{@"centerTextImageViewHeight":@(centerTextImageViewHeight)} views:NSDictionaryOfVariableBindings(imageView)]];
            [self.view addConstraint:[NSLayoutConstraint constraintWithItem:imageView attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeCenterX multiplier:1.0f constant:0]];
            imageView;
        });
        self.centerTextImageView = imageView;
    }
    self.centerTextImageView.image = [UIImage imageNamed:centerTextImageName];
}

- (void)pMakeEnterPageView{
    
    CGFloat topPadding = 0;
    CGFloat bottomPadding = 0;
    CGFloat bottomlogBottomButtonPadding = 0;
    if (Iphone_4) {
        topPadding = 33;
        bottomPadding = 21;
        bottomlogBottomButtonPadding = 8;
    }else{
        topPadding = 59;
        bottomPadding = 32;
        bottomlogBottomButtonPadding = 18;
    }
    
    UIImageView * imageView = nil;
    if (!self.homeLogImageView) {
        imageView = ({
            UIImageView * imageView = [[UIImageView alloc] init];
            imageView.translatesAutoresizingMaskIntoConstraints = NO;
            imageView.alpha = 0;
            [self.view addSubview:imageView];
            [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:[imageView(==78)]" options:0 metrics:nil views:NSDictionaryOfVariableBindings(imageView)]];
            [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-topPadding-[imageView(==78)]" options:0 metrics:@{@"topPadding":@(topPadding)} views:NSDictionaryOfVariableBindings(imageView)]];
            [self.view addConstraint:[NSLayoutConstraint constraintWithItem:imageView attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeCenterX multiplier:1.0f constant:0]];
            imageView.image = [UIImage imageNamed:@"launch_limage_log"];
            imageView;
        });
        self.homeLogImageView = imageView;
    }

    if (!self.homeLaunchImageTextView) {
        imageView = ({
            UIImageView * imageView = [[UIImageView alloc] init];
            imageView.translatesAutoresizingMaskIntoConstraints = NO;
            imageView.alpha = 0;
            [self.view addSubview:imageView];
            [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:[imageView(==149)]" options:0 metrics:nil views:NSDictionaryOfVariableBindings(imageView)]];
            [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[_homeLogImageView]-15-[imageView(==23)]" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_homeLogImageView, imageView)]];
            [self.view addConstraint:[NSLayoutConstraint constraintWithItem:imageView attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeCenterX multiplier:1.0f constant:0]];
            imageView.image = [UIImage imageNamed:@"launch_home_icon_text"];
            imageView;
        });
        self.homeLaunchImageTextView = imageView;
    }
    
    if (!self.homeLaunchBottomButtonView) {
        imageView = ({
            UIImageView * imageView = [[UIImageView alloc] init];
            imageView.translatesAutoresizingMaskIntoConstraints = NO;
            imageView.alpha = 0;
            [self.view addSubview:imageView];
            [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:[imageView(==295)]" options:0 metrics:nil views:NSDictionaryOfVariableBindings(imageView)]];
            [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[imageView(==31)]-bottomPadding-|" options:0 metrics:@{@"bottomPadding":@(bottomPadding)} views:NSDictionaryOfVariableBindings(imageView)]];
            [self.view addConstraint:[NSLayoutConstraint constraintWithItem:imageView attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeCenterX multiplier:1.0f constant:0]];
            imageView.image = [UIImage imageNamed:@"launch_home_jfz_logo"];
            imageView;
        });
        self.homeLaunchBottomLogView = imageView;
    }
    
    if (!self.homeLaunchBottomButtonView) {
        UIButton * button = ({
            UIButton * button = [UIButton buttonWithType:UIButtonTypeCustom];
            button.alpha = 0;
            button.translatesAutoresizingMaskIntoConstraints = NO;
            [self.view addSubview:button];
            [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:[button(==295)]" options:0 metrics:nil views:NSDictionaryOfVariableBindings(button)]];
            [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[button(==51)]-bottomlogBottomButtonPadding-[_homeLaunchBottomLogView]" options:0 metrics:@{@"bottomlogBottomButtonPadding":@(bottomlogBottomButtonPadding)} views:NSDictionaryOfVariableBindings(_homeLaunchBottomLogView,button)]];
            [self.view addConstraint:[NSLayoutConstraint constraintWithItem:button attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeCenterX multiplier:1.0f constant:0]];
            [button setImage:[UIImage imageNamed:@"launch_bottom_button_press"] forState:UIControlStateHighlighted];
            [button setImage:[UIImage imageNamed:@"launch_bottom_button_normal"] forState:UIControlStateNormal];
            button;
        });
        self.homeLaunchBottomButtonView = button;
    }
}

- (UIImage *)imageWithName:(NSString *)imageName{
    NSString * path = [[NSBundle mainBundle] pathForResource:imageName ofType:@"png"];
    UIImage * image = [UIImage imageWithContentsOfFile:path];
    return image;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

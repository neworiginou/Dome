//
//  ViewController.m
//  UIScrollViewAutolayoutDome
//
//  Created by lbencs on 12/23/14.
//  Copyright (c) 2014 lbencs. All rights reserved.
//

#import "ViewController.h"



@interface ViewController ()
@property (weak, nonatomic) IBOutlet UIView *contentView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [[UIDevice currentDevice] beginGeneratingDeviceOrientationNotifications];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(deviceOrientationDidChange:)
                                                 name:UIDeviceOrientationDidChangeNotification
                                               object:nil];
    
    NSLayoutConstraint *leftEdgeAlign = [NSLayoutConstraint constraintWithItem:self.contentView
                                                                     attribute:NSLayoutAttributeLeading
                                                                     relatedBy:0
                                                                        toItem:self.view
                                                                     attribute:NSLayoutAttributeLeft
                                                                    multiplier:1.0f
                                                                      constant:0];
    NSLayoutConstraint *rightEdgeAlign = [NSLayoutConstraint constraintWithItem:self.contentView
                                                                      attribute:NSLayoutAttributeTrailing
                                                                      relatedBy:0
                                                                         toItem:self.view
                                                                      attribute:NSLayoutAttributeRight
                                                                     multiplier:1.0f
                                                                       constant:0];
//    NSLayoutConstraint *topEdgeAlign = [NSLayoutConstraint constraintWithItem:self.contentView
//                                                                    attribute:NSLayoutAttributeTop
//                                                                    relatedBy:0
//                                                                       toItem:self.view
//                                                                    attribute:NSLayoutAttributeTop
//                                                                   multiplier:1.0f
//                                                                     constant:0];
//    NSLayoutConstraint *bottomEdgeAlign = [NSLayoutConstraint constraintWithItem:self.contentView
//                                                                    attribute:NSLayoutAttributeBottom
//                                                                    relatedBy:0
//                                                                       toItem:self.view
//                                                                    attribute:NSLayoutAttributeBottom
//                                                                   multiplier:1.0f
//                                                                     constant:0];
    
    [self.view addConstraints:@[leftEdgeAlign,rightEdgeAlign]];
}

//- willanimate

- (void)deviceOrientationDidChange:(NSNotification *)notification{
    UIDevice* device = [notification valueForKey:@"object"];
    NSLog(@"%d",device.orientation);
    switch (device.orientation) {
        case UIDeviceOrientationPortrait:
        case UIDeviceOrientationPortraitUpsideDown:
        {
            
        }
            break;
        case UIDeviceOrientationLandscapeLeft:
        case UIDeviceOrientationLandscapeRight:
        {
            
        }
            break;
        default:
            break;
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

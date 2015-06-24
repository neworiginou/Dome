//
//  ViewController.m
//  UIScrollViewAutolayoutDome
//
//  Created by lbencs on 12/23/14.
//  Copyright (c) 2014 lbencs. All rights reserved.
//

#import "ViewController.h"



@interface ViewController ()
@property (weak, nonatomic) IBOutlet UIView    * contentView;
@property (weak, nonatomic) UITextField        * activeTextField;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *constraint;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [[UIDevice currentDevice] beginGeneratingDeviceOrientationNotifications];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(deviceOrientationDidChange:)
                                                 name:UIDeviceOrientationDidChangeNotification
                                               object:nil];
}

- (void)viewWillAppear:(BOOL)animated{
    [self registerForKeyboardNotifications];
}
- (void)viewWillDisappear:(BOOL)animated{
    [self deregisterFromKeyboardNotifications];
}

- (void)viewDidLayoutSubviews{
    [super viewDidLayoutSubviews];
    self.scrollView.contentSize = self.contentView.bounds.size;
    [self.view setNeedsLayout];
}

- (void)registerForKeyboardNotifications{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWasShown:) name:UIKeyboardDidShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillBeHidden:) name:UIKeyboardWillHideNotification object:nil];
}
- (void)deregisterFromKeyboardNotifications{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardDidShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillHideNotification object:nil];
}

- (void)keyboardWasShown:(NSNotification *)notification{
    NSDictionary *userInfo = [notification userInfo];
    CGRect keyboardRect = [[userInfo objectForKey:UIKeyboardFrameBeginUserInfoKey] CGRectValue];
    keyboardRect = [self.view convertRect:keyboardRect fromView:nil];
    
    UIEdgeInsets contentInsets = UIEdgeInsetsMake(0.0, 0.0, keyboardRect.size.height, 0.0);
    self.scrollView.contentInset = contentInsets;
    self.scrollView.scrollIndicatorInsets = contentInsets;
    
    CGRect screenRect = self.view.frame;
    screenRect.size.height -= keyboardRect.size.height;
    if (!CGRectContainsPoint(screenRect, self.activeTextField.frame.origin) ) {
        [self.scrollView scrollRectToVisible:self.activeTextField.frame animated:YES];
    }
}
- (void)keyboardWillBeHidden:(NSNotification *)notification{
    UIEdgeInsets contentInsets = UIEdgeInsetsZero;
    self.scrollView.contentInset = contentInsets;
    self.scrollView.scrollIndicatorInsets = contentInsets;
}




- (void)textFieldDidBeginEditing:(UITextField *)textField{
    self.activeTextField = textField;
}
- (void)textFieldDidEndEditing:(UITextField *)textField{
    self.activeTextField = nil;
}

- (void)deviceOrientationDidChange:(NSNotification *)notification{
    UIDevice* device = [notification valueForKey:@"object"];
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

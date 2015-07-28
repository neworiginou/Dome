//
//  TVTPopUpWindowViewController.m
//  TVTPopUpWindow
//
//  Created by lbencs on 15/7/24.
//  Copyright © 2015年 lbencs. All rights reserved.
//

#import "TVTPopUpWindowViewController.h"

static CGFloat const kTVTPopUpWindowViewControllerViewUpTime = 0.3;
static CGFloat const kTVTPopUpWindowViewControllerViewUpSpace = 100;

@interface TVTPopUpWindowViewController ()
@property (weak, nonatomic) UITapGestureRecognizer * tapGestureRecognizer;
@property (assign, nonatomic) CGFloat keyboardHeight;
@property (weak, nonatomic) UIView * contentView;

@property (assign, nonatomic) BOOL keyboardIsShow;
@end

@implementation TVTPopUpWindowViewController


#pragma mark - life cycle

- (void)viewDidLoad {
    [super viewDidLoad];
//    [self tvtt_makeUp];
}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self tvtt_addNotification];
    [self tvtt_addGesture];
}
- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [self tvtt_removeNotification];
    [self tvtt_removeGesture];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - Notification Keyboard Action
- (void)tvtt_keyboardWillShow:(NSNotification *)notif{
    if (self.keyboardIsShow) {
        return;
    }
    self.keyboardIsShow = YES;
    [self tvtt_upView];
}
- (void)tvtt_keyboardWillHiden:(NSNotification *)notif{
    self.keyboardIsShow = NO;
}

#pragma mark - Notification UITextField Action
- (void)tvtt_textFieldWillBeginEdit:(NSNotification *)notif{
    if (self.keyboardIsShow) {
        return;
    }
    self.keyboardIsShow = YES;
    [self tvtt_upView];
}


#pragma mark - Gesture Action
- (void)tvtt_handleTapGesture:(UITapGestureRecognizer *)tapGesutureRecognizer{
    [self tvtt_downView];
    [[UIApplication sharedApplication] sendAction:@selector(resignFirstResponder) to:nil from:nil forEvent:nil];
}

#pragma mark - view animation

- (void)tvtt_upView{
    [UIView animateWithDuration:kTVTPopUpWindowViewControllerViewUpTime
                     animations:^{
                         self.view.transform = CGAffineTransformMakeTranslation(0, -kTVTPopUpWindowViewControllerViewUpSpace);
                     }];
}
- (void)tvtt_downView{
    [UIView animateWithDuration:kTVTPopUpWindowViewControllerViewUpTime
                     animations:^{
                         self.view.transform = CGAffineTransformIdentity;
                     }];
}

#pragma mark - NSNotification
- (void)tvtt_addNotification{
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(tvtt_textFieldWillBeginEdit:)
                                                 name:UITextFieldTextDidBeginEditingNotification
                                               object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(tvtt_keyboardWillShow:)
                                                 name:UIKeyboardWillShowNotification
                                               object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(tvtt_keyboardWillHiden:)
                                                 name:UIKeyboardWillHideNotification
                                               object:nil];
}
- (void)tvtt_removeNotification{
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:UITextFieldTextDidBeginEditingNotification
                                                  object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:UIKeyboardWillShowNotification
                                                  object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:UIKeyboardWillHideNotification
                                                  object:nil];
}

#pragma mark - UIGestureRecognizer
- (void)tvtt_addGesture{
    UITapGestureRecognizer * tapGestureReognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tvtt_handleTapGesture:)];
    [self.view addGestureRecognizer:tapGestureReognizer];
    self.tapGestureRecognizer = tapGestureReognizer;
}
- (void)tvtt_removeGesture{
    [self.view removeGestureRecognizer:_tapGestureRecognizer];
}


#pragma mark - UI
- (void)tvtt_makeUp{
    UIView * uiview = ({
        UIView * view = [[UIView alloc] init];
        view.backgroundColor = [UIColor redColor];
        UITextField * textField = ({
            UITextField * textField = [[UITextField alloc] initWithFrame:CGRectMake(10, 150, 280, 44)];
            textField.backgroundColor = [UIColor whiteColor];
            textField.borderStyle = UITextBorderStyleRoundedRect;
            textField;
        });
        [view addSubview:textField];
        [self.view addSubview:view];
        view.translatesAutoresizingMaskIntoConstraints = NO;
        [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:[view(==300)]" options:0 metrics:nil views:NSDictionaryOfVariableBindings(view)]];
        [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[view(==200)]" options:0 metrics:nil views:NSDictionaryOfVariableBindings(view)]];
        [self.view addConstraint:[NSLayoutConstraint constraintWithItem:view attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeCenterX multiplier:1.0 constant:0.0]];
        [self.view addConstraint:[NSLayoutConstraint constraintWithItem:view attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeCenterY multiplier:1.0 constant:0.0]];
        view;
    });
    self.contentView = uiview;
}


@end

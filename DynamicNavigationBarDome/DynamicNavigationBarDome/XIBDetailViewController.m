//
//  XIBDetailViewController.m
//  DynamicNavigationBarDome
//
//  Created by lben on 15/5/25.
//  Copyright (c) 2015年 lben. All rights reserved.
//

#import "XIBDetailViewController.h"
#import "UINavigationController+TVTTNavigationControllerTransform.h"
#import "UIViewController+BackButtonHandler.h"

@interface XIBDetailViewController ()

@end

@implementation XIBDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.edgesForExtendedLayout = UIRectEdgeNone;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

-(BOOL) navigationShouldPopOnBackButton ///在这个方法里写返回按钮的事
{
    
    [self.navigationController tvtt_popViewControllerAnimated:YES];
    
    return YES;
    
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

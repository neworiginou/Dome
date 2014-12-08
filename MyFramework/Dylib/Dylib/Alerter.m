//
//  Alerter.m
//  Dylib
//
//  Created by wentaolu on 14/12/8.
//  Copyright (c) 2014年 wentaolu. All rights reserved.
//

#import "Alerter.h"

@implementation Alerter
- (void)show{
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Framewrok" message:@"message" delegate:nil cancelButtonTitle:@"cancel" otherButtonTitles:nil];
    [alertView show];
}
@end

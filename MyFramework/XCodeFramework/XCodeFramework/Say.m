//
//  Say.m
//  XCodeFramework
//
//  Created by lbencs on 12/9/14.
//  Copyright (c) 2014 lbencs. All rights reserved.
//

#import "Say.h"

@implementation Say
- (void)say{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"title" message:@"message" delegate:nil cancelButtonTitle:@"cancel" otherButtonTitles:nil];
    [alert show];
}
@end

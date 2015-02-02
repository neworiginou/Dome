//
//  FirstViewController.m
//  DynamicCreateObj
//
//  Created by lbencs on 1/26/15.
//  Copyright (c) 2015 lbencs. All rights reserved.
//

#import "FirstViewController.h"
#import <objc/runtime.h>


@interface FirstViewController ()

@end

@implementation FirstViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    Class newClass = objc_allocateClassPair([UIView class], "CustomView", 0);
    class_addMethod(newClass, @selector(systemOut), (IMP)SystemOutFunction, "V@:");
    objc_registerClassPair(newClass);
    
    id instance = [[newClass alloc] init];
    
    [instance performSelector:@selector(systemOut)];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

void SystemOutFunction(id self, SEL _cmd){
    NSLog(@"hello");
}
@end

//
//  AppDelegate.h
//  XMAppDome
//
//  Created by lbencs on 12/26/14.
//  Copyright (c) 2014 lbencs. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZXLYMessageCenter.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (readonly ,strong, nonatomic) ZXLYMessageCenter *messageCenter;

@end


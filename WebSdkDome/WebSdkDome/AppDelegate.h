//
//  AppDelegate.h
//  快速继承新浪微博
//
//  Created by 毛志 on 14-6-24.
//  Copyright (c) 2014年 maozhi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SinaWeibo.h"

#define kAppKey             @"996540367"
#define kAppSecret          @"fd09de3e744475631099e072ea5e0a73"
#define kAppRedirectURI     @"https://api.weibo.com/oauth2/default.html"

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (strong, nonatomic) SinaWeibo * sinaweibo;

@end

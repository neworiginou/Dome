//
//  ZXLYBuddyManagerBuddyDelegate.h
//  XMAppDome
//
//  Created by lbencs on 1/3/15.
//  Copyright (c) 2015 lbencs. All rights reserved.
//

#import <Foundation/Foundation.h>

@class ZXLYBuddyManager;

@protocol ZXLYBuddyManagerBuddyDelegate <NSObject>

- (void)buddyManager:(ZXLYBuddyManager *)buddyManager newBuddyOnLine:(NSString *)buddyName;
- (void)buddyManager:(ZXLYBuddyManager *)buddyManager newBuddyOffLine:(NSString *)buddyName;

@end

//
//  TVTSwitBehavior.h
//  InteractionAnimationDome
//
//  Created by lbencs on 15/7/21.
//  Copyright © 2015年 lbencs. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TVTSwitBehavior : UIDynamicBehavior

@property (nonatomic) CGPoint targetPoint;
@property (nonatomic) CGPoint velocity;

- (instancetype)initWithItem:(id<UIDynamicItem>)item;

@end

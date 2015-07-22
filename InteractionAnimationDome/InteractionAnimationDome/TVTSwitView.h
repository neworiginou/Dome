//
//  TVTSwitView.h
//  InteractionAnimationDome
//
//  Created by lbencs on 15/7/21.
//  Copyright © 2015年 lbencs. All rights reserved.
//

#import <UIKit/UIKit.h>

@class TVTSwitView;

@protocol TVTSwitViewDelegate <NSObject>
- (void)switView:(TVTSwitView *)view switEndedWithVelocity:(CGPoint)velocity;
- (void)switViewBeginSwitting:(TVTSwitView *)view;
@end

@interface TVTSwitView : UIView
@property (weak, nonatomic) IBOutlet id <TVTSwitViewDelegate> delegate;
@end

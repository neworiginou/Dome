//
//  TVTMeasureSlider.h
//  TVTMeasureSlider
//
//  Created by lben on 15/7/28.
//  Copyright (c) 2015年 lben. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TVTMeasureSlider : UIView
- (void)setMeasureCallBack:(void(^)(CGFloat))measureCallBack;
@end

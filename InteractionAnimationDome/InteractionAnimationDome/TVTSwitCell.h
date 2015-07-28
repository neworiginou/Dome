//
//  TVTSwitCell.h
//  InteractionAnimationDome
//
//  Created by lbencs on 15/7/21.
//  Copyright © 2015年 lbencs. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, TVTSwitCellState) {
    TVTSwitCellStateRecover,  //恢复
    TVTSwitCellStateRemove, //删除
};

@interface TVTSwitCell : UITableViewCell
@property (readonly ,assign, nonatomic) TVTSwitCellState cellState;
@end

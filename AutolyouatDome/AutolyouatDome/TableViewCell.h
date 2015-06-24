//
//  TableViewCell.h
//  AutolyouatDome
//
//  Created by lbencs on 15/6/23.
//  Copyright © 2015年 lbencs. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *myLabel;
+ (UINib *)nib;
@end

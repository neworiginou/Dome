//
//  TableViewCell.h
//  AutoLayoutTableViewDome
//
//  Created by lbencs on 1/28/15.
//  Copyright (c) 2015 lbencs. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *contextLabel;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;

@end

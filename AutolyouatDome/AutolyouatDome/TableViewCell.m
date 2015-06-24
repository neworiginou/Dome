//
//  TableViewCell.m
//  AutolyouatDome
//
//  Created by lbencs on 15/6/23.
//  Copyright © 2015年 lbencs. All rights reserved.
//

#import "TableViewCell.h"

@implementation TableViewCell

- (void)awakeFromNib {
    // Initialization code
}
+ (UINib *)nib{
    return [UINib nibWithNibName:@"TableViewCell" bundle:nil];
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end

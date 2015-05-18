//
//  TUTBaseCell.m
//  TUTTableViewAutolayout
//
//  Created by lbencs on 15/4/24.
//  Copyright (c) 2015年 lbencs. All rights reserved.
//

#import "TUTBaseCell.h"

@implementation TUTBaseCell

+ (UINib *)nib{
    return [UINib nibWithNibName:NSStringFromClass(self) bundle:nil];
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end

//
//  TableViewCell.m
//  AutoLayoutTableViewDome
//
//  Created by lbencs on 1/28/15.
//  Copyright (c) 2015 lbencs. All rights reserved.
//

#import "TableViewCell.h"

@interface TableViewCell ()

@end

@implementation TableViewCell


- (void)awakeFromNib {
    self.contextLabel.lineBreakMode = NSLineBreakByWordWrapping;
}

//- (void)setBounds:(CGRect)bounds{
//    [super setBounds:bounds];
//    self.contentView.frame = self.bounds;
//}
//- (void)layoutSubviews{
//    [super layoutSubviews];
//    [self.contentView updateConstraintsIfNeeded];
//    [self.contentView layoutIfNeeded];
//    self.contextLabel.preferredMaxLayoutWidth = CGRectGetWidth(self.contextLabel.frame);
//}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

}

@end

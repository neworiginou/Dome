//
//  TUTCTableViewCell.m
//  AutoLayoutTableViewDome
//
//  Created by lbencs on 1/29/15.
//  Copyright (c) 2015 lbencs. All rights reserved.
//

#import "TUTCTableViewCell.h"

@interface TUTCTableViewCell ()
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *contentLabel;

@end

@implementation TUTCTableViewCell

- (void)awakeFromNib {
}

- (void)configueCell:(NSDictionary *)model{
    _titleLabel.text = [model objectForKey:@"title"];
    _contentLabel.text = [model objectForKey:@"content"];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

@end

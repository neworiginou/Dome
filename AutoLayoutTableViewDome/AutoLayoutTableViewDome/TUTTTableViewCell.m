//
//  TUTTTableViewCell.m
//  AutoLayoutTableViewDome
//
//  Created by lbencs on 1/29/15.
//  Copyright (c) 2015 lbencs. All rights reserved.
//

#import "TUTTTableViewCell.h"
#import "TUTCTableViewCell.h"

@interface TUTTTableViewCell ()
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) NSMutableArray * items;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *tableViewHeightConstraint;
@end

@implementation TUTTTableViewCell

- (void)awakeFromNib {
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    self.tableView.scrollEnabled = NO;
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}
- (NSMutableArray *)items{
    if (!_items) {
        _items = [[NSMutableArray alloc] init];
    }
    return _items;
}

- (void)configueCell:(NSDictionary *)modell{
    _titleLabel.text = [modell objectForKey:@"title"];
    self.items = [modell objectForKey:@"content"];
    
    self.tableViewHeightConstraint.constant = 1000;
    [self.tableView reloadData];
    [self setNeedsUpdateConstraints];
    [self needsUpdateConstraints];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [self.items count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    TUTCTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([TUTCTableViewCell class])];
    [cell configueCell:[self.items objectAtIndex:indexPath.row]];
    return cell;
}

@end

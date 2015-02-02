//
//  TUTTTableViewCell.h
//  AutoLayoutTableViewDome
//
//  Created by lbencs on 1/29/15.
//  Copyright (c) 2015 lbencs. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TUTTTableViewCell : UITableViewCell<UITableViewDataSource,UITableViewDelegate>

- (void)configueCell:(id)modell;
@end

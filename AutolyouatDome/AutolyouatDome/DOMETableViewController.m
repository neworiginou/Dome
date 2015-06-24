//
//  DOMETableViewController.m
//  AutolyouatDome
//
//  Created by lbencs on 15/6/23.
//  Copyright © 2015年 lbencs. All rights reserved.
//

#import "TableViewCell.h"
#import "DOMETableViewController.h"

@interface DOMETableViewController ()

@end

@implementation DOMETableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    [self.tableView registerNib:[TableViewCell nib] forCellReuseIdentifier:@"TableViewCell"];
    
//    self.tableView.estimatedRowHeight = 130;
    self.tableView.estimatedRowHeight = 30;
    self.tableView.rowHeight = UITableViewAutomaticDimension;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
#warning Incomplete implementation, return the number of sections
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
#warning Incomplete implementation, return the number of rows
    return 10;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    TableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"TableViewCell"];
    cell.myLabel.text =  @"jisojaifojdiosajifojdsoiajifojdisojaifojdijisojaifojdiosajifojdsoiajifojdisojaifojdiosajifojdsoiajifojdisojaifojdiosajifojdsoiajifojdisojaifojdiosajifojdsoiajifosajifojdsoiajifojdisojaifojdiosajifojdsoiajifojdisojaifojdiosajifojdsoiajifosajifojdsoiajifojdisojaifojdiosajifojdsoiajifojdisojaifojdiosajifojdsoiajifosajifojdsoiajifojdisojaifojdiosajifojdsoiajifojdisojaifojdiosajifojdsoiajifosajifojdsoiajifojdisojaifojdiosajifojdsoiajifojdisojaifojdiosajifojdsoiajifosajifojdsoiajifojdisojaifojdiosajifojdsoiajifojdisojaifojdiosajifojdsoiajifojdisojaifojdiosajifojdsoiajifojdisoajifodsa";
    
    return cell;
}

//- (CGFloat)tableView:(nonnull UITableView *)tableView heightForRowAtIndexPath:(nonnull NSIndexPath *)indexPath{
//    
//    TableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"TableViewCell"];
//    cell.myLabel.text = @"jisojaifojdiosajifojdsoiajifojdisojaifojdijisojaifojdiosajifojdsoiajifojdisojaifojdiosajifojdsoiajifojdisojaifojdiosajifojdsoiajifojdisojaifojdiosajifojdsoiajifosajifojdsoiajifojdisojaifojdiosajifojdsoiajifojdisojaifojdiosajifojdsoiajifosajifojdsoiajifojdisojaifojdiosajifojdsoiajifojdisojaifojdiosajifojdsoiajifosajifojdsoiajifojdisojaifojdiosajifojdsoiajifojdisojaifojdiosajifojdsoiajifosajifojdsoiajifojdisojaifojdiosajifojdsoiajifojdisojaifojdiosajifojdsoiajifosajifojdsoiajifojdisojaifojdiosajifojdsoiajifojdisojaifojdiosajifojdsoiajifojdisojaifojdiosajifojdsoiajifojdisoajifodsa";
//    
//    cell.myLabel.preferredMaxLayoutWidth = cell.bounds.size.width - 44;
//    
//    return [cell.contentView systemLayoutSizeFittingSize:UILayoutFittingCompressedSize].height + 1;
//}


/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Table view delegate

// In a xib-based application, navigation from a table can be handled in -tableView:didSelectRowAtIndexPath:
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    // Navigation logic may go here, for example:
    // Create the next view controller.
    <#DetailViewController#> *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:<#@"Nib name"#> bundle:nil];
    
    // Pass the selected object to the new view controller.
    
    // Push the view controller.
    [self.navigationController pushViewController:detailViewController animated:YES];
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end

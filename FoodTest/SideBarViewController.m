//
//  SideBarViewController.m
//  FoodTest
//
//  Created by Pavel Hrybouski on 27.10.16.
//  Copyright © 2016 Pavel Hrybouski. All rights reserved.
//

#import "SideBarViewController.h"
#import "SWRevealViewController.h"
#import "ContacsViewController.h"

@implementation SideBarViewController{
    NSArray *menuItems;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    menuItems = @[@"Menu",@"Contacs"];
     self.clearsSelectionOnViewWillAppear = NO;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return menuItems.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *CellIdentifier = [menuItems objectAtIndex:indexPath.row];
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    return cell;
}
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
    UINavigationController *destViewController = (UINavigationController*)segue.destinationViewController;
    destViewController.title = [[menuItems objectAtIndex:indexPath.row] capitalizedString];
    

                                                                           }
@end

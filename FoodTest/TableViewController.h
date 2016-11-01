//
//  TableViewController.h
//  FoodTest
//
//  Created by Pavel Hrybouski on 26.10.16.
//  Copyright © 2016 Pavel Hrybouski. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Offers.h"
#import "Category.h"
@interface TableViewController : UITableViewController
@property (strong,nonatomic) Category *incomingCategory;
@property (strong,nonatomic) NSString *stringCategory;
@property (strong,nonatomic) NSString *categoryName;
@property (strong,nonatomic) UIActivityIndicatorView *activityIndicatorView;



-(void) showCategotyID:(NSString *)categoryID
      showCategotyName:(NSString *)categoryName
       withOffersArray:(NSMutableArray *)offerArray;
@end

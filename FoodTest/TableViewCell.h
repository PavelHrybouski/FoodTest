//
//  TableViewCell.h
//  FoodTest
//
//  Created by Pavel Hrybouski on 26.10.16.
//  Copyright © 2016 Pavel Hrybouski. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TableViewCell : UITableViewCell
@property (nonatomic, weak) IBOutlet UIImageView *offersImage;
@property (nonatomic, weak) IBOutlet UILabel *nameLabel;
@property (nonatomic, weak) IBOutlet UILabel *weightLabel;
@property (nonatomic, weak) IBOutlet UILabel *priceLabel;



@end

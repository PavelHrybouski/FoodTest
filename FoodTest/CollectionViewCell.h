//
//  CollectionViewCell.h
//  FoodTest
//
//  Created by Pavel Hrybouski on 26.10.16.
//  Copyright © 2016 Pavel Hrybouski. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Category.h"

@interface CollectionViewCell : UICollectionViewCell
@property (nonatomic, weak) Category *localCategory;
@property (nonatomic, weak) IBOutlet UIImageView *imageView;
@property (nonatomic, weak) IBOutlet UILabel *nameLabel;

@end

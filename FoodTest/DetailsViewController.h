//
//  DetailsViewController.h
//  FoodTest
//
//  Created by Pavel Hrybouski on 27.10.16.
//  Copyright © 2016 Pavel Hrybouski. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Offers.h"

@interface DetailsViewController : UIViewController
@property (nonatomic, weak) IBOutlet UIImageView *offersImage;
@property (nonatomic, weak) IBOutlet UILabel *nameLabel;
@property (nonatomic, weak) IBOutlet UILabel *weightLabel;
@property (nonatomic, weak) IBOutlet UILabel *priceLabel;
@property (nonatomic, weak) IBOutlet UITextView *descriprionView;
@property (nonatomic, strong) Offers *detailOffer;

-(void) showOffersDetail:(Offers *)offer;

@end

//
//  DetailsViewController.m
//  FoodTest
//
//  Created by Pavel Hrybouski on 27.10.16.
//  Copyright © 2016 Pavel Hrybouski. All rights reserved.
//

#import "DetailsViewController.h"
#import "UIImageView+AFNetworking.h"

@implementation DetailsViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    self.nameLabel.text = [NSString stringWithFormat:@"%@", self.detailOffer.name];
    
    self.priceLabel.layer.cornerRadius = 11;
    self.priceLabel.clipsToBounds = YES;
    
    
    self.priceLabel.text = [NSString stringWithFormat:@"%d руб.", [self.detailOffer.price intValue]];
    
    self.descriprionView.text = self.detailOffer.offersDescription;
    if (self.detailOffer.weight) {
        
        self.weightLabel.text = [NSString stringWithFormat:@"Вес : %d гр.", [self.detailOffer.weight intValue] ];
        
    } else {
        
        self.weightLabel.text = [NSString stringWithFormat:@"Вес не указан"];
        
    }
    [self.offersImage setImageWithURL:self.detailOffer.picture];
}
-(void) showOffersDetail:(Offers *)offer{
    self.detailOffer = offer;


}

@end

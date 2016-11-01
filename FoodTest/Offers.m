//
//  Offers.m
//  FoodTest
//
//  Created by Pavel Hrybouski on 25.10.16.
//  Copyright © 2016 Pavel Hrybouski. All rights reserved.
//

#import "Offers.h"
#import <Foundation/NSObject.h>


@implementation Offers

-(id) initWithname:(NSString *)name price:(NSString *) price weight:(NSString *)weight offersDescription:(NSString *)offersDescription picture:(NSString *)picture offersCategoryId:(NSString *)offersCategoryId{
    self = [super init];
    if (self){
        self.name = name;
        self.price = price;
        self.weight = weight;
        self.offersDescription = offersDescription;
        
        self.picture = [NSURL URLWithString:picture];
        self.offersCategoryId = offersCategoryId;

    }
    return self;
}


@end
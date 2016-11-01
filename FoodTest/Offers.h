//
//  Offers.h
//  FoodTest
//
//  Created by Pavel Hrybouski on 25.10.16.
//  Copyright © 2016 Pavel Hrybouski. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Offers : NSObject
@property (strong, nonatomic) NSString *name;
@property (strong, nonatomic) NSString *price;
@property (strong, nonatomic) NSString *offersDescription;
@property (strong, nonatomic) NSURL *picture;
@property (strong, nonatomic) NSString *weight;
@property (strong, nonatomic) NSString *offersCategoryId;


-(id) initWithname:(NSString *)name price:(NSString *) price weight:(NSString *)weight offersDescription:(NSString *)offersDescription picture:(NSString *)picture offersCategoryId:(NSString *)offersCategoryId;
@end
//
//  Category.h
//  FoodTest
//
//  Created by Pavel Hrybouski on 26.10.16.
//  Copyright © 2016 Pavel Hrybouski. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Category : NSObject
@property (strong,nonatomic) NSString *categoryName;
@property (strong,nonatomic) NSString *categoryID;


-(id) initWithCategoryName:(NSString *)categoryName categoryID:(NSString *)categoryID;

@end

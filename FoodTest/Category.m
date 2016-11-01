//
//  Category.m
//  FoodTest
//
//  Created by Pavel Hrybouski on 26.10.16.
//  Copyright © 2016 Pavel Hrybouski. All rights reserved.
//

#import "Category.h"

@implementation Category
-(id) initWithCategoryName:(NSString *)categoryName categoryID:(NSString *)categoryID{
    self = [super init];
    if (self){
        self.categoryName = categoryName;
        self.categoryID = categoryID;
        NSLog(@"%@",self.categoryID );
    }
    return self;
}

@end

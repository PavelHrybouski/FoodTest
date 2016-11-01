//
//  PHServerManager.h
//  FoodTest
//
//  Created by Pavel Hrybouski on 25.10.16.
//  Copyright © 2016 Pavel Hrybouski. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PHServerManager : NSObject
@property (strong,nonatomic) NSMutableArray *offersArray;
@property (strong,nonatomic) NSMutableDictionary *categoryDictionary;

@property (strong,nonatomic) NSMutableArray *categoryArray;
@property (nonatomic) BOOL wasParsed;

+ (PHServerManager *) sharedManager;

-(void) parseXMLFile;


@end

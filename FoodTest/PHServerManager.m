//
//  PHServerManager.m
//  FoodTest
//
//  Created by Pavel Hrybouski on 25.10.16.
//  Copyright © 2016 Pavel Hrybouski. All rights reserved.
//

#import "PHServerManager.h"
#import "Offers.h"
#import "Category.h"
@interface PHServerManager()
@property (strong,nonatomic) NSXMLParser *parser;
@property (strong,nonatomic) NSString *element;
@property (strong,nonatomic) NSDictionary *attrDict;

//Offers
@property (strong,nonatomic) NSString *currentOfferName;
@property (strong,nonatomic) NSString *currentOfferPrice;
@property (strong,nonatomic) NSString *currentOfferWeight;
@property (strong,nonatomic) NSString *currentOfferDescription;
@property (strong,nonatomic) NSString *currentOfferPicture;
@property (strong,nonatomic) NSString *currentOfferCategoryID;
//Category
@property (strong,nonatomic) NSString *currentCategoryName;
@property (strong,nonatomic) NSString *currentCategoryID;

@end

@implementation PHServerManager

+ (PHServerManager *) sharedManager{
    static PHServerManager *manager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[PHServerManager alloc]init];
    });
    return manager;
}


-(void) parseXMLFile{
    self.wasParsed = YES;

    self.offersArray = [NSMutableArray array];
    self.categoryArray = [NSMutableArray array];
    self.categoryDictionary = [NSMutableDictionary dictionary];

    NSURL *xmlPath = [NSURL URLWithString:@"http://ufa.farfor.ru/getyml/?key=ukAXxeJYZN"];
    self.parser = [[NSXMLParser alloc]initWithContentsOfURL:xmlPath];
    self.parser.delegate = (id)self;
    [self.parser parse];
}

- (void)parser:(NSXMLParser *)parser
didStartElement:(NSString *)elementName
  namespaceURI:(NSString *)namespaceURI
 qualifiedName:(NSString *)qualifiedName
    attributes:(NSDictionary<NSString *,
                NSString *> *)attributeDict
{
    self.element = elementName;
    self.attrDict = attributeDict;
}

- (void)parser:(NSXMLParser *)parser
foundCharacters:(NSString *)string
{
    if(![self.element isEqualToString:@"offers"])
    {
        if ([self.element isEqualToString:@"category"])
        {
            
            self.currentCategoryName = string;
            self.currentCategoryID = [self.attrDict objectForKey:@"id"];
        }
    }
    if ([self.element isEqualToString:@"name"])
    {
        self.currentOfferName = string;
    }
    else if ([self.element isEqualToString:@"price"])
    {
        self.currentOfferPrice = string;
    }
    else if ([self.element isEqualToString:@"description"])
    {
        self.currentOfferDescription = string;
    }
    else if ([self.element isEqualToString:@"picture"])
    {
        self.currentOfferPicture = string;
    }
    else if ([self.element isEqualToString:@"categoryId"])
    {
        self.currentOfferCategoryID = string;
    }
    else if ([self.element isEqualToString:@"param"]&&([[self.attrDict objectForKey:@"name"] isEqualToString:@"Вес"]))
    {
        NSLog(@"%@",self.element);

        if(self.currentOfferWeight)
        {
            [self.currentOfferWeight stringByAppendingString:string];
        }
        else{
            self.currentOfferWeight = string;
        }
    }
}

- (void)parser:(NSXMLParser *)parser
 didEndElement:(NSString *)elementName
  namespaceURI:(NSString *)namespaceURI
 qualifiedName:(NSString *)qName
{
    if ([elementName isEqualToString:@"offer"])
    {
        Offers *currentOffer = [[Offers alloc] initWithname:self.currentOfferName price:self.currentOfferPrice weight:self.currentOfferWeight offersDescription:self.currentOfferDescription picture:self.currentOfferPicture offersCategoryId:self.currentOfferCategoryID];
         
        [self.offersArray addObject:currentOffer];
        self.currentOfferWeight = nil;

    }
    if ([elementName isEqualToString:@"category"]) {
        [self.categoryDictionary setObject:self.currentCategoryID forKey:self.currentCategoryName];
        NSLog(@"%@",[self.categoryDictionary allValues]);

    }
    self.element = nil;
    
}





@end
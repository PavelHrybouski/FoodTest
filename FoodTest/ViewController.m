//
//  ViewController.m
//  FoodTest
//
//  Created by Pavel Hrybouski on 25.10.16.
//  Copyright © 2016 Pavel Hrybouski. All rights reserved.
//

#import "ViewController.h"
#import "PHServerManager.h"
#import "UIImage+AFNetworking.h"
#import "UIImageView+AFNetworking.h"
#import "Offers.h"
#import "CollectionViewCell.h"
#import "TableViewController.h"
#import "SWRevealViewController.h"
@interface ViewController ()
@property (strong,nonatomic) NSMutableArray *offerArray;
@property (strong,nonatomic) NSMutableDictionary *categoryDictionary;

@property (strong,nonatomic) NSMutableArray *categoryArray;
@property (strong,nonatomic) UIActivityIndicatorView *activityIndicatorView;
@property (strong, nonatomic) NSArray *imageArray;
@property (strong,nonatomic) Category *localCategory;
@property (strong,nonatomic) Offers *localOffer;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
   
    SWRevealViewController *revealViewController = self.revealViewController;
    if ( revealViewController )
    {
        [self.sidebarButton setTarget: self.revealViewController];
        [self.sidebarButton setAction: @selector( revealToggle: )];
        [self.view addGestureRecognizer:self.revealViewController.panGestureRecognizer];
    }
     self.imageArray = @[@"Десерты", @"Закуски", @"Лапша", @"Напитки", @"Добавки", @"Патимейкер", @"Пицца", @"Теплое", @"Роллы", @"Салаты", @"Сеты", @"Супы", @"Суши"];
    
    [self parseLink];
}

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return [self.imageArray count];
}
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    CollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"CollectionViewCell" forIndexPath:indexPath];
    
    cell.imageView.image = [UIImage imageNamed:[NSString stringWithFormat:@"%@.jpg",[self.imageArray objectAtIndex:indexPath.row]]];
    
    cell.nameLabel.text = [self.imageArray objectAtIndex:indexPath.row];

    cell.layer.cornerRadius = 20;

    return cell;
    
    
}
-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(nonnull NSIndexPath *)indexPath{
    return CGSizeMake(150, 150);
}
-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    return UIEdgeInsetsMake(5, 5, 5, 5);
}


- (void)parseLink
{
    PHServerManager *manager = [PHServerManager sharedManager];
    if (!manager.wasParsed)
    {
        dispatch_async(dispatch_get_global_queue(0,0), ^{

            [manager parseXMLFile];
            dispatch_async(dispatch_get_main_queue(), ^{
                self.categoryDictionary = manager.categoryDictionary;
                self.offerArray = manager.offersArray;
            });
        });
    }
    else
    {
        self.categoryDictionary = manager.categoryDictionary;
        self.offerArray = manager.offersArray;
    }

}

#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(CollectionViewCell *)sender {
    if (self.categoryDictionary  == nil) {
        [self showAlertWithTitle:@"Устанавливается соединение" andMessage:@"Подождите несколько секунд"];
    }else{
        TableViewController *tvc = (TableViewController*)[segue destinationViewController];
        NSString*string =  sender.nameLabel.text;
        [tvc showCategotyID:[self.categoryDictionary objectForKey:string] showCategotyName:string withOffersArray:self.offerArray];
    }

}

- (void) showAlertWithTitle:(NSString*) title andMessage:(NSString*) message {
    
    UIAlertController * alert=   [UIAlertController
                                  alertControllerWithTitle:title
                                  message:message
                                  preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction* ok = [UIAlertAction
                         actionWithTitle:@"OK"
                         style:UIAlertActionStyleDefault
                         handler:^(UIAlertAction * action)
                         {
                             
                         }];
    
    [alert addAction:ok];
    [self presentViewController:alert animated:YES completion:nil];
    
    
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end

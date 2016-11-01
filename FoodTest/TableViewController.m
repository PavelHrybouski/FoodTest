//
//  TableViewController.m
//  FoodTest
//
//  Created by Pavel Hrybouski on 26.10.16.
//  Copyright © 2016 Pavel Hrybouski. All rights reserved.
//

#import "TableViewController.h"

#import "TableViewCell.h"
#import "UIImageView+AFNetworking.h"
#import "DetailsViewController.h"


@interface TableViewController ()<UITableViewDelegate, UITableViewDataSource>
@property (strong,nonatomic) NSMutableArray *offerArray;
@property (strong,nonatomic) NSMutableArray *sortedOfferArray;
@property (strong,nonatomic) Offers *incomingOffer;

@end
@implementation TableViewController
-(void)viewDidLoad{
    [super viewDidLoad];
    self.navigationItem.title = self.categoryName;
    [self sortOfferArray];
}
#pragma mark - Sorting offerArray

-(void)sortOfferArray{
    self.sortedOfferArray = [NSMutableArray array];
    for (Offers *offer in self.offerArray)
    {
        if([offer.offersCategoryId isEqualToString:self.stringCategory])
        {
            [self.sortedOfferArray addObject:offer];
        }
    }
}
-(void) showCategotyID:(NSString *)categoryID showCategotyName:(NSString *)categoryName withOffersArray:(NSMutableArray *)offerArray
{
    self.categoryName = categoryName;
    self.stringCategory = categoryID;
    self.offerArray = offerArray;
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.sortedOfferArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *identifier = @"TableViewCellIdentifier";

    TableViewCell *cell = (TableViewCell *)[tableView dequeueReusableCellWithIdentifier:@"TableViewCellIdentifier"];
   
    if (!cell)
    {
        cell = [[TableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        
        

    }
    cell.imageView.image = nil;

     Offers *offer = [self.sortedOfferArray objectAtIndex:indexPath.row];
    cell.nameLabel.text = [NSString stringWithFormat:@"%@", offer.name];

    cell.priceLabel.layer.cornerRadius = 11;
    cell.priceLabel.clipsToBounds = YES;

    cell.priceLabel.text = [NSString stringWithFormat:@"%d руб.", [offer.price intValue]];

    
    if (offer.weight) {
        
    cell.weightLabel.text = [NSString stringWithFormat:@"Вес : %d гр.", [offer.weight intValue] ];
        
    } else {
    
    cell.weightLabel.text = [NSString stringWithFormat:@"Вес не указан"];
    
}
    NSURLRequest *request = [NSURLRequest requestWithURL:offer.picture];

    __weak TableViewCell *weakCell = cell;
    
    [weakCell.offersImage
     setImageWithURLRequest:request
     placeholderImage:nil
     success:^(NSURLRequest * _Nonnull request, NSHTTPURLResponse * _Nullable response, UIImage * _Nonnull image) {
         
         weakCell.offersImage.image = image;
         [weakCell layoutSubviews];
     }
     failure:^(NSURLRequest * _Nonnull request, NSHTTPURLResponse * _Nullable response, NSError * _Nonnull error) {
         
     }];

    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(TableViewCell *)sender {

    NSIndexPath *path = [self.tableView indexPathForSelectedRow];
    self.incomingOffer = [self.sortedOfferArray objectAtIndex:path.row];
    DetailsViewController *tvc = (DetailsViewController *)[segue destinationViewController];

    [tvc showOffersDetail:self.incomingOffer];
    
}
//-(void) configureActivityIndicatorView:(UIActivityIndicatorView *)activityIndicatorView withCenter:(CGPoint)center{
//    activityIndicatorView.layer.cornerRadius = 05;
//    activityIndicatorView.opaque = NO;
//    activityIndicatorView.backgroundColor = [UIColor colorWithWhite:0.0f alpha:0.6f];
//    activityIndicatorView.center = center;
//    activityIndicatorView.activityIndicatorViewStyle = UIActivityIndicatorViewStyleGray;
//    [activityIndicatorView setColor:[UIColor colorWithRed:0.6 green:0.8 blue:1.0 alpha:1.0]];
//}

@end

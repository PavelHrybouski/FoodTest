//
//  ViewController.h
//  FoodTest
//
//  Created by Pavel Hrybouski on 25.10.16.
//  Copyright © 2016 Pavel Hrybouski. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController <UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>
@property(nonatomic, weak) IBOutlet UICollectionView *collectionView;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *sidebarButton;

@end


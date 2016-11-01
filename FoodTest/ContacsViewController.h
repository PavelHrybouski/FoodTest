//
//  ContacsViewController.h
//  FoodTest
//
//  Created by Pavel Hrybouski on 27.10.16.
//  Copyright © 2016 Pavel Hrybouski. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>
@class MKMapView;

@interface ContacsViewController : UIViewController 
{
    CLLocationManager *locationManager;
}
@property (weak, nonatomic) IBOutlet UIBarButtonItem *sidebarButton;
@property (weak, nonatomic) IBOutlet MKMapView *mapView;
@property (strong, nonatomic) CLLocationManager *locationManager;
@property (weak, nonatomic) IBOutlet UISegmentedControl *segmantControl;

-(IBAction)setMap:(id)sender;
@end

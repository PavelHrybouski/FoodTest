//
//  ContacsViewController.m
//  FoodTest
//
//  Created by Pavel Hrybouski on 27.10.16.
//  Copyright © 2016 Pavel Hrybouski. All rights reserved.
//

#import "ContacsViewController.h"
#import "SWRevealViewController.h"
#import <MapKit/MapKit.h>
#import "UIView+MKAnnotationView.h"
#import <QuartzCore/QuartzCore.h>


@interface ContacsViewController ()<MKMapViewDelegate, CLLocationManagerDelegate>
@property (strong, nonatomic) MKDirections* directions;
@property (strong,nonatomic) MKPointAnnotation* voronezh;
@property (strong,nonatomic) MKPointAnnotation* penza;
@property (strong,nonatomic) MKPointAnnotation* samara;
@property (strong,nonatomic) MKPointAnnotation* ufa;
@end


@implementation ContacsViewController
- (void)viewDidLoad {
    
    [super viewDidLoad];
    SWRevealViewController *revealViewController = self.revealViewController;
    if ( revealViewController )
        {
        [self.sidebarButton setTarget: self.revealViewController];
        [self.sidebarButton setAction: @selector( revealToggle: )];
        [self.view addGestureRecognizer:self.revealViewController.panGestureRecognizer];
        }
    
    [self.view addSubview:self.mapView];
    [self addPins];
    self.segmantControl.layer.cornerRadius = 8;
     
    self.segmantControl.layer.masksToBounds = YES;
    }

#pragma mark - Actions
- (void) actionDirection:(UIButton*) sender {
    
    MKAnnotationView* annotationView = [sender superAnnotationView];
    
    if (!annotationView) {
        return;
    }
    
    if ([self.directions isCalculating]) {
        [self.directions cancel];
    }
    
    CLLocationCoordinate2D coordinate = annotationView.annotation.coordinate;
    
    MKDirectionsRequest* request = [[MKDirectionsRequest alloc] init];
    
    request.source = [MKMapItem mapItemForCurrentLocation];
    
    MKPlacemark* placemark = [[MKPlacemark alloc] initWithCoordinate:coordinate
                                                   addressDictionary:nil];
    
    MKMapItem* destination = [[MKMapItem alloc] initWithPlacemark:placemark];
    
    request.destination = destination;
    
    request.transportType = MKDirectionsTransportTypeAutomobile;
    
    request.requestsAlternateRoutes = YES;
    
    self.directions = [[MKDirections alloc] initWithRequest:request];
    
    [self.directions calculateDirectionsWithCompletionHandler:^(MKDirectionsResponse *response, NSError *error) {
        
        if (error) {
            [self showAlertWithTitle:@"Error" andMessage:[error localizedDescription]];
        } else if ([response.routes count] == 0) {
            [self showAlertWithTitle:@"Error" andMessage:@"No routes found"];
        } else {
            
            [self.mapView removeOverlays:[self.mapView overlays]];
            
            NSMutableArray* array = [NSMutableArray array];
            
            for (MKRoute* route in response.routes) {
                [array addObject:route.polyline];
            }
            
            [self.mapView addOverlays:array level:MKOverlayLevelAboveRoads];
            
            MKMapPoint annotationPoint1 = MKMapPointForCoordinate(self.mapView.userLocation.coordinate);
            MKMapRect zoomRect = MKMapRectMake(annotationPoint1.x, annotationPoint1.y, 0.1, 0.1);
            MKMapPoint annotationPoint2 = MKMapPointForCoordinate(coordinate);
            MKMapRect pointRect = MKMapRectMake(annotationPoint2.x, annotationPoint2.y, 0.1, 0.1);
            zoomRect = MKMapRectUnion(zoomRect, pointRect);
            
            [self.mapView setVisibleMapRect:zoomRect edgePadding:UIEdgeInsetsMake(40, 40, 40, 40) animated:YES];
        }
        
    }];
}

-(IBAction)setMap:(id)sender{
    switch ((((UISegmentedControl *) sender).selectedSegmentIndex)) {
        case 0:
            self.mapView.mapType = MKMapTypeStandard;
            break;
        case 1:
            self.mapView.mapType = MKMapTypeSatellite;
            break;
        case 2:
            self.mapView.mapType = MKMapTypeHybrid;
            break;
            
        default:
            break;
    }
}

-(void) addPins{
    
    
    
    self.voronezh = [[MKPointAnnotation alloc]init];
    self.voronezh.coordinate = CLLocationCoordinate2DMake(51.673672, 39.212501);
    self.voronezh.title = @"Ресторан в Воронеже";
    
    
    self.penza = [[MKPointAnnotation alloc]init];
    self.penza.coordinate = CLLocationCoordinate2DMake(53.198570, 45.015219);
    self.penza.title = @"Ресторан в Пензе";
    
    
    self.samara = [[MKPointAnnotation alloc]init];
    self.samara.coordinate = CLLocationCoordinate2DMake(53.239416, 50.279292);
    self.samara.title = @"Ресторан в Самаре";
    
    
    self.ufa = [[MKPointAnnotation alloc]init];
    self.ufa.coordinate = CLLocationCoordinate2DMake(54.773950, 56.031377);
    self.ufa.title = @"Ресторан в Уфе";
    
    
    
    
    [self.mapView addAnnotations:@[self.voronezh, self.penza, self.samara, self.ufa]];
    self.locationManager = [CLLocationManager new];
   [self.locationManager requestWhenInUseAuthorization];
    self.mapView.showsUserLocation = YES;
    self.mapView.delegate = self;
    [CLLocationManager locationServicesEnabled];
    [self actionShowAll];
}
-(void) actionShowAll{
    
    MKMapRect zoomRect = MKMapRectNull;
    for (id <MKAnnotation> annotation in self.mapView.annotations) {
        CLLocationCoordinate2D location = annotation.coordinate;
        MKMapPoint center = MKMapPointForCoordinate(location);
        static double delta = 20000;
        
        
        MKMapRect rect = MKMapRectMake(center.x - delta, center.y -delta, delta*2, delta*2);
        zoomRect = MKMapRectUnion(zoomRect, rect);
        
    }
    zoomRect = [self.mapView mapRectThatFits:zoomRect];
    [self.mapView setVisibleMapRect:zoomRect edgePadding:UIEdgeInsetsMake(50, 50, 50, 50) animated:YES];
    
    
}

#pragma mark - CLLocationManagerDelegate

- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error
{
    NSLog(@"didFailWithError: %@", error);
    [self showAlertWithTitle:@"Error" andMessage:@"Failed to Get Your Location"];
    
}


- (void)locationManager:(CLLocationManager *)manager
     didUpdateLocations:(NSArray<CLLocation *> *)locations{
    if (manager != locationManager)
        
    {
        [manager stopUpdatingLocation];
        return;
    }
    else {
        [self actionShowAll];
    }
    
    [locationManager stopUpdatingLocation];
    
}






-(MKOverlayRenderer *)mapView:(MKMapView *)mapView rendererForOverlay:(id<MKOverlay>)overlay{
    
    if ([overlay isKindOfClass:[MKPolyline class]]) {
        
        MKPolylineRenderer *renderer = [[MKPolylineRenderer alloc] initWithPolyline:overlay];
        renderer.lineWidth = 5.0;
        renderer.strokeColor = [UIColor colorWithRed:0.f green:0.5f blue:1.f alpha:0.9f];
        return renderer;
        
    }
    return nil;
}

#pragma mark - MKMapViewDelegate

- (void)mapView:(MKMapView *)aMapView didUpdateUserLocation:(MKUserLocation *)aUserLocation {
  
    self.mapView.userLocation.title = [NSString stringWithFormat:@"%f", self.mapView.userLocation.coordinate.latitude];
    self.mapView.userLocation.subtitle = [NSString stringWithFormat:@"%f", self.mapView.userLocation.coordinate.longitude];
    [self actionShowAll];
}


- (MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id <MKAnnotation>)annotation {
    
    if ([annotation isKindOfClass:[MKUserLocation class]]) {
        return nil;
    }
    
    static NSString* identifier = @"Annotation";
    
    MKPinAnnotationView* pin = (MKPinAnnotationView*)[mapView dequeueReusableAnnotationViewWithIdentifier:identifier];
    
    if (!pin) {
        pin = [[MKPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:identifier];
        pin.pinTintColor = [UIColor purpleColor];
        pin.animatesDrop = YES;
        pin.canShowCallout = YES;
        
        
        UIButton* directionButton = [UIButton buttonWithType:UIButtonTypeContactAdd];
        [directionButton addTarget:self action:@selector(actionDirection:) forControlEvents:UIControlEventTouchUpInside];
        pin.leftCalloutAccessoryView = directionButton;
        
    } else {
        pin.annotation = annotation;
    }
    
    return pin;
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


-(void)dealloc{
    [self.directions cancel];
}
@end

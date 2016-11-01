//
//  UIView+MKAnnotationView.h
//  FoodTest
//
//  Created by Pavel Hrybouski on 27.10.16.
//  Copyright © 2016 Pavel Hrybouski. All rights reserved.
//

#import <UIKit/UIKit.h>


@class MKAnnotationView;


@interface UIView (MKAnnotationView)

- (MKAnnotationView *) superAnnotationView;
@end
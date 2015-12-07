//
//  AboutUsViewController.h
//  Easy Food
//
//  Created by Nikita on 22.11.15.
//  Copyright © 2015 Apple Inc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>

@class MKMapView;

@interface AboutUsViewController : UIViewController

@property (weak, nonatomic) IBOutlet MKMapView *mapView;
@property (nonatomic,retain) CLLocationManager *locationManager;


@end

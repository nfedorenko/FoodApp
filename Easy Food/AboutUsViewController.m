//
//  AboutUsViewController.m
//  Easy Food
//
//  Created by Nikita on 22.11.15.
//  Copyright © 2015 Apple Inc. All rights reserved.
//

#import "AboutUsViewController.h"
#import <CoreLocation/CoreLocation.h>
#import "PizzaPlaceAnnotation.h"



@interface AboutUsViewController () <MKMapViewDelegate,CLLocationManagerDelegate>


@end

@implementation AboutUsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.mapView.delegate = self;
    self.mapView.showsUserLocation = YES;
    [self pizzaAnnototionCreate];
    [self parametersOfView];
}

#pragma mark - view settings
-(void)parametersOfView{
    
    //navigation bar style edite
    self.navigationItem.title = @"Restaurant";
    self.navigationController.navigationBar.tintColor = [UIColor colorWithRed:0.2 green:0.6 blue:0.6 alpha:1];
    self.navigationController.navigationBar.barTintColor = [UIColor colorWithRed:0.952 green:0.9215 blue:0.8005 alpha:1];
    UIColor* colore = [UIColor colorWithRed:0.2 green:0.6 blue:0.6 alpha:1];
    NSDictionary* dictionary = [[NSDictionary alloc]initWithObjectsAndKeys:colore, NSForegroundColorAttributeName,nil];
    self.navigationController.navigationBar.titleTextAttributes = dictionary;
    
}

-(void)pizzaAnnototionCreate{
    
    PizzaPlaceAnnotation * anotation = [[PizzaPlaceAnnotation alloc]init];
    anotation.title = @"Name";
    anotation.subtitle = @"LastName";
    double latitude = 53.9;
    double longitude = 27.566;
    anotation.coordinate = CLLocationCoordinate2DMake(latitude, longitude);
    [self.mapView addAnnotation:anotation];
    MKCoordinateRegion region = MKCoordinateRegionMakeWithDistance (anotation.coordinate, 1500, 1500);
    [_mapView setRegion:region animated:NO];
}

- (nullable MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id <MKAnnotation>)annotation{

    
    static NSString* indentifire = @"identifire";
    if ([annotation isKindOfClass:[PizzaPlaceAnnotation class]]) {
        
    MKAnnotationView* pen = (MKAnnotationView*)[mapView dequeueReusableAnnotationViewWithIdentifier:indentifire];
        
        pen = [[MKAnnotationView alloc]initWithAnnotation:annotation reuseIdentifier:indentifire];

        pen.canShowCallout = YES;
        [pen setImage:[UIImage imageNamed:@"pinForPizza.png"]];
        pen.frame = CGRectMake(0, 0, 50, 50);
            

        
    return pen;
    }
    return nil;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end

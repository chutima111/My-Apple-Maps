//
//  ViewController.m
//  CMCMyMapsView
//
//  Created by chutima mungmee on 9/15/16.
//  Copyright © 2016 chutima mungmee. All rights reserved.
//

#import "ViewController.h"
#import "MyCustomAnnotation.h"
#import "MyWebViewController.h"

@interface ViewController ()
{
    NSString *_url;
}

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.locationManager = [[CLLocationManager alloc]init];
    [self.locationManager requestWhenInUseAuthorization];
    [self.locationManager setDelegate:self];
    [self.locationManager setDesiredAccuracy:kCLLocationAccuracyBest];
    [self.locationManager startUpdatingLocation];
    
    self.myMapView.delegate = self;
    
    // Set Turn To Tech annotation
    CLLocationCoordinate2D turnToTechCoordinates = CLLocationCoordinate2DMake(40.741316, -73.989980);
    MyCustomAnnotation *turnToTechAnnotation = [[MyCustomAnnotation alloc]initWithTitle:@"Turn To Tech" Location:turnToTechCoordinates Image:@"turnToTech-icon"];
    
    [self.myMapView addAnnotation:turnToTechAnnotation];
    
    // Add a few restaurant nearby
    CLLocationCoordinate2D shakeShackCoordinate = CLLocationCoordinate2DMake(40.741362, -73.988290);
    MyCustomAnnotation *shakeShackAnnotation = [[MyCustomAnnotation alloc]initWithTitle:@"Shake Shack" Location:shakeShackCoordinate Image:@"shakeShack"];
    
    [self.myMapView addAnnotation:shakeShackAnnotation];
    
    CLLocationCoordinate2D katAndTheo = CLLocationCoordinate2DMake(40.740523, -73.990855);
    MyCustomAnnotation *katAndTheoAnnotation = [[MyCustomAnnotation alloc]initWithTitle:@"Kate & Theo" Location:katAndTheo Image:@"kateAndTheo"];
    
    [self.myMapView addAnnotation:katAndTheoAnnotation];
   
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)mapView:(MKMapView *)mapView didUpdateUserLocation:(MKUserLocation *)userLocation
{
    MKCoordinateRegion region = MKCoordinateRegionMakeWithDistance(userLocation.location.coordinate, 500, 500);
    
    [self.myMapView setRegion:region animated:YES];
}

-(MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id<MKAnnotation>)annotation
{
    if ([annotation isKindOfClass:[MyCustomAnnotation class]]) // If this is my custom pin class
    {
        MyCustomAnnotation *myLocation = (MyCustomAnnotation *)annotation;
        
        MKAnnotationView *annotationView = [mapView dequeueReusableAnnotationViewWithIdentifier:@"MyCustomAnnotation"];
        
        if (annotationView == nil) {
            annotationView = myLocation.annotationView;
        }
        else {
            annotationView.annotation = annotation;
        }
        
        return annotationView;
    }
    else {
        return nil;
    }
    
}

-(void)mapView:(MKMapView *)mapView didSelectAnnotationView:(MKAnnotationView *)view
{

    
    
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]];
    MyWebViewController *vc = [storyboard instantiateViewControllerWithIdentifier:@"MyWebViewController"];
  // here we psss things
    [self.navigationController pushViewController:vc animated:YES];
}



- (IBAction)changeMapType:(UISegmentedControl *)sender {
    
    NSUInteger selectedMapType = sender.selectedSegmentIndex;
    
    switch (selectedMapType) {
        case 0:
            self.myMapView.mapType = MKMapTypeStandard;
            break;
            
        case 1:
            self.myMapView.mapType = MKMapTypeHybrid;
            break;
            
        case 2:
            self.myMapView.mapType = MKMapTypeSatellite;
            break;
            
        default:
            break;
    }
}
@end

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
    NSMutableArray *matchingItems;
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
    
    self.searchBar.delegate = self;
    
    // Set Turn To Tech annotation
    CLLocationCoordinate2D turnToTechCoordinates = CLLocationCoordinate2DMake(40.741316, -73.989980);
    
    MyCustomAnnotation *turnToTechAnnotation = [[MyCustomAnnotation alloc]initWithTitle:@"Turn To Tech" Location:turnToTechCoordinates Image:@"turnToTech-icon" URL:@"http://turntotech.io/"];
    
    [self.myMapView addAnnotation:turnToTechAnnotation];
    
    // Add a few restaurant nearby
    CLLocationCoordinate2D shakeShackCoordinate = CLLocationCoordinate2DMake(40.741362, -73.988290);
    
    MyCustomAnnotation *shakeShackAnnotation = [[MyCustomAnnotation alloc]initWithTitle:@"Shake Shack" Location:shakeShackCoordinate Image:@"shakeShack" URL:@"https://www.shakeshack.com/"];
    
    [self.myMapView addAnnotation:shakeShackAnnotation];
    
    CLLocationCoordinate2D katAndTheoCoordinate = CLLocationCoordinate2DMake(40.740523, -73.990855);
    
    MyCustomAnnotation *katAndTheoAnnotation = [[MyCustomAnnotation alloc]initWithTitle:@"Kate & Theo" Location:katAndTheoCoordinate Image:@"kateAndTheo" URL:@"http://katandtheo.com/#landing"];
    
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

-(void)mapView:(MKMapView *)mapView annotationView:(MKAnnotationView *)view calloutAccessoryControlTapped:(UIControl *)control
{
    
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]];
        MyWebViewController *vc = [storyboard instantiateViewControllerWithIdentifier:@"MyWebViewController"];
    
      // I want to pass the url here!!!
    MyCustomAnnotation *annotationView = view.annotation;
    vc.urlString = annotationView.urlString;
    
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

-(void)searchBarCancelButtonClicked:(UISearchBar *)searchBar {
    
    searchBar.text = @"";
}

-(void)searchBarSearchButtonClicked:(UISearchBar *)searchBar {
    [searchBar resignFirstResponder];
    [_myMapView removeAnnotations:[_myMapView annotations]];
    [self performSearch];
}
-(void)performSearch
{
    MKLocalSearchRequest *request = [[MKLocalSearchRequest alloc]init];
    request.naturalLanguageQuery = self.searchBar.text;
    request.region = self.myMapView.region;
    
    matchingItems = [[NSMutableArray alloc]init];
    
    MKLocalSearch *search = [[MKLocalSearch alloc]initWithRequest:request];
    
    [search startWithCompletionHandler:^(MKLocalSearchResponse *response, NSError *error) {
        if (response.mapItems.count == 0) {
            NSLog(@"No Matches");
        }
        else {
            for (MKMapItem *item in response.mapItems) {
                [matchingItems addObject:item];
                
                MyCustomAnnotation *annotation = [[MyCustomAnnotation alloc]initWithTitle:item.name Location:item.placemark.coordinate Image:nil URL:item.url.absoluteString];
            
                [_myMapView addAnnotation:annotation];
                
            }
        }
    }];
}

@end

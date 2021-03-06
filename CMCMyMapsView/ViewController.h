//
//  ViewController.h
//  CMCMyMapsView
//
//  Created by chutima mungmee on 9/15/16.
//  Copyright © 2016 chutima mungmee. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import <CoreLocation/CoreLocation.h>

@interface ViewController : UIViewController <MKMapViewDelegate, CLLocationManagerDelegate, UISearchBarDelegate>

@property (nonatomic, strong) CLLocationManager *locationManager;
@property (weak, nonatomic) IBOutlet MKMapView *myMapView;

@property (nonatomic) NSString *urlString;

@property (weak, nonatomic) IBOutlet UISearchBar *searchBar;


- (IBAction)changeMapType:(UISegmentedControl *)sender;


@end


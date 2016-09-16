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

@interface ViewController : UIViewController <MKMapViewDelegate, CLLocationManagerDelegate>

@property (nonatomic, strong) CLLocationManager *locationManager;
@property (weak, nonatomic) IBOutlet MKMapView *myMapView;

- (IBAction)changeMapType:(UISegmentedControl *)sender;

@end


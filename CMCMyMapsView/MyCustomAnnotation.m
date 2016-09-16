//
//  MyCustomAnnotation.m
//  CMCMyMapsView
//
//  Created by chutima mungmee on 9/15/16.
//  Copyright © 2016 chutima mungmee. All rights reserved.
//

#import "MyCustomAnnotation.h"

@implementation MyCustomAnnotation

-(id)initWithTitle:(NSString *)newTitle Location:(CLLocationCoordinate2D)location Image:(NSString *)imageName
{
    self = [super init];
    
    if (self) {
        _title = newTitle;
        _coordinate = location;
        _CalloutImageName = imageName;
    }
    return self;
}

-(MKAnnotationView *)annotationView
{
    MKAnnotationView *annotationView = [[MKAnnotationView alloc]initWithAnnotation:self reuseIdentifier:@"MyCustomAnnotation"];
    
    annotationView.enabled = YES;
    annotationView.canShowCallout = YES;
    annotationView.image = [UIImage imageNamed:@"pinkPin_icon"];
    annotationView.rightCalloutAccessoryView = [UIButton buttonWithType:UIButtonTypeDetailDisclosure];
    
    // Add a image to the left side of the callout
    
    UIImageView *myCustomImage = [[UIImageView alloc]initWithImage:[UIImage imageNamed:self.CalloutImageName]];
    
    myCustomImage.frame = CGRectMake(0.0, 0.0, 35.0, 35.0);
    myCustomImage.clipsToBounds = YES;
    
    annotationView.leftCalloutAccessoryView = myCustomImage;
    
    return annotationView;
}




@end

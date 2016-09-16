//
//  MyCustomAnnotation.h
//  CMCMyMapsView
//
//  Created by chutima mungmee on 9/15/16.
//  Copyright © 2016 chutima mungmee. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>

@interface MyCustomAnnotation : NSObject <MKAnnotation>

@property (nonatomic, readonly) CLLocationCoordinate2D coordinate;
@property (copy, nonatomic) NSString *title;
@property (nonatomic) NSString *CalloutImageName;
@property (nonatomic) NSString *urlString;

-(id)initWithTitle:(NSString *)newTitle Location:(CLLocationCoordinate2D)location Image:(NSString *)imageName URL:(NSString *)URLSting;

-(MKAnnotationView *)annotationView;

@end

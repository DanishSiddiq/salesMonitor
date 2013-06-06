//
//  ZoomedMapView.h
//  Botnik
//
//  Created by goodcore2 on 1/17/13.
//
//

#import <MapKit/MapKit.h>

@interface ZoomedMapView : MKMapView

- (void)zoomMapViewToFitAnnotations:(MKMapView *)mapView animated:(BOOL)animated;

@end

//
//  MapViewController.m
//  JWS Mobile
//
//  Created by Björn Martensen on 05.02.12.
//  Copyright (c) 2012 eberle & wollweber COMMUNICATIONS GmbH. All rights reserved.
//

#import "MapViewController.h"

@implementation MapViewController
@synthesize mapView = _mapView;
@synthesize annotations = _annotations;

- (void)updateMapView
{
    if (self.mapView.annotations) [self.mapView removeAnnotations:self.mapView.annotations];
    if (self.annotations) [self.mapView addAnnotations:self.annotations];
}

- (void)setMapView:(MKMapView *)mapView
{
    if (_mapView != mapView) {
        _mapView = mapView;
        [self updateMapView];
    }
}

- (void)setAnnotations:(NSArray *)annotations
{
    if (_annotations != annotations) {
        _annotations = annotations;
        [self updateMapView];
    }
}

- (void)viewDidUnload
{
    [self setMapView:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

@end

//
//  MapViewController.m
//  JWS Mobile
//
//  Created by Björn Martensen on 05.02.12.
//  Copyright (c) 2012 eberle & wollweber COMMUNICATIONS GmbH. All rights reserved.
//

#import "MapViewController.h"
#import "JWSSubstitutionsFetcher.h"
#import "JWSStandortAnnotation.h"

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

- (void)fetchStandorte
{
    dispatch_queue_t fetchQ = dispatch_queue_create("Standort fetcher", NULL);
    dispatch_async(fetchQ, ^{
        NSArray *standorte = [JWSSubstitutionsFetcher standorte];
        NSMutableArray *annotations = [NSMutableArray arrayWithCapacity:standorte.count];
        dispatch_async(dispatch_get_main_queue(), ^{
            for (NSDictionary *standort in standorte) {
                [annotations addObject:[JWSStandortAnnotation annotationForStandort:standort]];
            }
            [self.mapView addAnnotations:annotations];
        });
    });
    dispatch_release(fetchQ);
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];

    [self fetchStandorte];
}

@end

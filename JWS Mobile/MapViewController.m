//
//  MapViewController.m
//  JWS Mobile
//
//  Created by Björn Martensen on 05.02.12.
//  Copyright (c) 2012 eberle & wollweber COMMUNICATIONS GmbH. All rights reserved.
//

#import "MapViewController.h"
#import <MapKit/MapKit.h>
#import "JWSStandortAnnotation.h"

@interface MapViewController() <MKMapViewDelegate>
@property (weak, nonatomic) IBOutlet MKMapView *mapView;
@end

@implementation MapViewController
@synthesize mapView = _mapView;
@synthesize annotations = _annotations;
@synthesize delegate = _delegate;

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

- (NSArray *)annotations
{
    
    NSMutableArray *annotations = nil;
    
    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"standorte" ofType:@"plist"];
    
    if ([[NSFileManager defaultManager] fileExistsAtPath:filePath]) {
        NSArray *standorte = [NSArray arrayWithContentsOfFile:filePath];
        
        annotations = [NSMutableArray arrayWithCapacity:standorte.count];
        
        for (NSDictionary *standort in standorte) {
            [annotations addObject:[JWSStandortAnnotation annotationForStandort:standort]];
        }
    }
    
    return annotations;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];

    if (self.annotations.count) {
        JWSStandortAnnotation *annotation = [self.annotations objectAtIndex:0];
        MKCoordinateRegion region;
        region.center = annotation.coordinate;
        
        MKCoordinateSpan span;
        span.latitudeDelta = 0.05;
        span.longitudeDelta = 0.05;
        region.span = span;
    
        [self.mapView setRegion:region animated:YES];
    }
}

- (void)track {
    if ([CLLocationManager locationServicesEnabled] == NO) {
        UIAlertView *servicesDisabledAlert = [[UIAlertView alloc] initWithTitle:@"Location Services Disabled" message:@"You currently have all location services for this device disabled. If you proceed, you will be asked to confirm whether location services should be reenabled." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [servicesDisabledAlert show];
    } else {
        if (self.mapView.showsUserLocation) {
            MKCoordinateRegion region;
            region.center = self.mapView.userLocation.location.coordinate;
            
            MKCoordinateSpan span;
            span.latitudeDelta = 0.02;
            span.longitudeDelta = 0.02;
            region.span = span;
            
            [self.mapView setRegion:region animated:YES];
        }
    }
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.mapView.showsUserLocation = YES;
    
    [self.mapView addAnnotations:[self annotations]];
    
    MKUserTrackingBarButtonItem *trackButton = [[MKUserTrackingBarButtonItem alloc] initWithMapView:self.mapView];
    [trackButton setTarget:self];
    [trackButton setAction:@selector(track)];
    
    self.navigationItem.rightBarButtonItem = trackButton;
}

- (MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id<MKAnnotation>)annotation
{
    if ([annotation isKindOfClass:[MKUserLocation class]]) {
        return nil;
    }
    static NSString *CellIdentifier = @"MapVC";
    
    MKAnnotationView *aView = [mapView dequeueReusableAnnotationViewWithIdentifier:CellIdentifier];
    if (!aView) {
        aView = [[MKPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:CellIdentifier];
        aView.canShowCallout = YES;
        
        UIButton *disclosureButton = [UIButton buttonWithType:UIButtonTypeDetailDisclosure];
        aView.rightCalloutAccessoryView = disclosureButton;
    }
    aView.annotation = annotation;
    
    return aView;
}

- (void)mapView:(MKMapView *)mapView annotationView:(MKAnnotationView *)view calloutAccessoryControlTapped:(UIControl *)control
{
    NSDictionary *standort = [self.delegate mapViewcontroller:self dictionaryForAnnotation:view.annotation];
    [self performSegueWithIdentifier:@"Show Standort" sender:view];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"Show Standort"]) {

        JWSStandortAnnotation *annotation = [(JWSStandortAnnotation *)sender performSelector:@selector(annotation)];

        if ([segue.destinationViewController respondsToSelector:@selector(setStandort:)]) {
            [segue.destinationViewController performSelector:@selector(setStandort:) withObject:annotation.standort];
        }
    }
}

@end

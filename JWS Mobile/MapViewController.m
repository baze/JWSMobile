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
    [self performSegueWithIdentifier:@"Show Standort" sender:view];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"Show Standort"]) {
        
        JWSStandortAnnotation *annotation = [(JWSStandortAnnotation *)sender performSelector:@selector(annotation)];

//        NSDictionary *standort = [self.delegate mapViewcontroller:self dictionaryForAnnotation:annotation];

        if ([segue.destinationViewController respondsToSelector:@selector(setStandort:)]) {
            [segue.destinationViewController performSelector:@selector(setStandort:) withObject:annotation.standort];
        }
    }
}

/*
- (void)updateVisibleAnnotations
{
    // Fix performance and visual clutter by calling update when we change
    // map regions
    // This value controls the number of off screen annotations and displayed.
    // A bigger number means more annotations, less chance of seeing annotation views pop in but decreased performance.
    // A smaller number means fewer annotations, more chance of seeing annotation views pop in but better performance.
    static float marginFactor = 2.0;
    
    // Adjust this roughly based on the dimensions of your annotation views.
    // Bigger numbers more aggressively coalesce annotations (fewer annotations displayed but better performance).
    // Numbers too small result in overlapping annotation views and too many annotations on screen.
    static float bucketSize = 60.0;
    
    // Find all the annotations in the visible area + a wide margin to avoid popping annotation views in an out while panning the map.
    MKMapRect visibleMapRect = [self.mapView visibleMapRect];
    MKMapRect adjustedVisibleMapRect = MKMapRectInset(visibleMapRect, -marginFactor * visibleMapRect.size.width, -marginFactor * visibleMapRect.size.height);
    
    // Determine how wide each bucket will be, as a MKMapRect square
    CLLocationCoordinate2D leftCoordinate = [self.mapView convertPoint:CGPointZero toCoordinateFromView:self.view];
    CLLocationCoordinate2D rightCoordinate = [self.mapView convertPoint:CGPointMake(bucketSize, 0) toCoordinateFromView:self.view];
    double gridSize = MKMapPointForCoordinate(rightCoordinate).x - MKMapPointForCoordinate(leftCoordinate).x;
    MKMapRect gridMapRect = MKMapRectMake(0, 0, gridSize, gridSize);
    
    // Condense annotations, with a padding of two squares around the visibleMapRect
    double startX = floor(MKMapRectGetMinX(adjustedVisibleMapRect) / gridSize) * gridSize;
    double startY = floor(MKMapRectGetMinY(adjustedVisibleMapRect) / gridSize) * gridSize;
    double endX = floor(MKMapRectGetMaxX(adjustedVisibleMapRect) / gridSize) * gridSize;
    double endY = floor(MKMapRectGetMaxY(adjustedVisibleMapRect) / gridSize) * gridSize;
    
    // For each square in our grid, pick one annotation to show
    gridMapRect.origin.y = startY;
    while (MKMapRectGetMinY(gridMapRect) <= endY) {
        gridMapRect.origin.x = startX;
        
        while (MKMapRectGetMinX(gridMapRect) <= endX) {
            
            
            
            
            
            
            
            
            
            
            
            
            
        }
        
        gridMapRect.origin.x += gridSize;
    }
    
    gridMapRect.origin.y += gridSize;
}
*/
@end

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
#import "ContactViewController.h"

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

- (NSArray *)annotations
{
    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"standorte" ofType:@"plist"];
    
    NSMutableArray *annotations = nil;
    
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
    
    [self.mapView addAnnotations:[self annotations]];
    
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

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.mapView.delegate = self;
}

- (MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id<MKAnnotation>)annotation
{
    MKAnnotationView *aView = [mapView dequeueReusableAnnotationViewWithIdentifier:@"MapVC"];
    if (!aView) {
        aView = [[MKPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:@"MapVC"];
        aView.canShowCallout = YES;
        
        UIButton *disclosureButton = [UIButton buttonWithType:UIButtonTypeDetailDisclosure];
        aView.rightCalloutAccessoryView = disclosureButton;
        
        aView.leftCalloutAccessoryView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 30, 30)];
    }
    aView.annotation = annotation;
    [(UIImageView *)aView.leftCalloutAccessoryView setImage:nil];
    
    return aView;
}

- (void)mapView:(MKMapView *)mapView didSelectAnnotationView:(MKAnnotationView *)view
{
    UIImage *image = nil;
    [(UIImageView *)view.leftCalloutAccessoryView setImage:image];
}

- (void)mapView:(MKMapView *)mapView annotationView:(MKAnnotationView *)view calloutAccessoryControlTapped:(UIControl *)control
{
    if (![view.annotation isKindOfClass:[JWSStandortAnnotation class]])
        return;
    
    NSDictionary *standort = nil;
    
    ContactViewController *viewController = [[ContactViewController alloc] init];
    viewController.standort = standort;
    [self.navigationController pushViewController:viewController animated:YES];
}

@end

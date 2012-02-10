//
//  JWSStandortAnnotation.m
//  JWS Mobile
//
//  Created by Björn Martensen on 05.02.12.
//  Copyright (c) 2012 eberle & wollweber COMMUNICATIONS GmbH. All rights reserved.
//

#import "JWSStandortAnnotation.h"
#import "JWSSubstitutionsFetcher.h"

@implementation JWSStandortAnnotation

@synthesize standort = _standort;

+ (JWSStandortAnnotation *)annotationForStandort:(NSDictionary *)standort
{
    JWSStandortAnnotation *annotation = [[JWSStandortAnnotation alloc] init];
    annotation.standort = standort;
    return annotation;
}

- (NSString *)title
{
    return [self.standort objectForKey:STANDORT_TITLE];
}

- (NSString *)subtitle
{
    return [self.standort objectForKey:STANDORT_SUBTITLE];
}

- (CLLocationCoordinate2D)coordinate
{
    CLLocationCoordinate2D coordinate;
    coordinate.latitude = [[self.standort valueForKeyPath:STANDORT_LATITUDE] doubleValue];
    coordinate.longitude = [[self.standort valueForKeyPath:STANDORT_LONGITUDE] doubleValue];
    return coordinate;
}


@end

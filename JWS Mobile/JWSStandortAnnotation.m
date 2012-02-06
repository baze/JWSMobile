//
//  JWSStandortAnnotation.m
//  JWS Mobile
//
//  Created by Björn Martensen on 05.02.12.
//  Copyright (c) 2012 eberle & wollweber COMMUNICATIONS GmbH. All rights reserved.
//

#import "JWSStandortAnnotation.h"

@implementation JWSStandortAnnotation

@synthesize standort = _standort;

+ (JWSStandortAnnotation *)annotationForStandort:(NSDictionary *)standort
{
    JWSStandortAnnotation *annotation = [[JWSStandortAnnotation alloc] init];
    annotation.standort = standort;
    return annotation;
}


@end

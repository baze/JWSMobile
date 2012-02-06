//
//  JWSStandortAnnotation.h
//  JWS Mobile
//
//  Created by Björn Martensen on 05.02.12.
//  Copyright (c) 2012 eberle & wollweber COMMUNICATIONS GmbH. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>

@interface JWSStandortAnnotation : NSObject <MKAnnotation>

+ (JWSStandortAnnotation *)annotationForStandort:(NSDictionary *)standort;

@property (nonatomic, strong) NSDictionary *standort;

@end

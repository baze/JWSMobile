//
//  SubstitutionsFetcher.h
//  Shutterbug
//
//  Created by Björn Martensen on 24.01.12.
//  Copyright (c) 2012 eberle & wollweber COMMUNICATIONS GmbH. All rights reserved.
//

#import <Foundation/Foundation.h>

#define SUBSTITUTION_CLASS @"Klasse"
#define SUBSTITUTION_DAY @"Tag"
#define SUBSTITUTION_POS @"Pos"
#define SUBSTITUTION_TEACHER @"Lehrer"
#define SUBSTITUTION_SUBJECT @"Fach"
#define SUBSTITUTION_ROOM @"Raum"
#define SUBSTITUTION_SUBSTITUTION @"VLehrer"
#define SUBSTITUTION_INFO @"Info"
#define SUBSTITUTION_ID @"hash"
#define SUBSTITUTION_DATE @"date"

#define STANDORT_ADDRESS @"street"
#define STANDORT_TITLE @"type"
#define STANDORT_ZIP @"zip"
#define STANDORT_CITY @"city"
#define STANDORT_PHONE @"phone"
#define STANDORT_LATITUDE @"coordinates.latitude"
#define STANDORT_LONGITUDE @"coordinates.longitude"

@interface JWSSubstitutionsFetcher : NSObject

+ (NSArray *)recentSubstitutions;
+ (NSArray *)standorte;

@end

//
//  Substitution.h
//  JWS Mobile
//
//  Created by Björn Martensen on 11.03.12.
//  Copyright (c) 2012 eberle & wollweber COMMUNICATIONS GmbH. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Day, SchoolClass;

@interface Substitution : NSManagedObject

@property (nonatomic, retain) NSString * fach;
@property (nonatomic, retain) NSString * info;
@property (nonatomic, retain) NSString * lehrer;
@property (nonatomic, retain) NSString * pos;
@property (nonatomic, retain) NSString * raum;
@property (nonatomic, retain) NSString * tag;
@property (nonatomic, retain) NSString * unique;
@property (nonatomic, retain) NSString * vlehrer;
@property (nonatomic, retain) Day *date;
@property (nonatomic, retain) SchoolClass *klasse;

@end

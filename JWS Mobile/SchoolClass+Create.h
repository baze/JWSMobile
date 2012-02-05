//
//  SchoolClass+Create.h
//  JWS Mobile
//
//  Created by Björn Martensen on 05.02.12.
//  Copyright (c) 2012 eberle & wollweber COMMUNICATIONS GmbH. All rights reserved.
//

#import "SchoolClass.h"

@interface SchoolClass (Create)

+ (SchoolClass *)schoolClassWithName:(NSString *)name inManagedObjectContext:(NSManagedObjectContext *)context;

@end

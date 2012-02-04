//
//  Substitution+JWS.h
//  JWS Mobile
//
//  Created by Björn Martensen on 04.02.12.
//  Copyright (c) 2012 eberle & wollweber COMMUNICATIONS GmbH. All rights reserved.
//

#import "Substitution.h"

@interface Substitution (JWS)

+ (Substitution *)substitutionWithInfo:(NSDictionary* )jwsInfo inManagedObjectContext:(NSManagedObjectContext *)context;

@end

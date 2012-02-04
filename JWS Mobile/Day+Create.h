//
//  Day+Create.h
//  JWS Mobile
//
//  Created by Björn Martensen on 04.02.12.
//  Copyright (c) 2012 eberle & wollweber COMMUNICATIONS GmbH. All rights reserved.
//

#import "Day.h"

@interface Day (Create)

+ (Day *)dayWithDate:(NSString *)date inManagedObjectContext:(NSManagedObjectContext *)context;

@end

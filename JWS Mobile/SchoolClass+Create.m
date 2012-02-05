//
//  SchoolClass+Create.m
//  JWS Mobile
//
//  Created by Björn Martensen on 05.02.12.
//  Copyright (c) 2012 eberle & wollweber COMMUNICATIONS GmbH. All rights reserved.
//

#import "SchoolClass+Create.h"

@implementation SchoolClass (Create)

+ (SchoolClass *)schoolClassWithName:(NSString *)name inManagedObjectContext:(NSManagedObjectContext *)context
{
    SchoolClass *schoolClass = nil;
    
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"SchoolClass"];
    request.predicate = [NSPredicate predicateWithFormat:@"name = %@", name];
    NSSortDescriptor *sortDescriptor = [NSSortDescriptor sortDescriptorWithKey:@"name" ascending:YES];
    request.sortDescriptors = [NSArray arrayWithObject:sortDescriptor];
    
    NSError *error = nil;
    NSArray *schoolClasses = [context executeFetchRequest:request error:&error];
    
    if (!schoolClasses || ([schoolClasses count] > 1)) {
        // handle error
    } else if (![schoolClasses count]) {
        schoolClass = [NSEntityDescription insertNewObjectForEntityForName:@"SchoolClass" inManagedObjectContext:context];
        schoolClass.name = name;
    } else {
        schoolClass = [schoolClasses lastObject];
    }
    
    return schoolClass;
}
@end

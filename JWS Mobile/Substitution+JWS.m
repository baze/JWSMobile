//
//  Substitution+JWS.m
//  JWS Mobile
//
//  Created by Björn Martensen on 04.02.12.
//  Copyright (c) 2012 eberle & wollweber COMMUNICATIONS GmbH. All rights reserved.
//

#import "Substitution+JWS.h"
#import "SubstitutionsFetcher.h"
#import "Day+Create.h"
#import "SchoolClass+Create.h"

@implementation Substitution (JWS)

+ (Substitution *)substitutionWithInfo:(NSDictionary* )jwsInfo inManagedObjectContext:(NSManagedObjectContext *)context
{
    Substitution *substitution = nil;
    
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"Substitution"];
    request.predicate = [NSPredicate predicateWithFormat:@"unique = %@", [jwsInfo objectForKey:SUBSTITUTION_ID]];
    NSSortDescriptor *sortDescriptor = [NSSortDescriptor sortDescriptorWithKey:@"klasse" ascending:YES];
    request.sortDescriptors = [NSArray arrayWithObject:sortDescriptor];
    
    NSError *error = nil;
    NSArray *matches = [context executeFetchRequest:request error:&error];
    if (!matches || ([matches count] > 1)) {
        // handle error
    } else if ([matches count] == 0) {
        substitution = [NSEntityDescription insertNewObjectForEntityForName:@"Substitution" 
                                              inManagedObjectContext:context];
        
        //substitution.klasse = [jwsInfo objectForKey:SUBSTITUTION_CLASS];
        substitution.klasse = [SchoolClass schoolClassWithName:[jwsInfo objectForKey:SUBSTITUTION_CLASS] inManagedObjectContext:context];
        substitution.tag = [jwsInfo objectForKey:SUBSTITUTION_DAY];
        substitution.pos = [jwsInfo objectForKey:SUBSTITUTION_POS];
        substitution.lehrer = [jwsInfo objectForKey:SUBSTITUTION_TEACHER];
        substitution.fach = [jwsInfo objectForKey:SUBSTITUTION_SUBJECT];
        substitution.raum = [jwsInfo objectForKey:SUBSTITUTION_ROOM];
        substitution.vlehrer = [jwsInfo objectForKey:SUBSTITUTION_SUBSTITUTION];
        substitution.info = [jwsInfo objectForKey:SUBSTITUTION_INFO];
        substitution.unique = [jwsInfo objectForKey:SUBSTITUTION_ID];
        substitution.date = [Day dayWithDate:[jwsInfo objectForKey:SUBSTITUTION_DATE] inManagedObjectContext:context];
    } else {
        substitution = [matches lastObject];
    }
    
    return substitution;
}

@end

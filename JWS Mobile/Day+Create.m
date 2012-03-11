//
//  Day+Create.m
//  JWS Mobile
//
//  Created by Björn Martensen on 04.02.12.
//  Copyright (c) 2012 eberle & wollweber COMMUNICATIONS GmbH. All rights reserved.
//

#import "Day+Create.h"

@implementation Day (Create)

+ (Day *)dayWithDate:(NSString *)date inManagedObjectContext:(NSManagedObjectContext *)context
{
    Day *day = nil;

    NSArray *components = [date componentsSeparatedByString:@" "];
    NSString *datePart = [components lastObject];
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    dateFormatter.dateFormat = @"dd.MM.yyyy";
    dateFormatter.timeZone = [NSTimeZone timeZoneWithAbbreviation:@"GMT"];
    NSDate *myDate = [dateFormatter dateFromString:datePart];

    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"Day"];
    request.predicate = [NSPredicate predicateWithFormat:@"date = %@", myDate];
    NSSortDescriptor *sortDescriptor = [NSSortDescriptor sortDescriptorWithKey:@"date" ascending:YES];
    request.sortDescriptors = [NSArray arrayWithObject:sortDescriptor];
    
    NSError *error = nil;
    NSArray *days = [context executeFetchRequest:request error:&error];
    
    if (!days || ([days count] > 1)) {
        // handle error
    } else if (![days count]) {
        day = [NSEntityDescription insertNewObjectForEntityForName:@"Day" inManagedObjectContext:context];
        day.date = myDate;
    } else {
        day = [days lastObject];
    }
    
    return day;
}

@end

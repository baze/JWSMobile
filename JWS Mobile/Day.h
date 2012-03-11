//
//  Day.h
//  JWS Mobile
//
//  Created by Björn Martensen on 11.03.12.
//  Copyright (c) 2012 eberle & wollweber COMMUNICATIONS GmbH. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Substitution;

@interface Day : NSManagedObject

@property (nonatomic, retain) NSDate * date;
@property (nonatomic, retain) NSSet *substitutions;
@end

@interface Day (CoreDataGeneratedAccessors)

- (void)addSubstitutionsObject:(Substitution *)value;
- (void)removeSubstitutionsObject:(Substitution *)value;
- (void)addSubstitutions:(NSSet *)values;
- (void)removeSubstitutions:(NSSet *)values;

@end

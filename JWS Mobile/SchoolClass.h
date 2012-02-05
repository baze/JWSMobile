//
//  SchoolClass.h
//  JWS Mobile
//
//  Created by Björn Martensen on 05.02.12.
//  Copyright (c) 2012 eberle & wollweber COMMUNICATIONS GmbH. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Substitution;

@interface SchoolClass : NSManagedObject

@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSSet *substitutions;
@end

@interface SchoolClass (CoreDataGeneratedAccessors)

- (void)addSubstitutionsObject:(Substitution *)value;
- (void)removeSubstitutionsObject:(Substitution *)value;
- (void)addSubstitutions:(NSSet *)values;
- (void)removeSubstitutions:(NSSet *)values;

@end

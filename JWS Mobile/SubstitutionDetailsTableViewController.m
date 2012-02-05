//
//  SubstitutionDetailsTableViewController.m
//  JWS Mobile
//
//  Created by Björn Martensen on 05.02.12.
//  Copyright (c) 2012 eberle & wollweber COMMUNICATIONS GmbH. All rights reserved.
//

#import "SubstitutionDetailsTableViewController.h"


@implementation SubstitutionDetailsTableViewController

@synthesize substitution = _substitution;

- (void)setSubstitution:(NSDictionary *)substitution
{
    if (_substitution != substitution) {
        _substitution = substitution;
    }
}

@end

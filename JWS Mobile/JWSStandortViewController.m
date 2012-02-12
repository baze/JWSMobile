//
//  JWSStandortViewController.m
//  JWS Mobile
//
//  Created by Björn Martensen on 12.02.12.
//  Copyright (c) 2012 eberle & wollweber COMMUNICATIONS GmbH. All rights reserved.
//

#import "JWSStandortViewController.h"
#import "JWSSubstitutionsFetcher.h"

@implementation JWSStandortViewController

@synthesize standort = _standort;

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.title = [self.standort objectForKey:STANDORT_TITLE];
}

@end

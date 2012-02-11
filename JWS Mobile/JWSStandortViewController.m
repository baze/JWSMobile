//
//  JWSStandortViewController.m
//  JWS Mobile
//
//  Created by Björn Martensen on 11.02.12.
//  Copyright (c) 2012 eberle & wollweber COMMUNICATIONS GmbH. All rights reserved.
//

#import "JWSStandortViewController.h"

@implementation JWSStandortViewController

@synthesize standort = _standort;

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    NSLog(@"%@", self.standort);
}

@end

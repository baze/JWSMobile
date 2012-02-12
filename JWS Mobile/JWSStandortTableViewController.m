//
//  JWSStandortTableViewController.m
//  JWS Mobile
//
//  Created by Björn Martensen on 12.02.12.
//  Copyright (c) 2012 eberle & wollweber COMMUNICATIONS GmbH. All rights reserved.
//

#import "JWSStandortTableViewController.h"
#import "JWSSubstitutionsFetcher.h"

@implementation JWSStandortTableViewController

@synthesize schoolLabel = _schoolLabel;
@synthesize addressLabel = _addressLabel;
@synthesize cityLabel = _cityLabel;
@synthesize phoneLabel = _phoneLabel;
@synthesize standort = _standort;

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    self.title = [self.standort objectForKey:STANDORT_TITLE];
    
    self.schoolLabel.text = [self.standort objectForKey:STANDORT_TITLE];
    self.addressLabel.text = [self.standort objectForKey:STANDORT_ADDRESS];
    self.cityLabel.text = [NSString stringWithFormat:@"%@ %@", [self.standort objectForKey:STANDORT_ZIP], [self.standort objectForKey:STANDORT_CITY]];
    self.phoneLabel.text = [self.standort objectForKey:STANDORT_PHONE];
}


- (void)viewDidUnload {
    [self setSchoolLabel:nil];
    [self setAddressLabel:nil];
    [self setCityLabel:nil];
    [self setPhoneLabel:nil];
    [super viewDidUnload];
}
@end

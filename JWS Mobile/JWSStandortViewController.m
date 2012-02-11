//
//  JWSStandortViewController.m
//  JWS Mobile
//
//  Created by Björn Martensen on 11.02.12.
//  Copyright (c) 2012 eberle & wollweber COMMUNICATIONS GmbH. All rights reserved.
//

#import "JWSStandortViewController.h"
#import "JWSSubstitutionsFetcher.h"

@implementation JWSStandortViewController

@synthesize standort = _standort;

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:UITableViewStyleGrouped];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewWillAppear:(BOOL)animated
{
    self.title = [self.standort objectForKey:STANDORT_TITLE];
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return 3;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    int row = indexPath.row;
    
    UITableViewCell *cityCell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue2 reuseIdentifier:CellIdentifier];
    UITableViewCell *addressCell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue2 reuseIdentifier:CellIdentifier];
    UITableViewCell *phoneCell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue2 reuseIdentifier:CellIdentifier];
    
    cityCell.textLabel.text = @"PLZ, Ort";
    cityCell.detailTextLabel.text = [NSString stringWithFormat:@"%@ %@", [self.standort objectForKey:STANDORT_ZIP], [self.standort objectForKey:STANDORT_CITY]];
    
    addressCell.textLabel.text = @"Adresse";
    addressCell.detailTextLabel.text = [self.standort objectForKey:STANDORT_ADDRESS];
    
    phoneCell.textLabel.text = @"Telefon";
    phoneCell.detailTextLabel.text = [self.standort objectForKey:STANDORT_PHONE];
    
    if (row == 0) {
        return addressCell;
    } else if (row == 1) {
        return cityCell;
    }
    
    return phoneCell;
}


@end

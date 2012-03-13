//
//  SubstitutionDetailsTableViewController.m
//  JWS Mobile
//
//  Created by Björn Martensen on 05.02.12.
//  Copyright (c) 2012 eberle & wollweber COMMUNICATIONS GmbH. All rights reserved.
//

#import "SubstitutionDetailsTableViewController.h"

@implementation SubstitutionDetailsTableViewController

/* @synthesize DatumLabel = _DatumLabel;
@synthesize KlasseLabel = _KlasseLabel;
@synthesize LehrerLabel = _LehrerLabel;
@synthesize VLehrerLabel = _VLehrerLabel;
@synthesize PosLabel = _PosLabel;
@synthesize RaumLabel = _RaumLabel;
@synthesize InfoLabel = _InfoLabel; */

@synthesize substitutions = _substitutions;

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    NSLog(@"%@", self.substitutions);
    
/*    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = @"EEEE, dd.MM.yyyy";
    NSString *stringFromDate = [formatter stringFromDate:[self.substitution objectForKey:@"datum"]];
    
    self.DatumLabel.text = stringFromDate;
    self.KlasseLabel.text = [self.substitution objectForKey:@"klasse"];
    self.LehrerLabel.text = [self.substitution objectForKey:@"lehrer"];
    self.VLehrerLabel.text = [self.substitution objectForKey:@"vlehrer"];
    self.PosLabel.text = [self.substitution objectForKey:@"pos"];
    self.RaumLabel.text = [self.substitution objectForKey:@"raum"];
    self.InfoLabel.text = [self.substitution objectForKey:@"info"]; */
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return self.substitutions.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Detail Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    // Configure the cell...
    
    return cell;
}

@end

//
//  SubstitutionsTableViewController.m
//  JWS Mobile
//
//  Created by Björn Martensen on 04.02.12.
//  Copyright (c) 2012 eberle & wollweber COMMUNICATIONS GmbH. All rights reserved.
//

#import "SubstitutionsByDayTableViewController.h"
#import "Substitution.h"

@implementation SubstitutionsByDayTableViewController

@synthesize day = _day;

- (void)setupFetchedResultsController
{
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"Substitution"];
    request.sortDescriptors = [NSArray arrayWithObject:[NSSortDescriptor sortDescriptorWithKey:@"klasse.name" ascending:YES selector:@selector(localizedCaseInsensitiveCompare:)]];
    request.predicate = [NSPredicate predicateWithFormat:@"date.date = %@", self.day.date];
    
    self.fetchedResultsController = [[NSFetchedResultsController alloc] initWithFetchRequest:request
                                                                        managedObjectContext:self.day.managedObjectContext 
                                                                          sectionNameKeyPath:nil 
                                                                                   cacheName:nil];
}

- (void)setDay:(Day *)day
{
    if (_day != day) {
        _day = day;
        self.title = day.date;
        [self setupFetchedResultsController];
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Substitution Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    // Configure the cell...
    Substitution *substitution = [self.fetchedResultsController objectAtIndexPath:indexPath];
    cell.textLabel.text = [substitution valueForKeyPath:@"klasse.name"];
    cell.detailTextLabel.text = substitution.lehrer;
    
    return cell;
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    NSIndexPath *indexPath = [self.tableView indexPathForCell:sender];
    Substitution *substitution = [self.fetchedResultsController objectAtIndexPath:indexPath];
    if ([segue.destinationViewController respondsToSelector:@selector(setSubstitution:)]) {
        
        NSDictionary *substitutionDictionary = [NSDictionary dictionaryWithObjects:[NSArray arrayWithObjects:substitution.date.date, [substitution valueForKeyPath:@"klasse.name"], substitution.lehrer, substitution.vlehrer, substitution.pos, substitution.raum, substitution.info, nil] forKeys:[NSArray arrayWithObjects:@"datum", @"klasse", @"lehrer", @"vlehrer", @"pos", @"raum", @"info", nil]];
        
        [segue.destinationViewController performSelector:@selector(setSubstitution:) withObject:substitutionDictionary];
    }
}

@end

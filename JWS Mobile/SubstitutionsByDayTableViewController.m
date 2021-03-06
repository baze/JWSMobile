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

    NSPredicate *compoundPredicate = [NSCompoundPredicate andPredicateWithSubpredicates:[NSArray arrayWithObjects:[NSPredicate predicateWithFormat:@"NOT klasse.name LIKE '&nbsp;'"], [NSPredicate predicateWithFormat:@"date.date = %@", self.day.date], nil]];
    request.predicate = compoundPredicate;
    
    self.fetchedResultsController = [[NSFetchedResultsController alloc] initWithFetchRequest:request
                                                                        managedObjectContext:self.day.managedObjectContext 
                                                                          sectionNameKeyPath:nil 
                                                                                   cacheName:nil];
}

- (void)setDay:(Day *)day
{
    if (_day != day) {
        _day = day;
        
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        formatter.dateFormat = @"dd.MM.yyyy";
        NSString *stringFromDate = [formatter stringFromDate:day.date];
        
        self.title = stringFromDate;
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
    
    if ([segue.destinationViewController respondsToSelector:@selector(setSubstitutions:)]) {
        
        NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"Substitution"];
        request.sortDescriptors = [NSArray arrayWithObject:[NSSortDescriptor sortDescriptorWithKey:@"klasse.name" ascending:YES selector:@selector(localizedCaseInsensitiveCompare:)]];
        
        NSPredicate *compoundPredicate = [NSCompoundPredicate andPredicateWithSubpredicates:[NSArray arrayWithObjects:
                                                                                             [NSPredicate predicateWithFormat:@"date.date = %@", [substitution valueForKeyPath:@"date.date"]],
                                                                                             [NSPredicate predicateWithFormat:@"klasse.name = %@", [substitution valueForKeyPath:@"klasse.name"]], nil]];
        request.predicate = compoundPredicate;
        
        NSArray *substitutions = [substitution.managedObjectContext executeFetchRequest:request error:nil];

        [segue.destinationViewController performSelector:@selector(setSubstitutions:) withObject:substitutions];
    }
}

@end

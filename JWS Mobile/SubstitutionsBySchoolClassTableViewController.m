//
//  SubstitutionsByClassTableViewController.m
//  JWS Mobile
//
//  Created by Björn Martensen on 05.02.12.
//  Copyright (c) 2012 eberle & wollweber COMMUNICATIONS GmbH. All rights reserved.
//

#import "SubstitutionsBySchoolClassTableViewController.h"
#import "Substitution.h"

@implementation SubstitutionsBySchoolClassTableViewController

@synthesize schoolClass = _schoolClass;

- (void)setupFetchedResultsController
{
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"Substitution"];
    request.sortDescriptors = [NSArray arrayWithObject:[NSSortDescriptor sortDescriptorWithKey:@"klasse.name" ascending:YES selector:@selector(localizedCaseInsensitiveCompare:)]];
    request.predicate = [NSPredicate predicateWithFormat:@"klasse.name = %@", self.schoolClass.name];
    
    self.fetchedResultsController = [[NSFetchedResultsController alloc] initWithFetchRequest:request
                                                                        managedObjectContext:self.schoolClass.managedObjectContext 
                                                                          sectionNameKeyPath:nil 
                                                                                   cacheName:nil];
}

- (void)setSchoolClass:(SchoolClass *)schoolClass
{
    if (_schoolClass != schoolClass) {
        _schoolClass = schoolClass;
         self.title = schoolClass.name;
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
    cell.textLabel.text = substitution.klasse.name;
    cell.detailTextLabel.text = substitution.lehrer;
    
    return cell;
}

@end

//
//  SchoolClassesTableViewController.m
//  JWS Mobile
//
//  Created by Björn Martensen on 05.02.12.
//  Copyright (c) 2012 eberle & wollweber COMMUNICATIONS GmbH. All rights reserved.
//

#import "SchoolClassesTableViewController.h"
#import "SchoolClass.h"

@implementation SchoolClassesTableViewController

@synthesize substitutionDatabase = _substitutionDatabase;
@synthesize searchBar = _searchBar;

-(void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText {
    if (searchText.length > 0) {
        NSPredicate *predicate = [NSPredicate predicateWithFormat:@"name LIKE[c] %@", [NSString stringWithFormat:@"*%@*", searchText]];
        [self setupFetchedResultsControllerWithPredicate:predicate];
    } else {
        [self setupFetchedResultsControllerWithPredicate:nil];
    }
}

- (void)setupFetchedResultsController
{
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"SchoolClass"];
    request.sortDescriptors = [NSArray arrayWithObject:[NSSortDescriptor sortDescriptorWithKey:@"name" ascending:YES selector:@selector(localizedCaseInsensitiveCompare:)]];
    
    self.fetchedResultsController = [[NSFetchedResultsController alloc] initWithFetchRequest:request
                                                                        managedObjectContext:self.substitutionDatabase.managedObjectContext 
                                                                          sectionNameKeyPath:nil 
                                                                                   cacheName:nil];
}

- (void)setupFetchedResultsControllerWithPredicate:(NSPredicate *)predicate
{
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"SchoolClass"];
    request.sortDescriptors = [NSArray arrayWithObject:[NSSortDescriptor sortDescriptorWithKey:@"name"ascending:YES selector:@selector(localizedCaseInsensitiveCompare:)]];
    
    NSPredicate *myPredicate = [NSPredicate predicateWithFormat:@"NOT name LIKE '&nbsp;'"];
    
    if (predicate) {
        NSPredicate *compoundPredicate = [NSCompoundPredicate andPredicateWithSubpredicates:[NSArray arrayWithObjects:myPredicate, predicate, nil]];
        request.predicate = compoundPredicate;
    } else {
        request.predicate = myPredicate;
    }
    
    self.fetchedResultsController = [[NSFetchedResultsController alloc] initWithFetchRequest:request
                                                                        managedObjectContext:self.substitutionDatabase.managedObjectContext 
                                                                          sectionNameKeyPath:nil 
                                                                                   cacheName:nil];
}

- (void)useDocument
{
    if (![[NSFileManager defaultManager] fileExistsAtPath:[self.substitutionDatabase.fileURL path]]) {
        [self.substitutionDatabase saveToURL:self.substitutionDatabase.fileURL forSaveOperation:UIDocumentSaveForCreating completionHandler:^(BOOL success) {
            [self setupFetchedResultsControllerWithPredicate:nil];
        }];
    } else if (self.substitutionDatabase.documentState == UIDocumentStateClosed) {
        [self.substitutionDatabase openWithCompletionHandler:^(BOOL success) {
            [self setupFetchedResultsControllerWithPredicate:nil];
        }];
    } else if (self.substitutionDatabase.documentState == UIDocumentStateNormal) {
        [self setupFetchedResultsControllerWithPredicate:nil];
    }
}

- (void)setSubstitutionDatabase:(UIManagedDocument *)substitutionDatabase
{
    if (_substitutionDatabase != substitutionDatabase) {
        _substitutionDatabase = substitutionDatabase;
        [self useDocument];
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"SchoolClass Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    // Configure the cell...
    SchoolClass *schoolClass = [self.fetchedResultsController objectAtIndexPath:indexPath];
    cell.textLabel.text = schoolClass.name;
    cell.detailTextLabel.text = [NSString stringWithFormat:@"%d Vertretungsstunden", [schoolClass.substitutions count]];
    
    return cell;
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    NSIndexPath *indexPath = [self.tableView indexPathForCell:sender];
    SchoolClass *schoolClass = [self.fetchedResultsController objectAtIndexPath:indexPath];
    if ([segue.destinationViewController respondsToSelector:@selector(setSchoolClass:)]) {
        [segue.destinationViewController performSelector:@selector(setSchoolClass:) withObject:schoolClass];
    }
}

- (void)viewDidUnload {
    [self setSearchBar:nil];
    [super viewDidUnload];
}
@end

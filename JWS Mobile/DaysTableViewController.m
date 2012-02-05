//
//  DaysTableViewController.m
//  JWS Mobile
//
//  Created by Björn Martensen on 04.02.12.
//  Copyright (c) 2012 eberle & wollweber COMMUNICATIONS GmbH. All rights reserved.
//

#import "DaysTableViewController.h"
//#import "SubstitutionsFetcher.h"
#import "Day.h"
//#import "Substitution+JWS.h"


@implementation DaysTableViewController

@synthesize substitutionDatabase = _substitutionDatabase;

- (void)setupFetchedResultsController
{
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"Day"];
    request.sortDescriptors = [NSArray arrayWithObject:[NSSortDescriptor sortDescriptorWithKey:@"date" ascending:YES selector:@selector(localizedCaseInsensitiveCompare:)]];
    
    self.fetchedResultsController = [[NSFetchedResultsController alloc] initWithFetchRequest:request
                                                                        managedObjectContext:self.substitutionDatabase.managedObjectContext 
                                                                          sectionNameKeyPath:nil 
                                                                                   cacheName:nil];
}
/*
- (void)fetchSubstitutionDataIntoDocument:(UIManagedDocument *)document
{
    dispatch_queue_t fetchQ = dispatch_queue_create("Substitution fetcher", NULL);
    dispatch_async(fetchQ, ^{
        NSArray *substitutions = [SubstitutionsFetcher recentSubstitutions];
        [document.managedObjectContext performBlock:^{
            for (NSDictionary *jwsInfo in substitutions) {
                [Substitution substitutionWithInfo:jwsInfo inManagedObjectContext:document.managedObjectContext];
            } 
        }];
    });
    dispatch_release(fetchQ);
}
*/
- (void)useDocument
{
    if (![[NSFileManager defaultManager] fileExistsAtPath:[self.substitutionDatabase.fileURL path]]) {
        [self.substitutionDatabase saveToURL:self.substitutionDatabase.fileURL forSaveOperation:UIDocumentSaveForCreating completionHandler:^(BOOL success) {
            [self setupFetchedResultsController];
//            [self fetchSubstitutionDataIntoDocument:self.substitutionDatabase];
        }];
    } else if (self.substitutionDatabase.documentState == UIDocumentStateClosed) {
        [self.substitutionDatabase openWithCompletionHandler:^(BOOL success) {
            [self setupFetchedResultsController];
        }];
    } else if (self.substitutionDatabase.documentState == UIDocumentStateNormal) {
        [self setupFetchedResultsController];
    }
}

- (void)setSubstitutionDatabase:(UIManagedDocument *)substitutionDatabase
{
    if (_substitutionDatabase != substitutionDatabase) {
        _substitutionDatabase = substitutionDatabase;
        [self useDocument];
    }
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    if (!self.substitutionDatabase) {
        NSURL *url = [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
        url = [url URLByAppendingPathComponent:@"Default Substitution Database"];
        self.substitutionDatabase = [[UIManagedDocument alloc] initWithFileURL:url];
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Day Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    // Configure the cell...
    Day *day = [self.fetchedResultsController objectAtIndexPath:indexPath];
    cell.textLabel.text = day.date;
    cell.detailTextLabel.text = [NSString stringWithFormat:@"%d Vertretungen", [day.substitutions count]];
    
    return cell;
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    NSIndexPath *indexPath = [self.tableView indexPathForCell:sender];
    Day *day = [self.fetchedResultsController objectAtIndexPath:indexPath];
    if ([segue.destinationViewController respondsToSelector:@selector(setDay:)]) {
        [segue.destinationViewController setDay:day];
    }
    
}

@end

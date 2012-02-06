//
//  JWSMobileViewController.m
//  JWS Mobile
//
//  Created by Björn Martensen on 04.02.12.
//  Copyright (c) 2012 eberle & wollweber COMMUNICATIONS GmbH. All rights reserved.
//

#import "JWSMobileViewController.h"
#import "JWSSubstitutionsFetcher.h"
#import "Substitution+JWS.h"

@implementation JWSMobileViewController

@synthesize substitutionDatabase = _substitutionDatabase;

- (void)fetchSubstitutionDataIntoDocument:(UIManagedDocument *)document
{
    dispatch_queue_t fetchQ = dispatch_queue_create("Substitution fetcher", NULL);
    dispatch_async(fetchQ, ^{
        NSArray *substitutions = [JWSSubstitutionsFetcher recentSubstitutions];
        [document.managedObjectContext performBlock:^{
            for (NSDictionary *jwsInfo in substitutions) {
                [Substitution substitutionWithInfo:jwsInfo inManagedObjectContext:document.managedObjectContext];
            }
        }];
    });
    dispatch_release(fetchQ);
}

- (void)useDocument
{
    if (![[NSFileManager defaultManager] fileExistsAtPath:[self.substitutionDatabase.fileURL path]]) {
        [self.substitutionDatabase saveToURL:self.substitutionDatabase.fileURL forSaveOperation:UIDocumentSaveForCreating completionHandler:^(BOOL success) {
            [self fetchSubstitutionDataIntoDocument:self.substitutionDatabase];
        }];
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

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.destinationViewController respondsToSelector:@selector(setSubstitutionDatabase:)]) {
        [segue.destinationViewController setSubstitutionDatabase:self.substitutionDatabase];
    }
}


- (void) deleteAllEntitiesForName:(NSString*)entityName {
    NSManagedObjectContext *moc = self.substitutionDatabase.managedObjectContext;
    NSEntityDescription *entityDescription = [NSEntityDescription entityForName:entityName 
                                                         inManagedObjectContext:moc];
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    [request setEntity:entityDescription];
    NSError *error = nil;
    NSArray *array = [moc executeFetchRequest:request error:&error];
    if (array != nil) {
        for(NSManagedObject *managedObject in array) {
            [moc deleteObject:managedObject];
        }
        error = nil;
        [moc save:&error];
    }
}

- (IBAction)refresh:(id)sender {
    [self deleteAllEntitiesForName:@"Day"];
    [self deleteAllEntitiesForName:@"Substitution"];
    [self deleteAllEntitiesForName:@"SchoolClass"];
    
    [self fetchSubstitutionDataIntoDocument:self.substitutionDatabase];
}

@end

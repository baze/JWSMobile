//
//  SchoolClassesTableViewController.h
//  JWS Mobile
//
//  Created by Björn Martensen on 05.02.12.
//  Copyright (c) 2012 eberle & wollweber COMMUNICATIONS GmbH. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CoreDataTableViewController.h"

@interface SchoolClassesTableViewController : CoreDataTableViewController

@property (nonatomic, strong) UIManagedDocument *substitutionDatabase;

@end

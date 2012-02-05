//
//  SubstitutionsByClassTableViewController.h
//  JWS Mobile
//
//  Created by Björn Martensen on 05.02.12.
//  Copyright (c) 2012 eberle & wollweber COMMUNICATIONS GmbH. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CoreDataTableViewController.h"
#import "SchoolClass.h"

@interface SubstitutionsBySchoolClassTableViewController : CoreDataTableViewController

@property (nonatomic, strong) SchoolClass *schoolClass;

@end

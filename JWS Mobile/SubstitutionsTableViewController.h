//
//  SubstitutionsTableViewController.h
//  JWS Mobile
//
//  Created by Björn Martensen on 04.02.12.
//  Copyright (c) 2012 eberle & wollweber COMMUNICATIONS GmbH. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CoreDataTableViewController.h"
#import "Day.h"

@interface SubstitutionsTableViewController : CoreDataTableViewController

@property (nonatomic, strong) Day *day;

@end

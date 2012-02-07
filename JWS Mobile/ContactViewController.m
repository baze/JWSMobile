//
//  ContactViewController.m
//  JWS Mobile
//
//  Created by Björn Martensen on 07.02.12.
//  Copyright (c) 2012 eberle & wollweber COMMUNICATIONS GmbH. All rights reserved.
//

#import "ContactViewController.h"


@implementation ContactViewController

@synthesize imageView = _imageView;
@synthesize standort = _standort;

- (NSArray *)standorte
{
    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"standorte" ofType:@"plist"];
    
    NSArray *standorte = nil;
    
    if ([[NSFileManager defaultManager] fileExistsAtPath:filePath]) {
        standorte = [NSArray arrayWithContentsOfFile:filePath];
    }
    
    return standorte;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    if ([[self standorte] count]) {
        self.standort = [[self standorte] objectAtIndex:0];
        NSLog(@"%@", self.standort);
    }
    
    self.imageView.contentMode = UIViewContentModeScaleAspectFit;
    self.imageView.image = [UIImage imageNamed:@"julius_wegeler_schule.png"];
}

- (void)viewDidUnload {
    [self setImageView:nil];
    [super viewDidUnload];
}
@end

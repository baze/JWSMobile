//
//  SubstitutionDetailsTableViewController.m
//  JWS Mobile
//
//  Created by Björn Martensen on 05.02.12.
//  Copyright (c) 2012 eberle & wollweber COMMUNICATIONS GmbH. All rights reserved.
//

#import "SubstitutionDetailsTableViewController.h"


@implementation SubstitutionDetailsTableViewController

@synthesize DatumLabel = _DatumLabel;
@synthesize KlasseLabel = _KlasseLabel;
@synthesize LehrerLabel = _LehrerLabel;
@synthesize VLehrerLabel = _VLehrerLabel;
@synthesize PosLabel = _PosLabel;
@synthesize RaumLabel = _RaumLabel;
@synthesize InfoLabel = _InfoLabel;
@synthesize substitution = _substitution;

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    self.DatumLabel.text = [self.substitution objectForKey:@"datum"];
    self.KlasseLabel.text = [self.substitution objectForKey:@"klasse"];
    self.LehrerLabel.text = [self.substitution objectForKey:@"lehrer"];
    self.VLehrerLabel.text = [self.substitution objectForKey:@"vlehrer"];
    self.PosLabel.text = [self.substitution objectForKey:@"pos"];
    self.RaumLabel.text = [self.substitution objectForKey:@"raum"];
    self.InfoLabel.text = [self.substitution objectForKey:@"info"];
}



- (void)viewDidUnload {
    [self setKlasseLabel:nil];
    [self setDatumLabel:nil];
    [self setLehrerLabel:nil];
    [self setVLehrerLabel:nil];
    [self setPosLabel:nil];
    [self setRaumLabel:nil];
    [self setInfoLabel:nil];
    [super viewDidUnload];
}
@end

//
//  SubstitutionDetailsCell.h
//  JWS Mobile
//
//  Created by Björn Martensen on 13.03.12.
//  Copyright (c) 2012 eberle & wollweber COMMUNICATIONS GmbH. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Substitution.h"

@interface SubstitutionDetailsCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *DatumLabel;
@property (weak, nonatomic) IBOutlet UILabel *KlasseLabel;
@property (weak, nonatomic) IBOutlet UILabel *LehrerLabel;
@property (weak, nonatomic) IBOutlet UILabel *VLehrerLabel;
@property (weak, nonatomic) IBOutlet UILabel *PosLabel;
@property (weak, nonatomic) IBOutlet UILabel *RaumLabel;
@property (weak, nonatomic) IBOutlet UILabel *InfoLabel;

@property (nonatomic, strong) Substitution *substitution;

@end

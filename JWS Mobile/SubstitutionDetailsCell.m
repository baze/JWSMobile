//
//  SubstitutionDetailsCell.m
//  JWS Mobile
//
//  Created by Björn Martensen on 13.03.12.
//  Copyright (c) 2012 eberle & wollweber COMMUNICATIONS GmbH. All rights reserved.
//

#import "SubstitutionDetailsCell.h"

@implementation SubstitutionDetailsCell

@synthesize DatumLabel = _DatumLabel;
@synthesize KlasseLabel = _KlasseLabel;
@synthesize LehrerLabel = _LehrerLabel;
@synthesize VLehrerLabel = _VLehrerLabel;
@synthesize PosLabel = _PosLabel;
@synthesize RaumLabel = _RaumLabel;
@synthesize InfoLabel = _InfoLabel;

@synthesize substitution = _substitution;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setSubstitution:(Substitution *)substitution {
    if (_substitution != substitution) {
        _substitution = substitution;
        
        self.LehrerLabel.text = substitution.lehrer;
        self.VLehrerLabel.text = substitution.vlehrer;
        self.PosLabel.text = substitution.pos;
        self.RaumLabel.text = substitution.raum;
        self.InfoLabel.text = substitution.info;
        
        self.KlasseLabel.text = [substitution valueForKeyPath:@"klasse.name"];
        
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        formatter.dateFormat = @"EEEE, dd.MM.yyyy";
        NSString *stringFromDate = [formatter stringFromDate:[substitution valueForKeyPath:@"date.date"]];
        
        self.DatumLabel.text = stringFromDate;
    }
}

@end

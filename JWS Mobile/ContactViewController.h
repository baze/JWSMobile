//
//  ContactViewController.h
//  JWS Mobile
//
//  Created by Björn Martensen on 07.02.12.
//  Copyright (c) 2012 eberle & wollweber COMMUNICATIONS GmbH. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ContactViewController : UIViewController
@property (weak, nonatomic) IBOutlet UIImageView *imageView;

@property (nonatomic, strong) NSDictionary *standort;

@end

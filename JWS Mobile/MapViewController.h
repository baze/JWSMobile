//
//  MapViewController.h
//  JWS Mobile
//
//  Created by Björn Martensen on 05.02.12.
//  Copyright (c) 2012 eberle & wollweber COMMUNICATIONS GmbH. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>

@class MapViewController;
@protocol MapViewControllerDelegate <NSObject>
- (NSDictionary *)mapViewcontroller:(MapViewController *)sender dictionaryForAnnotation:(id <MKAnnotation>)annotation;
@end

@interface MapViewController : UIViewController
@property (nonatomic, strong) NSArray *annotations;
@property (nonatomic, weak) IBOutlet id <MapViewControllerDelegate> delegate;
@end

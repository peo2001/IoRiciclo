//
//  CassonettiViewController.h
//  IoRiciclo
//
//  Created by Maria Cristina Narcisi on 15/11/13.
//  Copyright (c) 2013 Maria Cristina Narcisi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import <QuartzCore/QuartzCore.h>
#import "Cassonetto.h"
#import "Syncronizer.h"
#import "CalendarioViewController.h"

@interface CassonettiViewController :  UIViewController<MKMapViewDelegate>
{
    NSMutableArray * cassonetti;
    BOOL zoommed;
}

@property (nonatomic, strong) IBOutlet MKMapView *mapView;

@end

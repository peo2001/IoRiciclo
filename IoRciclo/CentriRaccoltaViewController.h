//
//  CentriRaccoltaViewController.h
//  IoRciclo
//
//  Created by Maria Cristina Narcisi on 15/11/13.
//  Copyright (c) 2013 Maria Cristina Narcisi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import "CentriRaccolta.h"
#import "Syncronizer.h"
#import "CalendarioViewController.h"

@interface CentriRaccoltaViewController : UIViewController<MKMapViewDelegate>
{
    NSMutableArray * centriraccolta;
}

@property (nonatomic, strong) IBOutlet MKMapView *mapView;


@end

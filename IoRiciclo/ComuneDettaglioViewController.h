//
//  ComuneDettaglioViewController.h
//  IoRiciclo
//
//  Created by Maria Cristina Narcisi on 24/02/14.
//  Copyright (c) 2014 Maria Cristina Narcisi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Comuni.h"
#import "MyApplicationSingleton.h"
#import "Syncronizer.h"

@interface ComuneDettaglioViewController : UIViewController<MKMapViewDelegate>
{
    Comuni * comune;
}
@property (nonatomic, retain) NSNumber * IdComune;
@property (strong, nonatomic) IBOutlet UILabel *lblComune;
@property (strong, nonatomic) IBOutlet UILabel *lblNumAbitanti;
@property (strong, nonatomic) IBOutlet UILabel *lblUrl;
@property (strong, nonatomic) IBOutlet UILabel *lblEmail;
@property (strong, nonatomic) IBOutlet UILabel *lblEmailAmbiente;
@property (strong, nonatomic) IBOutlet UILabel *lblCap;
@property (strong, nonatomic) IBOutlet UIImageView *logoImageView;

@property (nonatomic, strong) IBOutlet MKMapView *mapView;

@end

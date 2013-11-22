//
//  CassonettiViewController.m
//  IoRciclo
//
//  Created by Maria Cristina Narcisi on 15/11/13.
//  Copyright (c) 2013 Maria Cristina Narcisi. All rights reserved.
//

#import "CassonettiViewController.h"

@interface CassonettiViewController ()

@end

@implementation CassonettiViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    [self.navigationController setNavigationBarHidden:NO ];
    
    
}
- (void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    
    
    //questi metodi sono da inserire nel syncronizer
    
    self.mapView.delegate = self;
       [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    
    [self.navigationController setNavigationBarHidden:NO ];
     _mapView.showsUserLocation=TRUE;
    
    [self performSelectorInBackground:@selector(CaricaCassonetti) withObject:nil];
}

-(void)CaricaCassonetti
{
    cassonetti = [Syncronizer SyncCassonetti];
    for(Cassonetto *cassonetto in cassonetti)
    {
        
        [cassonetto setTitle : cassonetto.tipologiarifiuto ];
        cassonetto.subtitle = cassonetto.descrizione;
        CLLocationCoordinate2D location;
        location.latitude = (CLLocationDegrees)[cassonetto.latitudine doubleValue];
        location.longitude = (CLLocationDegrees)[cassonetto.longitudine doubleValue];
        
        cassonetto.coordinate = location;
        
        [_mapView addAnnotation:cassonetto];
    }
   
    
    
    MKMapPoint annotationPoint = MKMapPointForCoordinate(_mapView.userLocation.coordinate);
    MKMapRect zoomRect= MKMapRectMake(annotationPoint.x, annotationPoint.y, 0.1, 0.1);
    
    for (id <MKAnnotation> annotation in _mapView.annotations)
    {
        MKMapPoint annotationPoint = MKMapPointForCoordinate(annotation.coordinate);
        MKMapRect pointRect = MKMapRectMake(annotationPoint.x, annotationPoint.y, 0.1, 0.1);
        zoomRect = MKMapRectUnion(zoomRect, pointRect);
    }
    [_mapView setVisibleMapRect:zoomRect animated:YES];

    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;

    
}


//metodo per il disegno delle annotazioni
- (MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id <MKAnnotation>)annotation
{
    // this part is boilerplate code used to create or reuse a pin annotation
    static NSString *viewId = @"MKPinAnnotationView";
    MKPinAnnotationView *annotationView = (MKPinAnnotationView*)
    [self.mapView dequeueReusableAnnotationViewWithIdentifier:viewId];
    
    if ([annotation isKindOfClass:[Cassonetto class]])
    {
        
        //Cassonetto *cassonettoAnnotation = (Cassonetto *)annotation;
        
        if (annotationView == nil) {
            annotationView = [[[MKPinAnnotationView alloc]
                               initWithAnnotation:annotation reuseIdentifier:viewId] autorelease];
            
        }
       // NSLog(@"tipologiarifiuto %@",cassonettoAnnotation.tipologiarifiuto);
        annotationView.image = [UIImage imageNamed:@"ann_000.png"];
        // set your custom image
        /*if ([cassonettoAnnotation.codtipologiarifiuto isEqual: @"CHI"])
        {
            annotationView.image = [UIImage imageNamed:@"pittogrammachiesa.png"];
            
        }
        if ([cassonettoAnnotation.codtipologiarifiuto isEqual: @"NEG"])
        {
            annotationView.image = [UIImage imageNamed:@"pittogrammaregalo.png"];
            
        }
        if ([cassonettoAnnotation.codtipologiarifiuto isEqual: @"RIS"])
        {
            annotationView.image = [UIImage imageNamed:@"pittogrammaristorante.png"];
            
        }
         */
        
    }
    annotationView.canShowCallout = YES;
    
    // Create a UIButton object to add on the
    UIButton *rightButton = [UIButton buttonWithType:UIButtonTypeDetailDisclosure];
    [rightButton setTitle:annotation.title forState:UIControlStateNormal];
    [annotationView setRightCalloutAccessoryView:rightButton];
    
    return annotationView;
}
/*
- (void)mapView:(MKMapView *)mapView didSelectAnnotationView:(MKAnnotationView *)view{
    Cassonetto *annotation = (Cassonetto *)view;
    CalendarioViewController *CalendarioController = [[CalendarioViewController alloc] init];
    CalendarioController.IdCalendario =cassonettoAnnotation.idcalendario;
    [[self navigationController] pushViewController:CalendarioController animated:YES];
}

*/

- (void)mapView:(MKMapView *)mapView
 annotationView:(MKAnnotationView *)view calloutAccessoryControlTapped:(UIControl *)control {
    
    if ([(UIButton*)control buttonType] == UIButtonTypeDetailDisclosure){
        
        
        Cassonetto *cassonettoAnnotation = (Cassonetto *)view.annotation;
        CalendarioViewController *CalendarioController = [[CalendarioViewController alloc] init];
        CalendarioController.IdCalendario =cassonettoAnnotation.idcalendario;
        CalendarioController.Descrizione =[NSString stringWithFormat:@"Calendario Raccolta:\n%@",cassonettoAnnotation.subtitle ];
        [[self navigationController] pushViewController:CalendarioController animated:YES];
        
    }
}

- (void)mapView:(MKMapView *)mapView didAddAnnotationViews:(NSArray *)views {
    
    MKMapPoint annotationPoint = MKMapPointForCoordinate(self.mapView.userLocation.coordinate);
    MKMapRect zoomRect= MKMapRectMake(annotationPoint.x, annotationPoint.y, 0.2, 0.2);
    
    for (id <MKAnnotation> annotation in self.mapView.annotations)
    {
        MKMapPoint annotationPoint = MKMapPointForCoordinate(annotation.coordinate);
        MKMapRect pointRect = MKMapRectMake(annotationPoint.x, annotationPoint.y, 0.2, 0.2);
        zoomRect = MKMapRectUnion(zoomRect, pointRect);
    }
    [self.mapView setVisibleMapRect:zoomRect animated:YES];
    
}


/*
 - (void)mapView:(MKMapView *)mapView didUpdateUserLocation:(MKUserLocation *)userLocation
 {
 MKCoordinateRegion region = MKCoordinateRegionMakeWithDistance(userLocation.coordinate, 800, 800);
 [self.mapView setRegion:[self.mapView regionThatFits:region] animated:YES];
 MKPointAnnotation *point = [[MKPointAnnotation alloc] init];
 point.coordinate = userLocation.coordinate;
 point.title = @"Where am I?";
 point.subtitle = @"I'm here!!!";
 
 [self.mapView addAnnotation:point];
 }
 
 */
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
@end


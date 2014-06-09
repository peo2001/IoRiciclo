//
//  CassonettiViewController.m
//  IoRiciclo
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
    zoommed = false;
    [self.navigationController setNavigationBarHidden:NO ];
    self.navigationController.navigationBar.topItem.title=@"Cassonetti";

    
    
}
- (void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    
    
    //questi metodi sono da inserire nel syncronizer
    
    self.mapView.delegate = self;
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    
    [self.navigationController setNavigationBarHidden:NO ];
    // _mapView.showsUserLocation=TRUE;
    
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
    
   // MKMapPoint annotationPoint = MKMapPointForCoordinate(_mapView.userLocation.coordinate);
    MKMapRect zoomRect=MKMapRectNull; //MKMapRectMake(annotationPoint.x, annotationPoint.y, 0.1, 0.1);
    
    for (id <MKAnnotation> annotation in _mapView.annotations)
    {
        MKMapPoint annotationPoint = MKMapPointForCoordinate(annotation.coordinate);
        MKMapRect pointRect = MKMapRectMake(annotationPoint.x, annotationPoint.y, 0.1, 0.1);
        zoomRect = MKMapRectUnion(zoomRect, pointRect);
    }
    
    if (!zoommed)
    {
        [_mapView setVisibleMapRect:zoomRect animated:YES];
    }
    zoommed = true;
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;

    if ([cassonetti count]==0)
    {
       // [self showAlertNoCassonetti ];
    }
   
}

-(void)showAlertNoCassonetti
{
    if ([self.mapView.annotations count]== 0)
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"IoRiciclo"
                                                        message:@"Non sono presenti Cassonetti"
                                                       delegate:nil
                                              cancelButtonTitle:@"OK"
                                              otherButtonTitles:nil];
        
        
        [alert show];
        
    }
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
      
        annotationView.image = [UIImage imageNamed:@"ann_000.png"];
        
    }
    annotationView.canShowCallout = YES;
    
    // Create a UIButton object to add on the
    UIButton *rightButton = [UIButton buttonWithType:UIButtonTypeDetailDisclosure];
    [rightButton setTitle:annotation.title forState:UIControlStateNormal];
    [annotationView setRightCalloutAccessoryView:rightButton];
    
    return annotationView;
}


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
    /*
    if (!zoommed)
    {
         [self.mapView setVisibleMapRect:zoomRect animated:YES];
    }
    zoommed = true;
    */
    //[self showAlertNoCassonetti];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
@end


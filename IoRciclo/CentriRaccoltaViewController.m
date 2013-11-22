//
//  CentriRaccoltaViewController.m
//  IoRciclo
//
//  Created by Maria Cristina Narcisi on 15/11/13.
//  Copyright (c) 2013 Maria Cristina Narcisi. All rights reserved.
//

#import "CentriRaccoltaViewController.h"

@interface CentriRaccoltaViewController ()

@end

@implementation CentriRaccoltaViewController

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
    [self.navigationController setNavigationBarHidden:NO ];
	// Do any additional setup after loading the view.
    
    
}
- (void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;

    
    //questi metodi sono da inserire nel syncronizer
    
    self.mapView.delegate = self;
    _mapView.showsUserLocation=TRUE;
    [self performSelectorInBackground:@selector(CaricaCentriRaccolta) withObject:nil];
    /*
    centriraccolta = [Syncronizer SyncCentriRaccolta];
    for(CentriRaccolta *cracc in centriraccolta)
    {
        
        [cracc setTitle : cracc.centroraccolta ];
        cracc.subtitle = cracc.descrizione;
        CLLocationCoordinate2D location;
        location.latitude = (CLLocationDegrees)[cracc.latitudine doubleValue];
        location.longitude = (CLLocationDegrees)[cracc.longitudine doubleValue];
        
        cracc.coordinate = location;
        
        [_mapView addAnnotation:cracc];
    }
    _mapView.showsUserLocation=TRUE;
    
    
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
    */
    
}

-(void)CaricaCentriRaccolta
{
    centriraccolta = [Syncronizer SyncCentriRaccolta];
    for(CentriRaccolta *cracc in centriraccolta)
    {
        
        [cracc setTitle : cracc.centroraccolta ];
        cracc.subtitle = cracc.descrizione;
        CLLocationCoordinate2D location;
        location.latitude = (CLLocationDegrees)[cracc.latitudine doubleValue];
        location.longitude = (CLLocationDegrees)[cracc.longitudine doubleValue];
        
        cracc.coordinate = location;
        
        [_mapView addAnnotation:cracc];
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
    
    if ([annotation isKindOfClass:[CentriRaccolta class]])
    {
        
        //CentriRaccolta *craccoltaAnnotation = (CentriRaccolta *)annotation;
        
        if (annotationView == nil) {
            annotationView = [[[MKPinAnnotationView alloc]
                               initWithAnnotation:annotation reuseIdentifier:viewId] autorelease];
            
        }
      //  NSLog(@"tipologiarifiuto %@",craccoltaAnnotation.tipologiarifiuto);
        annotationView.image = [UIImage imageNamed:@"ann_000.png"];
        // set your custom image
        /* if ([cassonettoAnnotation.codtipologiarifiuto isEqual: @"CHI"])
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
        
        //  if ([view isKindOfClass:[Cassonetto class]])
        //    {
       // NSLog(@"%@",[(CentriRaccolta *)view.annotation class]);
        CentriRaccolta *craccAnnotation = (CentriRaccolta *)view.annotation;
        // if ([cassonettoAnnotation.codtipologiarifiuto isEqual: @"NEG"])
        // {
        // Do your thing when the detailDisclosureButton is touched
        CalendarioViewController *CalendarioController = [[CalendarioViewController alloc] init];
        CalendarioController.IdCalendario =craccAnnotation.idcalendario;
        CalendarioController.Descrizione =[NSString stringWithFormat:@"Centro Raccolta Raccolta:\n%@",craccAnnotation.subtitle];
        [[self navigationController] pushViewController:CalendarioController animated:YES];
        //}
        // }
        
    } /*else if([(UIButton*)control buttonType] == UIButtonTypeInfoLight) {
       // Do your thing when the infoDarkButton is touched
       
       NSLog(@"infoDarkButton for longitude: and latitude:");
       }
       */
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


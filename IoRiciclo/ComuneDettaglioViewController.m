//
//  ComuneDettaglioViewController.m
//  IoRiciclo
//
//  Created by Maria Cristina Narcisi on 24/02/14.
//  Copyright (c) 2014 Maria Cristina Narcisi. All rights reserved.
//

#import "ComuneDettaglioViewController.h"

@interface ComuneDettaglioViewController ()

@end

@implementation ComuneDettaglioViewController

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
    self.navigationController.navigationBar.topItem.title = @"Info Comune";
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    self.navigationController.navigationBar.backgroundColor=[UIColor redColor];
    
    // [_logoImageView removeFromSuperview];
    //il sync delle province non ritorna nessun array perchè la Ricerca viene effettuata dopo per poter utilizzare il fetcher (il parsing del sincro torna una array e quindi non andrebbe bene)
    
    [self performSelectorInBackground:@selector(CaricaComune) withObject:nil];
}

-(void)CaricaComune
{
    [Syncronizer SyncComune];
    //NSLog(@"%d",[[Comuni RC_Comune:[MyApplicationSingleton getIdComune]] count]);
    comune = [[Comuni RC_Comune:[MyApplicationSingleton getIdComune]] objectAtIndex:0];
    
    _lblComune.text=[NSString stringWithFormat: @"%@ (%@)",comune.comune,[NSString stringWithFormat:@"%@",comune.provincia] ];
    _lblNumAbitanti.text =[NSString stringWithFormat: @"Numero Abtitanti: %@",[NSString stringWithFormat:@"%@",comune.numeroAbitanti] ];
    _lblCap.text=[NSString stringWithFormat: @"Cap: %@",[NSString stringWithFormat:@"%@",comune.cap] ];
    _lblUrl.text =[NSString stringWithFormat: @"Sito: %@",[NSString stringWithFormat:@"%@",comune.url] ];
    _lblEmail.text=[NSString stringWithFormat: @"Email: %@",[NSString stringWithFormat:@"%@",comune.email] ];
    _lblEmailAmbiente.text=[NSString stringWithFormat: @"Email Ambiente: %@",[NSString stringWithFormat:@"%@",comune.emailAmbiente] ];
    
    _mapView.delegate= self;
    
    if (!((comune.longitudine ==0) || (comune.longitudine  == nil)))
    {
        [_mapView addAnnotation:comune];
    }
    
    MKMapRect zoomRect= MKMapRectNull;
    
    for (id <MKAnnotation> annotation in _mapView.annotations)
    {
        MKMapPoint annotationPoint = MKMapPointForCoordinate(annotation.coordinate);
        MKMapRect pointRect = MKMapRectMake(annotationPoint.x, annotationPoint.y, 0.1, 0.1);
        zoomRect = MKMapRectUnion(zoomRect, pointRect);
    }

    [_mapView setVisibleMapRect:zoomRect animated:YES];
    
    if ([comune.logo isEqual:@""])
    {
       
       _logoImageView.hidden=true;
      
        
    }else
    {
        
        //immagine
        dispatch_queue_t queue;

        queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0ul);
        dispatch_async(queue, ^{
            NSURL *imageUrl = [NSURL URLWithString:comune.logo];
            NSData *imageData = [NSData dataWithContentsOfURL:imageUrl];
            UIImage *image = [UIImage imageWithData:imageData ];
             UIImage *buttonBk=[self scaleImage:image toSize:CGSizeMake(120.0,120.0)];
            dispatch_async(dispatch_get_main_queue(), ^{
                [_logoImageView setImage:buttonBk];
            });
        });
      
      
    }
    
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
   
}

-(UIImage *)scaleImage:(UIImage *)image toSize:(CGSize)newSize {
    
    float width = newSize.width;
    float height = newSize.height;
    
    UIGraphicsBeginImageContext(newSize);
    CGRect rect = CGRectMake(0, 0, width, height);
    
    float widthRatio = image.size.width / width;
    float heightRatio = image.size.height / height;
    float divisor = widthRatio > heightRatio ? widthRatio : heightRatio;
    
    width = image.size.width / divisor;
    height = image.size.height / divisor;
    
    rect.size.width  = width;
    rect.size.height = height;
    
    if(height < width)
        rect.origin.y = height / 3;
    [image drawInRect: rect];
    
    UIImage *smallImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return smallImage;
    
}

//metodo per il disegno delle annotazioni
- (MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id <MKAnnotation>)annotation
{
    
    // this part is boilerplate code used to create or reuse a pin annotation
    static NSString *viewId = @"MKPinAnnotationView";
    MKPinAnnotationView *annotationView = (MKPinAnnotationView*)
    [self.mapView dequeueReusableAnnotationViewWithIdentifier:viewId];
    
   
        
    if (annotationView == nil) {
        annotationView = [[[MKPinAnnotationView alloc]
                               initWithAnnotation:annotation reuseIdentifier:viewId] autorelease];
    
    }
    annotationView.image = [UIImage imageNamed:@"markercomune.png"];
   
    return annotationView;
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

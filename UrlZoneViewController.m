//
//  UrlZoneViewController.m
//  IoRiciclo
//
//  Created by Maria Cristina Narcisi on 26/02/14.
//  Copyright (c) 2014 Maria Cristina Narcisi. All rights reserved.
//

#import "UrlZoneViewController.h"



@interface UrlZoneViewController ()

@end

@implementation UrlZoneViewController



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
    [self.navigationController setNavigationBarHidden:YES ];
   
    _spinner = [[UIActivityIndicatorView alloc]
                                        initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    _spinner.center = CGPointMake(160, 240);
    _spinner.hidesWhenStopped = YES;
    [self.view addSubview:_spinner];
    
    [_spinner startAnimating];
    [_spinner release];
    
    [_spinner startAnimating];
    
    UIDevice *myDevice = [UIDevice currentDevice];
    NSString * deviceUDID = [[myDevice identifierForVendor]UUIDString];

    [_btnChiudi addTarget:self action:@selector(chiudi) forControlEvents:UIControlEventTouchUpInside];
    
    
    NSURL *fullURL = [NSURL URLWithString:[NSString stringWithFormat:@"%@%@?AppId=%@&DeviceType=IOS",@"",@"http://www.iriciclo.it/PagineComuni/Palermo/Default.asp" ,deviceUDID]] ;
    
    NSLog(@"%@",fullURL);
    [_webView setDelegate:self];
    NSURLRequest *requestObj = [NSURLRequest requestWithURL:fullURL];
    [_webView loadRequest:requestObj];
}

-(void)chiudi
{
    [Syncronizer SyncUtente];
    //NSLog(@"%lu",(unsigned long)[[Utenti RC_] count]);
   
    
    if ([[Utenti RC_] count]!=0)
    {
         Utenti *utente = [[Utenti RC_] objectAtIndex:0];
          //salva nel registro del telefono le informazioni della zona e del comune che servono per individuare i giorni di riciclo
        [[NSUserDefaults standardUserDefaults] setValue:utente.idcomune forKey:@"IdComune"];
    //  NSLog(@"Zona Id %@",[[zone objectAtIndex:buttonIndex]idzona]);
        [[NSUserDefaults standardUserDefaults] setValue:utente.idzona forKey:@"IdZona"];
    
        [[NSUserDefaults standardUserDefaults] synchronize];
    //recuper le informazioni del comune e della zona dal registro del telefono e li salva nelle variabili globali dell'applicazione
        NSNumber *IdComune = [[NSUserDefaults standardUserDefaults] valueForKey:@"IdComune"];
        NSNumber *IdZona = [[NSUserDefaults standardUserDefaults] valueForKey:@"IdZona"];
    
    
        [MyApplicationSingleton setIdComune:IdComune];
        [MyApplicationSingleton setIdZona:IdZona];
    }
   
    
    [self performSegueWithIdentifier: @"goToRiciclo" sender: nil];

    
}


- (void)webViewDidFinishLoad:(UIWebView *)webView {
  //  if ([[webView stringByEvaluatingJavaScriptFromString:@"document.readyState"] isEqualToString:@"complete"]) {
        // UIWebView object has fully loaded.
        [_spinner stopAnimating];
   // }
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

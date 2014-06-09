//
//  ViewController.m
//  IoRiciclo
//
//  Created by Maria Cristina Narcisi on 07/07/13.
//  Copyright (c) 2013 Maria Cristina Narcisi. All rights reserved.
//

#import "RicicloViewController.h"

@interface RicicloViewController ()

@end

@implementation RicicloViewController

@synthesize lblData = _lblData;
@synthesize lblTipoRiciclo = _lblTipoRiciclo;
@synthesize imageView = _imageView;
@synthesize lblSocialLogin = _lblSocialLogin;
//@synthesize adBannerView;
@synthesize contentView;


-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self.navigationController setNavigationBarHidden:YES ];
    self.imageViewBackground.layer.cornerRadius = 5;
    
    CGRect screenBound = [[UIScreen mainScreen] bounds];
    CGSize screenSize = screenBound.size;
    CGFloat screenWidth = screenSize.width;
    CGFloat screenHeight = screenSize.height;
    
    CGRect frame = CGRectMake(0, 0, screenWidth, screenHeight);
    
    
    self.imageViewBackground.frame = frame;
    [self.imageViewBackground sizeToFit];
    
    //imposta la variabile che indica se la view della notifica è disegnata
    alarmViewReady = false;
    
    currentDate = [self dateAdd :[NSDate date]:1];
   
    [self createToolbar];
    
    
    self.lblData.text = [NSString stringWithFormat:@"%@ ",[self normalizedDateWithDate:currentDate ] ];
    self.imageView.image = nil;
    
    self.lblTipoRiciclo.text = [NSString stringWithFormat:@"Nessun Riciclo"];
    
    //se sono stati impostati comune e zona disegna la view di giorni riciclo
    if ([MyApplicationSingleton getIdComune]!=0  && [MyApplicationSingleton getIdZona]!=0)
    {
        [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
        [self performSelectorInBackground:@selector(refreshView:) withObject:currentDate];
        self.btnCassonetti.enabled = TRUE;
        self.btnCentriRaccolta.enabled = TRUE;
        self.btnAvvisi.enabled=TRUE;
        
    }
    else
    {
        self.btnCassonetti.enabled = FALSE;
        self.btnCentriRaccolta.enabled = FALSE;
        self.btnAvvisi.enabled=FALSE;
        UIAlertView *message = [[UIAlertView alloc] initWithTitle:@"IoRiciclo"
                                                          message:@"Attenzione non Hai Ancora Selezionato un Comune"
                                                         delegate:self
                                                cancelButtonTitle:@"Seleziona Comune"
                                                otherButtonTitles:nil];
        
        
        
        [message show];
        
        
    }
    self.tvDomani.delegate= self;
    self.tvDopoDomani.delegate= self;
    self.tv3Giorni.delegate= self;
    
   
    //fb login
    
    if ([[[MyApplicationSingleton sharedInstance] utente] IsUserLogged])
    {
        _lblSocialLogin.text =[NSString stringWithFormat:@"Benvenuto %@" ,[[NSUserDefaults standardUserDefaults] valueForKey:@"nameFB"]];
    }
    else{
         _lblSocialLogin.text = [NSString stringWithFormat:@"Entra Nella Comunity" ];
    }
    
    [_lblSocialLogin setUserInteractionEnabled:YES];
    
    
    UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(doSocialLogin)];
    [tapGestureRecognizer setNumberOfTapsRequired:1];
    [_lblSocialLogin addGestureRecognizer:tapGestureRecognizer];
    [tapGestureRecognizer release];
    //fb login
    
    
    //iad
    // [self createAdBannerView];
    //[self.view addSubview:self.adBannerView];
    //fine iad
    
}

-(void)doSocialLogin
{
    [self performSegueWithIdentifier: @"doSocialLogin" sender: self];
}

- (void)alertView:(UIAlertView *)theAlert clickedButtonAtIndex:(NSInteger)buttonIndex
{
    [self performSegueWithIdentifier: @"goToProvince" sender: self];
    
}

//compone e disegna la toolbar
- (void)createToolbar {
    
    
    
    NSString * stringTitle = [NSString stringWithFormat:@"Seleziona Comune"];
    
    
    if ([MyApplicationSingleton getIdComune]!=0  && [MyApplicationSingleton getIdZona]!=0)
    {
        [Syncronizer SyncComune];
        NSArray * arrComune = [Comuni RC_Comune:[MyApplicationSingleton getIdComune]];
        NSArray * arrZona = [Zone RC_:[MyApplicationSingleton getIdZona]];
        if (([arrComune count]>0) && ([arrZona count] >0))
        {
            comune =[arrComune objectAtIndex:0];
            //titolo con città
             stringTitle = [NSString stringWithFormat:@"%@ ",[[arrComune objectAtIndex:0] comune]];
            
            //se il comune è gestito dal comune stesso si va in una view dedicata
            if ([[comune gestByComune]  isEqual:@"S"])
            {
                
                [ _btnInfo setImage:[UIImage imageNamed:@"lampadinagreen.png" ] forState:UIControlStateNormal];
                /*[[_btnInfo layer] setBorderWidth:1.0f];
                [[_btnInfo layer] setBorderColor:[UIColor grayColor].CGColor];
                */
                [_btnInfo addTarget:self action:@selector(infoComune) forControlEvents:UIControlEventTouchUpInside];
                
            }
            else{
                [_btnInfo setImage:[UIImage imageNamed:@"lampadinaazzurro.png" ] forState:UIControlStateNormal];
                
                [_btnInfo addTarget:self action:@selector(infoPrivato) forControlEvents:UIControlEventTouchUpInside];
                //info.tintColor= [UIColor yellowColor];
                
            }
            
        }
    }
    
    UIBarButtonItem *comuneButton = [[UIBarButtonItem alloc] initWithTitle:stringTitle style:
                               UIBarButtonItemStylePlain target:self action:@selector(pickProvincia)];
    
    [comuneButton setTintColor:[UIColor whiteColor]];
    
    
    
    if ([[[NSUserDefaults standardUserDefaults] valueForKey:@"AlarmSet"] isEqualToString:@"S" ])
    {
        
        alarm = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"ic_iconon.png" ] style:UIBarButtonItemStyleBordered  target:self action:@selector(pickAlarm)];
        [alarm setTintColor:[UIColor whiteColor]];
        
    }else
    {
        
        alarm = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"ic_iconoff.png" ] style:UIBarButtonItemStyleBordered  target:self action:@selector(pickAlarm)];
        [alarm setTintColor:[UIColor whiteColor]];
    }
    
    
    
    UIBarButtonItem *flexibleSpace = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
    
    NSArray *buttonItems = [NSArray arrayWithObjects: comuneButton,flexibleSpace,flexibleSpace,alarm, nil];
    
    [_toolBar setItems:buttonItems];
    
}

//aggiunge giorni alla data
-(NSDate *)dateAdd:(NSDate*)data :(uint)daysToAdd
{
    // set up date components
    NSDateComponents *components = [[[NSDateComponents alloc] init] autorelease];
    [components setDay:daysToAdd];
    
    // create a calendar
    NSCalendar *gregorian = [[[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar] autorelease];
    
    //fine dateadd
    
    return [gregorian dateByAddingComponents:components toDate:data options:0];;
}

//disegna la parte di presentazione dei giorni di riciclo

-(void)refreshView:(NSDate *)data
{
    
    //FB
    if ([[[MyApplicationSingleton sharedInstance] utente] IsUserLogged])
    {
        _lblSocialLogin.text =[NSString stringWithFormat:@"Benvenuto %@" ,[[NSUserDefaults standardUserDefaults] valueForKey:@"nameFB"]];
    }
    else{
        _lblSocialLogin.text =[NSString stringWithFormat:@"Entra Nella Comunity"];
       
    }
    //fine FB
    
    NSDate *myDate = data;
    NSDateFormatter *df = [NSDateFormatter new];
    [df setDateFormat:@"EEEE dd"];
    NSLocale *frLocale = [[NSLocale alloc] initWithLocaleIdentifier:@"it_IT"];
    [df setLocale:frLocale];
    
    
    currentDate = [DateHelper DateTimeZone:[NSDate date]];
    //NSLog (@"curr date %@", currentDate);
    self.lblData.text =[NSString stringWithFormat:@"%@", [df stringFromDate:currentDate].uppercaseString ];
    
    //NSLog (@"curr date %@",[df stringFromDate:myDate].uppercaseString);
    
    //[self createToolbar];
    
    self.imageView.image = nil;
    self.lblTipoRiciclo.text = [NSString stringWithFormat:@"Nessun Riciclo"];
    self.lblDomani.text = [NSString stringWithFormat:@""];
    self.lblDopodomani.text = [NSString stringWithFormat:@""];
    self.lblTreGiorni.text = [NSString stringWithFormat:@"" ];
    self.tvDomani.hidden = TRUE;
    self.tvDopoDomani.hidden = TRUE;
    self.tv3Giorni.hidden = TRUE;
    self.tvOggi.hidden = TRUE;
    
    
  
    //sinocronizzazione da remoto
    GiorniRiciclaggio = [Syncronizer SyncGiorniRiciclo : currentDate];
    
   
    GiorniRiciclaggio = [GiorniRiciclo RC_: [MyApplicationSingleton getIdComune]:[MyApplicationSingleton getIdZona] : currentDate : [DateHelper dataFineGiorno:currentDate ]];
    
    //caso in cui è scaduto l'orario per il giorno odierno
    if ([GiorniRiciclaggio count] == 0 )
        currentDate =[self dateAdd : currentDate:1];    //oggi
    //recupero i tipi di riciclo dal db interno per il giorno di oggi
    
    //NB:al massimo recupero due tipi di riciclo per giorno
    GiorniRiciclaggio = [GiorniRiciclo RC_: [MyApplicationSingleton getIdComune]:[MyApplicationSingleton getIdZona] :[DateHelper dataInizioGiorno:currentDate ] :[DateHelper dataFineGiorno:currentDate ]];
    
    dataoraMin = NULL;
    dataoraMax = NULL;
    
    bool primo = true;
    
    //recupero l'orario minimo e massimo del giro del riciclo
    for (GiorniRiciclo *currGiorno in GiorniRiciclaggio)
    {
       // NSLog(@"dataorainizio %@ dataora fine %@ ", currGiorno.datagiorno,currGiorno.datagiornofine);
        if (primo)
        {
            dataoraMin = currGiorno.datagiorno;
            dataoraMax = currGiorno.datagiornofine;
           // NSLog(@"dataorainizio %@ dataora fine %@ ", dataoraMin,dataoraMax);
           
            primo = false;
        }
        
        if ([dataoraMin compare:currGiorno.datagiorno] == NSOrderedDescending)
        {
            dataoraMin = currGiorno.datagiorno;
        }
        if ([dataoraMin compare:currGiorno.datagiorno] == NSOrderedAscending )
        {
            dataoraMax = currGiorno.datagiornofine;
        }
       
        
    }
    
    //NSLog(@"dataoraMin %@ DataMax %@",dataoraMin, dataoraMax);
    
    NSDateFormatter *dfa = [NSDateFormatter new];
    [dfa setTimeZone:[NSTimeZone timeZoneWithAbbreviation:@"GMT"]];
    [dfa setDateFormat:@"HH:mm"];
    // NSLog(@"dataoraMin %@",[dfa stringFromDate:dataoraMin]);
   
    NSString * oraDaMostrare =@"";
    
    if ([dataoraMax timeIntervalSinceDate:dataoraMin]  > 0 )
    {
        oraDaMostrare =[NSString stringWithFormat:@"%@-%@",[dfa stringFromDate:dataoraMin],[dfa stringFromDate:dataoraMax]];
    }
    else
    {
        oraDaMostrare =[NSString stringWithFormat:@"%@",[dfa stringFromDate:dataoraMax]];
    }
    
   
    
    [dfa release];
    

    //NB:al massimo recupero due tipi di riciclo per giorno
    GiorniRiciclaggio = [GiorniRiciclo RC_: [MyApplicationSingleton getIdComune]:[MyApplicationSingleton getIdZona] :[DateHelper dataInizioGiorno:currentDate ] :[DateHelper dataFineGiorno:dataoraMax ]];
        
    if ([GiorniRiciclaggio count] > 2)
    {
        self.lblTipoRiciclo.text = [NSString stringWithFormat:@""];
        self.lblData.text =[NSString stringWithFormat:@"%@ (%@)", [df stringFromDate:currentDate].uppercaseString ,oraDaMostrare];
        
        
        self.tvOggi.hidden = FALSE;
    }
    else{
        
        if ([GiorniRiciclaggio count] > 0 )
        {
            self.lblData.text =[NSString stringWithFormat:@"%@ (%@)", [df stringFromDate:currentDate].uppercaseString ,oraDaMostrare];
            
            self.lblTipoRiciclo.text = [NSString stringWithFormat:@"%@",[[GiorniRiciclaggio objectAtIndex:0]tiporiciclo]];
            [self setImmagineInButton:0:_btnOggi : [GiorniRiciclaggio objectAtIndex:0]];
        }
        
        if ([GiorniRiciclaggio count] > 1 )
        {
           // self.lblData.text =[NSString stringWithFormat:@"%@ (%@)", [df stringFromDate:currentDate].uppercaseString ,oraDaMostrare];
            
            self.lblTipoRiciclo.text = [NSString stringWithFormat:@"%@ e %@",self.lblTipoRiciclo.text,[[GiorniRiciclaggio objectAtIndex:1]tiporiciclo]];
            [self setImmagineInButton:1  :_btnOggi2 : [GiorniRiciclaggio objectAtIndex:1]];
            
        }
    }
    
    //domani
    GiorniRiciclaggioDomani = [GiorniRiciclo RC_: [MyApplicationSingleton getIdComune]:[MyApplicationSingleton getIdZona] :[DateHelper dataInizioGiorno:[self dateAdd : currentDate:1] ] :[DateHelper dataFineGiorno:[self dateAdd : currentDate:1] ]];
    
    myDate = [self dateAdd : currentDate:1];
    
    self.lblDomani.text =[df stringFromDate:myDate].uppercaseString;
    
    //verifico che nel giorno di domani ci siano più di due elementi
    if ([GiorniRiciclaggioDomani count] > 2 )
    {
        self.tvDomani.hidden = FALSE;
    }
    else{
        
        
        if ([GiorniRiciclaggioDomani count] > 0 )
        {
            self.lblTipoRicicloDomani.text = [NSString stringWithFormat:@"%@",[[GiorniRiciclaggioDomani objectAtIndex:0]tiporiciclo]];
            [self setImmagineInButton:0 :_btnDomani : [GiorniRiciclaggioDomani objectAtIndex:0]];
        }
        if ([GiorniRiciclaggioDomani count] > 1 )
        {
            self.lblTipoRicicloDomani.text = [NSString stringWithFormat:@"%@-%@",self.lblTipoRicicloDomani.text,[[GiorniRiciclaggioDomani objectAtIndex:1]tiporiciclo]];
            
            [self setImmagineInButton:1  :_btnDomani2 : [GiorniRiciclaggioDomani objectAtIndex:1]];
            
        }
    }
    
    //dopodomani
    GiorniRiciclaggioDopodomani = [GiorniRiciclo RC_: [MyApplicationSingleton getIdComune]:[MyApplicationSingleton getIdZona] :[DateHelper dataInizioGiorno:[self dateAdd : currentDate:2] ] :[DateHelper dataFineGiorno:[self dateAdd : currentDate:2] ]];
    
    // NSLog(@"data dopodomani : %@",[self dateAdd : [NSDate date]:3]);
    myDate = [self dateAdd : currentDate:2];
    
    self.lblDopodomani.text =[df stringFromDate:myDate].uppercaseString;
    
    //verifico che nel giorno di domani ci siano più di due elementi
    if ([GiorniRiciclaggioDopodomani count] > 2 )
    {
        self.tvDopoDomani.hidden = FALSE;
    }
    else{
        
        if ([GiorniRiciclaggioDopodomani count] > 0 )
        {
            self.lblTipoRicicloDopodomani.text = [NSString stringWithFormat:@"%@",[[GiorniRiciclaggioDopodomani objectAtIndex:0]tiporiciclo]];
            [self setImmagineInButton:0  :_btnDopodomani : [GiorniRiciclaggioDopodomani objectAtIndex:0]];
        }
        
        if ([GiorniRiciclaggioDopodomani count] > 1 )
        {
            self.lblTipoRicicloDopodomani.text = [NSString stringWithFormat:@"%@-%@",self.lblTipoRicicloDopodomani.text,[[GiorniRiciclaggioDopodomani objectAtIndex:1]tiporiciclo]];
            [self setImmagineInButton:1  :_btnDopodomani2 : [GiorniRiciclaggioDopodomani objectAtIndex:1]];
            
        }
    }
    //tregiorni
    
    GiorniRiciclaggio3Giorni = [GiorniRiciclo RC_: [MyApplicationSingleton getIdComune]:[MyApplicationSingleton getIdZona] :[DateHelper dataInizioGiorno:[self dateAdd : currentDate:3] ] :[DateHelper dataFineGiorno:[self dateAdd : currentDate:3] ]];
    
    
    myDate = [self dateAdd : currentDate:3];
    
    self.lblTreGiorni.text =[df stringFromDate:myDate].uppercaseString;
    
    if ([GiorniRiciclaggio3Giorni count] > 2 )
    {
        self.tv3Giorni.hidden = FALSE;
    }
    else{
        
        if ([GiorniRiciclaggio3Giorni count] > 0 )
        {
            self.lblTipoRicicloTreGiorni.text = [NSString stringWithFormat:@"%@",[[GiorniRiciclaggio3Giorni objectAtIndex:0]tiporiciclo]];
            [self setImmagineInButton:0  :_btnTreGiorni : [GiorniRiciclaggio3Giorni objectAtIndex:0]];
        }
        
        
        if ([GiorniRiciclaggio3Giorni count] > 1 )
        {
            self.lblTipoRicicloTreGiorni.text = [NSString stringWithFormat:@"%@-%@",self.lblTipoRicicloTreGiorni.text,[[GiorniRiciclaggio3Giorni objectAtIndex:1]tiporiciclo]];
            
            [self setImmagineInButton:1 :_btnTreGiorni2 : [GiorniRiciclaggio3Giorni objectAtIndex:1]];
        }
    }
    
    [self.tvOggi reloadData];
    [self.tvDomani reloadData];
    [self.tvDopoDomani reloadData];
    [self.tv3Giorni reloadData];
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
    
}


-(void)setImmagineInButton:(uint )NumGiorno :(UIButton *)Button : (GiorniRiciclo *)GiornoRiciclo
{
    NSString *uirimg;
    dispatch_queue_t queue;
    uirimg =[GiornoRiciclo immagine];
    //NSLog(@"immaginepercomune %@",[[GiorniRiciclaggio objectAtIndex:NumGiorno]immaginepercomune]);
    
    if (![[GiornoRiciclo immaginepercomune]isEqual:@""])
    {
        uirimg =[GiornoRiciclo immaginepercomune];
    }
    //NSLog(@"imgUrl: %@",uirimg);
    //immagine
    queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0ul);
    dispatch_async(queue, ^{
        NSURL *imageUrl = [NSURL URLWithString:uirimg];
        NSData *imageData = [NSData dataWithContentsOfURL:imageUrl];
        UIImage *image = [UIImage imageWithData:imageData  scale:[UIScreen mainScreen].scale];
        dispatch_async(dispatch_get_main_queue(), ^{
            [Button setBackgroundImage:image forState:UIControlStateNormal];
        });
    });
    
    Button.tag = NumGiorno;
    
    NSString *Descrizione = [NSString stringWithFormat:@"%@",[GiornoRiciclo descrizionepercomune]];
    
    
    if ([Descrizione isEqualToString:@""])
    {
        Descrizione = [NSString stringWithFormat:@"%@",[GiornoRiciclo descrizione]];
        
    }
    Descrizione = [NSString stringWithFormat:@"%@ :\n %@",[GiornoRiciclo tiporiciclo],Descrizione ];
    
    Button.titleLabel.text= Descrizione;
    [Button addTarget:self
               action:@selector(showDescription:)
     forControlEvents:UIControlEventTouchDown];
}


-(void) showDescription:(UIButton *) sender{
    
    UIButton *buttonClicked = (UIButton *)sender;
    
    UIAlertView *message = [[UIAlertView alloc] initWithTitle:@"IoRiciclo"
                                                      message:buttonClicked.titleLabel.text
                                                     delegate:nil
                                            cancelButtonTitle:@"OK"
                                            otherButtonTitles:nil];
    [message show];
}

-(NSString*)normalizedDateWithDate:(NSDate*)date
{
    NSDate *today = date;
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setDateFormat:@"dd MMMM yyyy"];
    NSString *dateString = [dateFormat stringFromDate:today];
    return dateString;
    [dateFormat release];
}



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)infoComune
{
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    [self performSegueWithIdentifier: @"goToDettaglioComune" sender: self];
    
}
-(void)infoPrivato
{
    NSString * nomeGestore = @"";
    NSString * urlGestore = @"";
    NSString * messaggio = @"";
    
    if ((comune.nomeGestore!=nil)&&(![comune.nomeGestore isEqual:@""]))
    {
        nomeGestore = [NSString stringWithFormat:@"Nome : %@",comune.nomeGestore];
    }
    if ((comune.urlGestore!=nil)&&(![comune.urlGestore isEqual:@""]))
    {
        urlGestore = [NSString stringWithFormat:@"Url : %@",comune.urlGestore];
    }
    
    if ([nomeGestore isEqual:@""] && [urlGestore isEqual:@""])
    {
        messaggio = @"L'utente non desidera mostrare i suoi dati personali";
    }
    else
    {
        messaggio = [NSString stringWithFormat:@"%@ \n %@",nomeGestore,urlGestore];
    }
    
    UIAlertView *message = [[UIAlertView alloc] initWithTitle:@"Utente Privato"
                                                      message:messaggio
                                                     delegate:nil
                                            cancelButtonTitle:@"OK"
                                            otherButtonTitles:nil];
    
    [message show];}

//azione che porta alla scelta delle province
-(void)pickProvincia
{
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    //[self performSegueWithIdentifier: @"goToProvince" sender: self];
    [self performSegueWithIdentifier: @"goToComuni2" sender: self];

}


//SEZIONE NOTIFICHE
-(void)selData
{
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    [self performSegueWithIdentifier: @"pickData" sender: self];
}

//disegna la view dell'impostazione della notifca di riciclo

-(void)pickAlarm
{
    if (!alarmViewReady)
    {
        alarmViewReady = true;
        int height = 255;
        newDatePickerView = [[UIView alloc] initWithFrame:CGRectMake(0, 430, 320, 275)];
        //create new view
        newDatePickerView.backgroundColor = [UIColor whiteColor]; //[UIColor colorWithWhite:1 alpha:1];
        
        //add date picker
        datePicker = [[UIDatePicker alloc] init];
        datePicker.backgroundColor =[UIColor whiteColor];// [UIColor colorWithRed:50.0f/255.0f green:150.0f/255.0f blue:70.0f/255.0f alpha:1.0f];
        
        datePicker.datePickerMode = UIDatePickerModeTime;//UIDatePickerModeDateAndTime;
        datePicker.hidden = NO;
        
        
        NSCalendar *calendar = [NSCalendar currentCalendar];
        
        //gather date components from date
        NSDateComponents *dateComponents = [calendar components:(NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit) fromDate:[NSDate date]];
        
        //set date components
        
        //  NSLog(@"ora %d",[MyApplicationSingleton getOraNotifica]);
        // NSLog(@"minuti %d",[MyApplicationSingleton getMinutiNotifica]);
        [dateComponents setHour:[MyApplicationSingleton getOraNotifica]];
        [dateComponents setMinute:[MyApplicationSingleton getMinutiNotifica]];
        [dateComponents setSecond:0];
        datePicker.date = [calendar dateFromComponents:dateComponents];
        datePicker.frame = CGRectMake(0, 30, 320, 250);
        [datePicker addTarget:self action:nil forControlEvents:UIControlEventValueChanged];
        
        datePicker.timeZone = [NSTimeZone systemTimeZone];
        
        
        //add toolbar
        UIToolbar * toolbar = [[UIToolbar alloc] initWithFrame: CGRectMake(0, datePicker.frame.size.height +5, 320, 35)];
        
        toolbar.backgroundColor = [UIColor blackColor];//[UIColor colorWithRed:50.0f/255.0f green:170.0f/255.0f blue:40.0f/255.0f alpha:0.5f];
        toolbar.tintColor= [UIColor grayColor];//[UIColor colorWithRed:50.0f/255.0f green:170.0f/255.0f blue:40.0f/255.0f alpha:0.5f];
        
        
        //add button
        UIBarButtonItem *infoButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Imposta Notifica" style:UIBarButtonItemStyleDone target:self action:@selector(setAlarm)];
        
        infoButtonItem.width=100;
        [infoButtonItem setTitleTextAttributes:@{
                                                 UITextAttributeFont: [UIFont fontWithName:@"Helvetica-Bold" size:12.0]
                                                 } forState:UIControlStateNormal];
        
        toolbar.items = [NSArray arrayWithObjects:infoButtonItem, nil];
        
        //add button
        UIBarButtonItem *cancelButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Cancella Notifica" style:UIBarButtonItemStyleDone target:self action:@selector(clearNotification)];
        cancelButtonItem.width=100;
        
        [cancelButtonItem setTitleTextAttributes:@{
                                                   UITextAttributeFont: [UIFont fontWithName:@"Helvetica-Bold" size:12.0]
                                                   } forState:UIControlStateNormal];
        
        
        UIBarButtonItem *annullaButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Chiudi" style:UIBarButtonItemStyleDone target:self action:@selector(annullaNotification)];
        
        [annullaButtonItem setTitleTextAttributes:@{
                                                    UITextAttributeFont: [UIFont fontWithName:@"Helvetica-Bold" size:12.0]
                                                    } forState:UIControlStateNormal];
        
        
        annullaButtonItem.width=100;
        
        
        
        toolbar.items = [NSArray arrayWithObjects:infoButtonItem,cancelButtonItem,annullaButtonItem, nil];
        
        
        
        //label title
        UILabel * lblTitle =  [[UILabel alloc] initWithFrame: CGRectMake(0, 0, 320, 40)];
        
        lblTitle.backgroundColor = [UIColor blackColor];//[UIColor colorWithRed:50.0f/255.0f green:150.0f/255.0f blue:40.0f/255.0f alpha:1.0f];
        
        
        lblTitle.text = @"Notifica Riciclo";
        lblTitle.textColor = [UIColor whiteColor];
        lblTitle.textAlignment= NSTextAlignmentCenter;
        lblTitle.layer.borderColor = [UIColor whiteColor].CGColor;
        lblTitle.layer.borderWidth = 3.0;
        
        //fine label title
        
        [newDatePickerView addSubview:lblTitle];
        [newDatePickerView addSubview:datePicker];
        
        //add popup view
        [newDatePickerView addSubview:toolbar];
        [self.view addSubview:newDatePickerView];
        
        //animate it onto the screen
        CGRect temp = newDatePickerView.frame;
        temp.origin.y = CGRectGetMaxY(self.view.bounds);
        newDatePickerView.backgroundColor = [UIColor clearColor];
        newDatePickerView.frame = temp;
        [UIView beginAnimations:nil context:nil];
        temp.origin.y -= height;
        newDatePickerView.frame = temp;
        [UIView commitAnimations];
    }
    
    
    
}


-(NSDate *)DateTimeFromCalendar: (NSDate *)Data : (NSDate *)Time
{
    //calendar
    
    NSCalendar *calendar = [NSCalendar currentCalendar]; // gets default calendar
    NSDateComponents *components = [calendar components:(NSYearCalendarUnit | NSMonthCalendarUnit |  NSDayCalendarUnit | NSHourCalendarUnit | NSMinuteCalendarUnit) fromDate:Data]; // gets the year, month, day,hour and minutesfor today's date
    
    NSDateComponents *componentsHour = [calendar components:(NSYearCalendarUnit | NSMonthCalendarUnit |  NSDayCalendarUnit | NSHourCalendarUnit | NSMinuteCalendarUnit) fromDate:Time];
    [componentsHour setTimeZone:[NSTimeZone systemTimeZone]];
    
    
    [components setHour:[componentsHour hour]];
    [components setMinute:[componentsHour minute]];
    
    return [calendar dateFromComponents:components];
    
    //fine calendar
    
}

//chiama la creazione della notifca e rimuove la view di impostazione notifica
-(void)setAlarm
{
    /* NSString * tiporiciclo;
     
     NSDate *currDate = [NSDate date];
     
     
     tiporiciclo =  [[[GiorniRiciclo RC_: [MyApplicationSingleton getIdComune]:[MyApplicationSingleton getIdZona] :[DateHelper dataInizioGiorno:currDate ] :[DateHelper dataFineGiorno:currDate ]]objectAtIndex:0]tiporiciclo];
     
     
     [self createnotification: tiporiciclo :[self DateTimeFromCalendar:currDate : [datePicker date]]];
     
     currDate = [self dateAdd : currDate:1];
     
     
     tiporiciclo =  [[[GiorniRiciclo RC_: [MyApplicationSingleton getIdComune]:[MyApplicationSingleton getIdZona] :[DateHelper dataInizioGiorno:currDate ] :[DateHelper dataFineGiorno:currDate ]]objectAtIndex:0]tiporiciclo];
     
     [self createnotification: tiporiciclo :[self DateTimeFromCalendar:currDate : [datePicker date]]];
     
     
     currDate = [self dateAdd : currDate:2];
     
     tiporiciclo =  [[[GiorniRiciclo RC_: [MyApplicationSingleton getIdComune]:[MyApplicationSingleton getIdZona] :[DateHelper dataInizioGiorno:currDate ] :[DateHelper dataFineGiorno:currDate ]]objectAtIndex:0]tiporiciclo];
     
     [self createnotification: tiporiciclo :[self DateTimeFromCalendar:currDate : [datePicker date]]];
     
     
     */
    NSCalendar *calendar = [NSCalendar currentCalendar];
    
    NSDateComponents *dateComponents = [calendar components:(NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit| NSHourCalendarUnit | NSMinuteCalendarUnit) fromDate:[datePicker date]];
    
    [MyApplicationSingleton setOraNotifica:[dateComponents hour]];
    [MyApplicationSingleton setMinutiNotifica:[dateComponents minute]];
    [dateComponents setMinute:[dateComponents minute]];
    [dateComponents setSecond:0];
    
    
    //salva nel registro del telefono le
    [[NSUserDefaults standardUserDefaults] setInteger:[dateComponents hour] forKey:@"OraNotifica"];
    [[NSUserDefaults standardUserDefaults] setInteger:[dateComponents minute] forKey:@"MinutiNotifica"];
    
    [[NSUserDefaults standardUserDefaults] synchronize];
    
    
    
    [self createnotification];
    [newDatePickerView removeFromSuperview];
    //variabile che controlla se la view della notifica è stata già disegnata
    alarmViewReady = false;
}

//azione del bottone annulla nella view della notifica
//rimuove la view della notifica
- (void)annullaNotification {
	
    [newDatePickerView removeFromSuperview];
    alarmViewReady = false;
}



//crea la notifica locale
-(void)createnotification
{
    
    [[UIApplication sharedApplication] cancelAllLocalNotifications];
    
    [newDatePickerView removeFromSuperview];
    
    
    UIApplication * app = [UIApplication sharedApplication];
    
    UILocalNotification *notification = [[UILocalNotification alloc] init];
    
    
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
    
    [formatter setDateFormat:@"MM-dd-yyyy HH:mm"];
    
    
    
    NSString * notificatxt;
    
    // NSLog(@" datepicker %@",[datePicker date]);
    
    if (notification)
    {
        
        notification.fireDate = [datePicker date];//[NSDate date];//[NSDate dateWithTimeIntervalSinceNow:60];
        notification.timeZone = [NSTimeZone localTimeZone];
        notification.repeatInterval=NSDayCalendarUnit;
        notification.soundName = UILocalNotificationDefaultSoundName;
        notification.applicationIconBadgeNumber = [[UIApplication sharedApplication] applicationIconBadgeNumber] + 1;
        
        notificatxt = [NSString stringWithFormat:@"E' l'ora del Riciclo!"];
        notification.alertBody = notificatxt;
        [app scheduleLocalNotification:notification];
        
    }
    
    [[NSUserDefaults standardUserDefaults] setValue:@"S" forKey:@"AlarmSet"];
    [alarm setImage: [UIImage imageNamed:@"ic_iconon.png"] ] ;
    
    
    [[NSUserDefaults standardUserDefaults] synchronize];
    
}

//elimina la notifica impostata
//imposta la variabile che ricorda l'impostazione di notifica
//cambia l'icona della notifica
- (void)clearNotification {
	
	[[UIApplication sharedApplication] cancelAllLocalNotifications];
    [[NSUserDefaults standardUserDefaults] setValue:@"N" forKey:@"AlarmSet"];
    
    [alarm setImage: [UIImage imageNamed:@"ic_iconoff.png"] ] ;
    [alarm setTintColor:[UIColor whiteColor]];
    [newDatePickerView removeFromSuperview];
    alarmViewReady = false;
}

//table view

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    UILabel *textLabel;
    textLabel = [[[UILabel alloc] initWithFrame:CGRectMake(0, 10, 10, 10)] autorelease];
    GiorniRiciclo *GiornoRiciclo;
    
    if (tableView == self.tvOggi) {
        
        GiornoRiciclo = [GiorniRiciclaggio objectAtIndex:indexPath.item];
        cell.textLabel.text = [GiornoRiciclo tiporiciclo];
        
    }
    
    if (tableView == self.tvDomani) {
        
        GiornoRiciclo = [GiorniRiciclaggioDomani objectAtIndex:indexPath.item];
        textLabel = [[[UILabel alloc] initWithFrame:CGRectMake(0, 5, 10, 10)] autorelease];
        
        cell.textLabel.text = [GiornoRiciclo tiporiciclo];
        
        
    }
    if (tableView == self.tvDopoDomani) {
        
        GiornoRiciclo = [GiorniRiciclaggioDopodomani objectAtIndex:indexPath.item];
        textLabel = [[[UILabel alloc] initWithFrame:CGRectMake(0, 5, 10, 10)] autorelease];
        
        cell.textLabel.text = [GiornoRiciclo tiporiciclo];
        
    }
    if (tableView == self.tv3Giorni) {
        
        GiornoRiciclo= [GiorniRiciclaggio3Giorni objectAtIndex:indexPath.item];
        textLabel = [[[UILabel alloc] initWithFrame:CGRectMake(0, 5, 10, 10)] autorelease];
        
        cell.textLabel.text = [GiornoRiciclo tiporiciclo];
        
        
    }
    
    textLabel.backgroundColor=[UIColor whiteColor];
    
    if ([GiornoRiciclo colore] != NULL)
    {
        
        unsigned rgbValue = 0;
        NSScanner *scanner = [NSScanner scannerWithString:[GiornoRiciclo colore]];
        [scanner setScanLocation:1]; // bypass '#' character
        [scanner scanHexInt:&rgbValue];
        textLabel.backgroundColor = [UIColor colorWithRed:((rgbValue & 0xFF0000) >> 16)/255.0 green:((rgbValue & 0xFF00) >> 8)/255.0 blue:(rgbValue & 0xFF)/255.0 alpha:1.0];
        
    }
    
    
    textLabel.font = [UIFont boldSystemFontOfSize:[UIFont labelFontSize]];
    //[cell.textLabel addSubview:textLabel];
    [cell.contentView addSubview:textLabel];
    
    /*
     
     UIImageView *accessoryView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 5, 5)];
     
     accessoryView.backgroundColor= [UIColor redColor];
     
     
     [cell setAccessoryView:accessoryView];
     [accessoryView release];
     */
    
    //cell.textLabel.adjustsFontSizeToFitWidth = YES;
    //cell.textLabel.numberOfLines = 2;
    cell.textLabel.font = [UIFont systemFontOfSize:9.0];
    return cell;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (tableView == self.tvOggi) {
        
        return [GiorniRiciclaggio count];
    }
    if (tableView == self.tvDomani) {
        return [GiorniRiciclaggioDomani count];
    }
    if (tableView == self.tvDopoDomani) {
        return [GiorniRiciclaggioDopodomani count];
    }
    if (tableView == self.tv3Giorni) {
        return [GiorniRiciclaggio3Giorni count];
    }
    
    return 0;
    
}

- (void)tableView: (UITableView *)tableView didSelectRowAtIndexPath: (NSIndexPath *)indexPath {
    
    NSString * strMessage;
    GiorniRiciclo * GiornoRiciclo;
    
    if (tableView == self.tvOggi) {
        
        GiornoRiciclo =[GiorniRiciclaggio objectAtIndex:indexPath.item] ;
    }
    if (tableView == self.tvDomani) {
        GiornoRiciclo  =[GiorniRiciclaggioDomani objectAtIndex:indexPath.item];
    }
    if (tableView == self.tvDopoDomani) {
        GiornoRiciclo  =[GiorniRiciclaggioDopodomani objectAtIndex:indexPath.item] ;
    }
    if (tableView == self.tv3Giorni) {
        GiornoRiciclo = [GiorniRiciclaggio3Giorni objectAtIndex:indexPath.item];
        
    }
    
    strMessage =[GiornoRiciclo descrizionepercomune];
    if ([strMessage  isEqual:@""])
    {
        strMessage =[GiornoRiciclo descrizione];
        
    }
    
    
    UIAlertView *message = [[UIAlertView alloc] initWithTitle:@"IoRiciclo"
                                                      message:strMessage
                                                     delegate:nil
                                            cancelButtonTitle:@"OK"
                                            otherButtonTitles:nil];
    [message show];
    
}


//FINE SEZIONE NOTIFICHE


//ROTAZIONE

- (void)willAnimateRotationToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration
{
    if (toInterfaceOrientation == UIInterfaceOrientationLandscapeLeft ||
        toInterfaceOrientation == UIInterfaceOrientationLandscapeRight)
    {
        self.toolBar.frame = CGRectMake(self.toolBar.bounds.origin.x,
                                        18, self.view.frame.size.width, self.toolBar.bounds.size.height);
        
        self.giorniFuturiView.frame = CGRectMake(self.imageViewBackground.bounds.size.width -50,
                                                 self.lblData.frame.origin.y, 210, 260);
        
    }
    
    
}

//Fine ROTAZIONE

//iAd Banner

/*
 - (void) createAdBannerView
 {
 adBannerView = [[ADBannerView alloc] initWithFrame:CGRectZero];
 CGRect bannerFrame = self.adBannerView.frame;
 bannerFrame.origin.y = self.view.frame.size.height;
 self.adBannerView.frame = bannerFrame;
 
 self.adBannerView.delegate = self;
 
 }
 
 - (void) adjustBannerView
 {
 CGRect contentViewFrame = self.view.bounds;
 CGRect adBannerFrame = self.adBannerView.frame;
 
 if([self.adBannerView isBannerLoaded])
 {
 CGSize bannerSize = self.adBannerView.bounds.size;
 contentViewFrame.size.height = (contentViewFrame.size.height - bannerSize.height);
 adBannerFrame.origin.y = contentViewFrame.size.height;
 }
 else
 {
 adBannerFrame.origin.y = contentViewFrame.size.height;
 }
 [UIView animateWithDuration:0.5 animations:^{
 self.adBannerView.frame = adBannerFrame;
 self.contentView.frame = contentViewFrame;
 }];
 }
 
 #pragma mark - ADBannerViewDelegate
 
 - (void)bannerViewDidLoadAd:(ADBannerView *)banner
 {
 [self adjustBannerView];
 }
 
 - (void)bannerView:(ADBannerView *)banner didFailToReceiveAdWithError:(NSError *)error
 {
 [self adjustBannerView];
 }
 
 - (BOOL)bannerViewActionShouldBegin:(ADBannerView *)banner willLeaveApplication:(BOOL)willLeave
 {
 //TO DO
 //Check internet connecction here
 
 // if(internetNotAvailable)
 //{
 //UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"No internet." message:@"Please make sure an internet connection is available." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
 // [alert show];
 //[alert release];
 //return NO;
 //}
 return YES;
 }
 
 - (void)bannerViewActionDidFinish:(ADBannerView *)banner
 {
 
 }
 
 */

//fine aiadbanner

@end

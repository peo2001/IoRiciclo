//
//  ComuniViewController.m
//  IoRiciclo
//
//  Created by Maria Cristina Narcisi on 29/08/13.
//  Copyright (c) 2013 Maria Cristina Narcisi. All rights reserved.
//

#import "ComuniViewController.h"
#import "UrlZoneViewController.h"

@interface ComuniViewController ()

@end

@implementation ComuniViewController

@synthesize IdProvincia;

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.navigationController setNavigationBarHidden:NO ];
   
       
}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
   // self.navigationController.navigationBar.backItem.title = @"Back";
    self.navigationItem.title = @"Comuni";
    //self.navigationController.navigationBar.topItem.title = @"Comuni";
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;

    [self performSelectorInBackground:@selector(CaricaComuni) withObject:nil];
    
  
}

-(void)CaricaComuni
{
    [Syncronizer SyncComuni:IdProvincia];
    comuni = [Comuni RC_Fetch:IdProvincia :@"comune"];
    [self.tableView reloadData];
    
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return [[comuni sections]count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSArray *sections = [comuni sections];
    id <NSFetchedResultsSectionInfo> sectionInfo = [sections objectAtIndex:section];
    //NSLog(@"%lu",(unsigned long)[sectionInfo numberOfObjects]);
    return [sectionInfo numberOfObjects];
      
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
    
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    [self configureCell:cell atIndexPath:indexPath];
    return cell;
}

- (void)configureCell:(UITableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath {
    
    Comuni *info = [comuni objectAtIndexPath:indexPath];
    cell.textLabel.text = [info comune];
    cell.detailTextLabel.text = [info comune];
   
   // NSLog(@"comune : %@ ,nomeGestore : %@, urlGestore : %@",[info comune],[info nomeGestore],[info urlGestore]);
    
    if ([[info gestByComune] isEqualToString:@"S"])
    {
        cell.accessoryView =[[ UIImageView alloc ] initWithImage:[UIImage imageNamed:@"lampadinagreen.png"]];
    }else
    {
      /* if ((([info nomeGestore]!=nil)&&(![[info nomeGestore] isEqual:@""])) || (([info urlGestore]!=nil)&&(![[info urlGestore] isEqual:@""])))
       {
           cell.accessoryView =[[ UIImageView alloc ] initWithImage:[UIImage imageNamed:@"lampadinaazzurro.png"]];
       }else
       {
           cell.accessoryView =[[ UIImageView alloc ] initWithImage:[UIImage imageNamed:@"lampadinagray.png"]];
       }
       */
        cell.accessoryView =[[ UIImageView alloc ] initWithImage:[UIImage imageNamed:@"lampadinaazzurro.png"]];
    }
    
    //[cell.accessoryView setFrame:CGRectMake(0, 0, 24, 24)];
}


- (IBAction)displayActionSheet:(id)sender
{
    //carica i pulsanti con le zone 
   UIActionSheet *actionSheet = [[UIActionSheet alloc]
                                  initWithTitle:@"Seleziona la Tua Zona"
                                  delegate:self
                                  cancelButtonTitle:nil
                                  destructiveButtonTitle:nil
                                  otherButtonTitles:nil];

    [Syncronizer SyncZone:sender];
    
    comune = [[Comuni RC_Comune:sender] objectAtIndex:0];
    
    if (comune.HasUrlZone)
    {
        [actionSheet addButtonWithTitle:[NSString stringWithFormat:@"Individua La Tua Zona" ]];
        UIButton *button = [[actionSheet subviews] objectAtIndex:1];
        
        UIImage *img = [button backgroundImageForState:UIControlStateHighlighted];//[UIImage imageNamed:@"alert_button.png"];
        [button setBackgroundImage:img forState:UIControlStateNormal];
        //[button setBackgroundColor:[UIColor redColor]];
        //[button setTintColor:[UIColor redColor]];
        
    }
    
    zone = [Zone RC_perComune:sender ];
    for( Zone * zona in zone)
    {
        [actionSheet addButtonWithTitle:[NSString stringWithFormat:@"%@",[zona zona]]];
    }
    
    [actionSheet addButtonWithTitle:[NSString stringWithFormat:@"Annulla"]];
    actionSheet.cancelButtonIndex = actionSheet.numberOfButtons-1;
    
    actionSheet.actionSheetStyle = UIActionSheetStyleDefault;
    
    [actionSheet showInView:self.view];
    
}    // release popover in 'popoverControllerDidDismissPopover:' method

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
   
    if ((buttonIndex !=(actionSheet.numberOfButtons-1 )) &&(!comune.HasUrlZone))
    {
        //salva nel registro del telefono le informazioni della zona e del comune che servono per individuare i giorni di riciclo
        [[NSUserDefaults standardUserDefaults] setValue:[[zone objectAtIndex:buttonIndex]idcomune] forKey:@"IdComune"];
        //  NSLog(@"Zona Id %@",[[zone objectAtIndex:buttonIndex]idzona]);
        [[NSUserDefaults standardUserDefaults] setValue:[[zone objectAtIndex:buttonIndex]idzona] forKey:@"IdZona"];
        
        [[NSUserDefaults standardUserDefaults] synchronize];
        //recuper le informazioni del comune e della zona dal registro del telefono e li salva nelle variabili globali dell'applicazione
        NSNumber * IdComune = [[NSUserDefaults standardUserDefaults] valueForKey:@"IdComune"];
        NSNumber * IdZona = [[NSUserDefaults standardUserDefaults] valueForKey:@"IdZona"];
        
        
        [MyApplicationSingleton setIdComune:IdComune];
        [MyApplicationSingleton setIdZona:IdZona];
        
        [self sendUididToServer];
        
        [self performSegueWithIdentifier: @"goToRiciclo" sender: nil];
    }
    if ((buttonIndex !=(actionSheet.numberOfButtons-1 )) &&(((comune.HasUrlZone) && (buttonIndex !=0))))
    {
        
        //salva nel registro del telefono le informazioni della zona e del comune che servono per individuare i giorni di riciclo
        [[NSUserDefaults standardUserDefaults] setValue:[[zone objectAtIndex:buttonIndex-1]idcomune] forKey:@"IdComune"];
      //  NSLog(@"Zona Id %@",[[zone objectAtIndex:buttonIndex]idzona]);
        [[NSUserDefaults standardUserDefaults] setValue:[[zone objectAtIndex:buttonIndex-1]idzona] forKey:@"IdZona"];
        
        [[NSUserDefaults standardUserDefaults] synchronize];
        //recuper le informazioni del comune e della zona dal registro del telefono e li salva nelle variabili globali dell'applicazione
        NSNumber * IdComune = [[NSUserDefaults standardUserDefaults] valueForKey:@"IdComune"];
        NSNumber * IdZona = [[NSUserDefaults standardUserDefaults] valueForKey:@"IdZona"];
        
        
        [MyApplicationSingleton setIdComune:IdComune];
        [MyApplicationSingleton setIdZona:IdZona];
        
        [self sendUididToServer];
        
        [self performSegueWithIdentifier: @"goToRiciclo" sender: nil];

    }

    
    if((comune.HasUrlZone) && (buttonIndex ==0))
    {
        [self performSegueWithIdentifier: @"goToUrlZone" sender:self];
    }
    
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Make sure your segue name in storyboard is the same as this line
    if ([[segue identifier] isEqualToString:@"goToUrlZone"])
    {
        // Get reference to the destination view controller
        UrlZoneViewController *vc = [segue destinationViewController];
        
        // Pass any objects to the view controller here, like...
        [vc setUrlZone:comune.urlZone];
    }
}

-(void)sendUididToServer
{
    UIDevice *myDevice = [UIDevice currentDevice];
    
    NSString * deviceUDID = [[myDevice identifierForVendor]UUIDString];
    NSLog(@"deviceUDID %@",deviceUDID);
    NSURLRequest *request = [NSURLRequest requestWithURL:
                             [NSURL URLWithString:[NSString stringWithFormat:@"%@regId=%@&idC=%@&idZ=%@",[Syncronizer UrlRequestSendUdid] ,deviceUDID,[MyApplicationSingleton getIdComune],[MyApplicationSingleton getIdZona]]]];
   // NSLog(@"URL NOTIFIC: %@",[NSString stringWithFormat:@"http://kiss/IoRiciclo/Appleregister.asp?regId=%@idC=%@",deviceUDID,[MyApplicationSingleton getIdComune]]);

    
    [[NSURLConnection alloc] initWithRequest:request delegate:self];
}


#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self displayActionSheet:[[comuni objectAtIndexPath:indexPath]idcomune]];
}

@end

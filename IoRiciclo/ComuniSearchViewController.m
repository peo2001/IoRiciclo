//
//  ComuniSearchViewController.m
//  IoRiciclo
//
//  Created by Maria Cristina Narcisi on 26/05/14.
//  Copyright (c) 2014 Maria Cristina Narcisi. All rights reserved.
//

#import "ComuniSearchViewController.h"
#import "UrlZoneViewController.h"
#import "SocialLoginViewController.h"


@interface ComuniSearchViewController ()

@property (nonatomic, strong) NSMutableArray *tableData;
@property (nonatomic, strong) NSMutableArray *searchResult;

@end

@implementation ComuniSearchViewController

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    //_SearchBar.delegate = self;
    //self.navigationItem.titleView = self.searchDisplayController.searchBar ;
    
       
    if ([MyApplicationSingleton getIdComune]==nil  && [MyApplicationSingleton getIdZona]==nil)
    {
        
        [self.navigationController setNavigationBarHidden:YES animated:animated];
        
        UIAlertView *message = [[UIAlertView alloc] initWithTitle:@"IoRiciclo"
                                                          message:@"Attenzione non hai ancora selezionato un Comune"
                                                         delegate:self
                                                cancelButtonTitle:@"Seleziona Comune"
                                                otherButtonTitles:nil];
        [message show];
        
    }else{
        
        [self.navigationController setNavigationBarHidden:NO animated:animated];
        self.navigationController.navigationBar.topItem.title=@"Seleziona il Tuo Comune";
        
    }
    
    self.tableData = [[NSMutableArray alloc]init] ;
    self.searchResult = [NSMutableArray arrayWithCapacity:[self.tableData count]];
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    [self performSelectorInBackground:@selector(CaricaComuniGeo) withObject:nil];
     //[self.tableView searchBar ];
    //_searchBar.showsCancelButton =NO;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    
    
    
    
}

-(void)CaricaComuniGeo
{
    [Syncronizer SyncComuniGeo];
    
    comuni = [Comuni RC_];
    
    self.tableData = comuni;
    
    [self.tableView reloadData];
    
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
    
}
    
-(void)CaricaComuniStringSearch : (NSString *)strSearch
{
    [Syncronizer SyncComuniStringSearch:strSearch];
    
    comuni = [Comuni RC_];
    
    self.searchResult = comuni;
    
    [self.tableView reloadData];
    
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (tableView == self.searchDisplayController.searchResultsTableView)
    {
        return [self.searchResult count];
    }
    else
    {
        return [self.tableData count];
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (cell == nil)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    
    Comuni * com = nil;
    
    if (tableView == self.searchDisplayController.searchResultsTableView)
    {
        com=[self.searchResult objectAtIndex:indexPath.row];
        
    }
    else
    {
        com =[self.tableData objectAtIndex:indexPath.row ] ;
    }
    cell.textLabel.text = [com comune];
    

    
    if ([[com gestByComune] isEqualToString:@"S"])
    {
        cell.accessoryView =[[ UIImageView alloc ] initWithImage:[UIImage imageNamed:@"lampadinagreen.png"]];
    }else
    {
        if ([[com gestByComune] isEqualToString:@"NA"])
        {
            cell.accessoryView =[[ UIImageView alloc ] initWithImage:[UIImage imageNamed:@"lampadinagray.png"]];
        }
         if ((([com nomeGestore]!=nil)&&(![[com nomeGestore] isEqual:@""])) || (([com urlGestore]!=nil)&&(![[com urlGestore] isEqual:@""])))
         {
             cell.accessoryView =[[ UIImageView alloc ] initWithImage:[UIImage imageNamed:@"lampadinaazzurro.png"]];
         }else
         {
             if ([[com gestByComune] isEqualToString:@"N"])
             {
                 cell.accessoryView =[[ UIImageView alloc ] initWithImage:[UIImage imageNamed:@"lampadinaazzurro.png"]];
             }
             else
             {
                 //caso del consorzio al momento gestito come comune
                  cell.accessoryView =[[ UIImageView alloc ] initWithImage:[UIImage imageNamed:@"lampadinagreen.png"]];
             }
         }
        
    }
    
    return cell;
}

- (void)filterContentForSearchText:(NSString*)searchText scope:(NSString*)scope
{
   
    
    if ([searchText length] >2)
    {
        [self CaricaComuniStringSearch:searchText];
    }
    if ([searchText length] ==0)
    {
        [self CaricaComuniGeo];
    }
    
}

-(BOOL)searchDisplayController:(UISearchDisplayController *)controller shouldReloadTableForSearchString:(NSString *)searchString
{
    [self filterContentForSearchText:searchString scope:[[self.searchDisplayController.searchBar scopeButtonTitles] objectAtIndex:[self.searchDisplayController.searchBar selectedScopeButtonIndex]]];
    
    //[self filterContentForSearchText:searchString scope:@""];
    
    
    return YES;
}


//zone

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
    
    // se l'utente seleziona un comune che non è gestito
    if ([[comune gestByComune] isEqualToString:@"NA"])
    {
         [self performSegueWithIdentifier: @"goToSocial" sender: nil];
    }
    else
    {
        if (comune.HasUrlZone)
        {
            [actionSheet addButtonWithTitle:[NSString stringWithFormat:@"Individua La Tua Zona" ]];
           //	 NSLog(@"Num subview %ld",[[actionSheet subviews] count ]);

           // UIButton *button = [[actionSheet subviews] objectAtIndex:1];
            
            //UIImage *img = [button backgroundImageForState:UIControlStateHighlighted];//[UIImage imageNamed:@"alert_button.png"];
            //[button setBackgroundImage:img forState:UIControlStateNormal];
            urlzona = [comune urlZone];
        }
        
        zone = [Zone RC_perComune:sender ];
        for( Zone * zona in zone)
        {
            [actionSheet addButtonWithTitle:[NSString stringWithFormat:@"%@",[zona zona]]];
        }
        
        [actionSheet addButtonWithTitle:[NSString stringWithFormat:@"Annulla"]];
        actionSheet.cancelButtonIndex = actionSheet.numberOfButtons-1;
        
        actionSheet.actionSheetStyle = UIActionSheetStyleDefault;
        
        [actionSheet showInView:[self.navigationController view]];
    }
    
}    // release popover in 'popoverControllerDidDismissPopover:' method

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if ((buttonIndex !=(actionSheet.numberOfButtons-1 )) &&(!self.HasUrlZone))
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
        
        [self.navigationController popToRootViewControllerAnimated:TRUE];
        
    }
    
    if ((buttonIndex !=(actionSheet.numberOfButtons-1 )) &&(((self.HasUrlZone) && (buttonIndex !=0))))
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
        
        [self.navigationController popToRootViewControllerAnimated:TRUE];
        

    }
    
    
    if((self.HasUrlZone) && (buttonIndex ==0))
    {
        [self performSegueWithIdentifier: @"goToUrlZone2" sender:self];
    }
    
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Make sure your segue name in storyboard is the same as this line
    if ([[segue identifier] isEqualToString:@"goToUrlZone2"])
    {
        // Get reference to the destination view controller
        UrlZoneViewController *vc = [segue destinationViewController];
        
        // Pass any objects to the view controller here, like...
        [vc setUrlZone:comune.urlZone];
    }
    
    if ([[segue identifier] isEqualToString:@"goToSocial"])
    {
        
        SocialLoginViewController * destination = [segue destinationViewController];
        destination.comune = comune;
    }
}

-(void)sendUididToServer
{
    UIDevice *myDevice = [UIDevice currentDevice];
    
    NSString * deviceUDID = [[myDevice identifierForVendor]UUIDString];
    //NSLog(@"deviceUDID %@",deviceUDID);
    NSURLRequest *request = [NSURLRequest requestWithURL:
                             [NSURL URLWithString:[NSString stringWithFormat:@"%@regId=%@&idC=%@&idZ=%@",[Syncronizer UrlRequestSendUdid] ,deviceUDID,[MyApplicationSingleton getIdComune],[MyApplicationSingleton getIdZona]]]];
    // NSLog(@"URL NOTIFIC: %@",[NSString stringWithFormat:@"http://kiss/IoRiciclo/Appleregister.asp?regId=%@idC=%@",deviceUDID,[MyApplicationSingleton getIdComune]]);
    
    
    [[NSURLConnection alloc] initWithRequest:request delegate:self];
}


#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self displayActionSheet:[[comuni objectAtIndex:indexPath.row]idcomune]];
}




- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar
{
    
    [self CaricaComuniGeo];
    
    
}
-(BOOL)HasUrlZone
{
    return !([urlzona  isEqual:@""]|| (urlzona==nil));
}


- (void)dealloc {
    //[_SearchBar release];
    [super dealloc];
}
@end

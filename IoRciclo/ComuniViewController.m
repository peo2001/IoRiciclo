//
//  ComuniViewController.m
//  IoRciclo
//
//  Created by Maria Cristina Narcisi on 29/08/13.
//  Copyright (c) 2013 Maria Cristina Narcisi. All rights reserved.
//

#import "ComuniViewController.h"

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

       
}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    
    [self.navigationController setNavigationBarHidden:NO ];
    
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
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

- (IBAction)displayActionSheet:(id)sender
{
    //carica i pulsanti con le zone 
   UIActionSheet *actionSheet = [[UIActionSheet alloc]
                                  initWithTitle:@"Seleziona la Tua Zona"
                                  delegate:self
                                  cancelButtonTitle:@"Annulla"
                                  destructiveButtonTitle:nil
                                  otherButtonTitles:nil];

    [Syncronizer SyncZone:sender];
    zone = [Zone RC_perComune:sender ];
    for( Zone * zona in zone)
    {
        [actionSheet addButtonWithTitle:[NSString stringWithFormat:@"zona %@",[zona zona] ]];
    }
    
    
    actionSheet.actionSheetStyle = UIActionSheetStyleDefault;
    
    [actionSheet showInView:self.view];
    
}    // release popover in 'popoverControllerDidDismissPopover:' method

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
   // NSLog(@"buttonIndex: %d",buttonIndex);
    if (buttonIndex > 0 )
    {
        
        //salva nel registro del telefono le informazioni della zona e del comune che servono per individuare i giorni di riciclo
        [[NSUserDefaults standardUserDefaults] setValue:[[zone objectAtIndex:buttonIndex-1]idcomune] forKey:@"IdComune"];
        [[NSUserDefaults standardUserDefaults] setValue:[[zone objectAtIndex:buttonIndex-1]idzona] forKey:@"IdZona"];
        
        [[NSUserDefaults standardUserDefaults] synchronize];
        //recuper le informazioni del comune e della zona dal registro del telefono e li salva nelle variabili globali dell'applicazione
        NSNumber * IdComune = [[NSUserDefaults standardUserDefaults] valueForKey:@"IdComune"];
        NSNumber * IdZona = [[NSUserDefaults standardUserDefaults] valueForKey:@"IdZona"];
        
        [MyApplicationSingleton setIdComune:IdComune];
        [MyApplicationSingleton setIdZona:IdZona];
    }

    
    [self performSegueWithIdentifier: @"goToRiciclo" sender: nil];
    
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self displayActionSheet:[[comuni objectAtIndexPath:indexPath]idcomune]];
}

@end

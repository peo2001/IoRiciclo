//
//  AvvisiViewController.m
//  IoRiciclo
//
//  Created by Maria Cristina Narcisi on 19/11/13.
//  Copyright (c) 2013 Maria Cristina Narcisi. All rights reserved.
//

#import "AvvisiViewController.h"

#define FONT_SIZE 14.0f
#define FONT_SIZETITLE 14.0f
#define CELL_CONTENT_WIDTH 320.0f
#define CELL_CONTENT_MARGIN 10.0f

@interface AvvisiViewController ()

@end

@implementation AvvisiViewController

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
    
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    self.navigationController.navigationBar.backgroundColor=[UIColor redColor];
    [self.navigationController setNavigationBarHidden:NO ];
    //il sync delle province non ritorna nessun array perchè la Ricerca viene effettuata dopo per poter utilizzare il fetcher (il parsing del sincro torna una array e quindi non andrebbe bene)
    
    [self performSelectorInBackground:@selector(CaricaAvvisi) withObject:nil];
    
    
}

-(void)CaricaAvvisi
{
    [Syncronizer SyncAvvisi];
    avvisi = [Avvisi RC_Fetch: [MyApplicationSingleton getIdComune] :@"titolo"];
    
    comune = [[Comuni RC_Comune:[MyApplicationSingleton getIdComune]] objectAtIndex:0];
    
    _lblComune.text = [NSString stringWithFormat:@"  %@ Avvisi", comune.comune ];
    
    [self.tableView reloadData];
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
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
    return [[avvisi sections]count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSArray *sections = [avvisi sections];
    id <NSFetchedResultsSectionInfo> sectionInfo = [sections objectAtIndex:section];
    return [sectionInfo numberOfObjects];
    
}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    UITableViewCell *cell;
    UILabel *labelMessaggio = nil;
    UILabel *labelData = nil;
    UILabel *labelTitolo=nil;
    UILabel *labelUser=nil;
    
    cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
    
    
    // if (cell == nil)
    //{
    cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"Cell"] autorelease];
    
    
    labelUser = [[UILabel alloc] initWithFrame:CGRectZero];
    [labelUser setLineBreakMode:NSLineBreakByWordWrapping];
    // [label setMinimumFontSize:FONT_SIZE];
    [labelUser setNumberOfLines:0];
    //[labelUser setFont:[UIFont fontWithName:@"fontname" size:FONT_SIZE ]];
    [labelUser setFont:[UIFont boldSystemFontOfSize:FONT_SIZE]];
    [labelUser setTextColor:[UIColor colorWithRed:26.0f/255.0f green:131.0f/255.0f blue:32.0f/255.0f alpha:1.0f]];
    
    [labelUser setTag:1];
    [[cell contentView] addSubview:labelUser];
    
    labelData = [[UILabel alloc] initWithFrame:CGRectZero];
    [labelData setLineBreakMode:NSLineBreakByWordWrapping];
    // [label setMinimumFontSize:FONT_SIZE];
    [labelData setNumberOfLines:0];
    [labelData setFont:[UIFont systemFontOfSize:FONT_SIZE]];
    [labelData setTag:2];
    labelData.textColor = [UIColor colorWithRed:156.0f/255.0f green:101.0f/255.0f blue:32.0f/255.0f alpha:1.0f];
    
    //  [[label layer] setBorderWidth:2.0f];
    
    [[cell contentView] addSubview:labelData];
    
    labelTitolo = [[UILabel alloc] initWithFrame:CGRectZero];
    [labelTitolo setLineBreakMode:NSLineBreakByWordWrapping];
    // [label setMinimumFontSize:FONT_SIZE];
    [labelTitolo setNumberOfLines:0];
    [labelTitolo setFont:[UIFont boldSystemFontOfSize:FONT_SIZE]];
    [labelTitolo setTag:3];
    
    [[cell contentView] addSubview:labelTitolo];
    
    labelMessaggio = [[UILabel alloc] initWithFrame:CGRectZero];
    [labelMessaggio setLineBreakMode:NSLineBreakByWordWrapping];
    // [label setMinimumFontSize:FONT_SIZE];
    [labelMessaggio setNumberOfLines:0];
    [labelMessaggio setFont:[UIFont systemFontOfSize:FONT_SIZE]];
    [labelMessaggio setTag:4];
    
    //  [[label layer] setBorderWidth:2.0f];
    
    [[cell contentView] addSubview:labelMessaggio];
    
    
    
    
    //  }
    NSString *textUser =[[avvisi objectAtIndexPath: indexPath] titolo];
    
    NSString *textData = [NSString stringWithFormat:@"%@",[[avvisi objectAtIndexPath: indexPath] datacreazione]];
    NSString *textTitolo =@"";//[[avvisi objectAtIndexPath: indexPath] titolo];
    
    NSString *textMessaggio = [[avvisi objectAtIndexPath: indexPath] descrizione];
    
    
    
    CGSize constraint = CGSizeMake(CELL_CONTENT_WIDTH - (CELL_CONTENT_MARGIN * 2), 20000.0f);
    
    CGSize sizeUtente = [textUser sizeWithFont:[UIFont systemFontOfSize:FONT_SIZE] constrainedToSize:constraint lineBreakMode:NSLineBreakByWordWrapping];
    
    CGSize sizeData = [textData sizeWithFont:[UIFont systemFontOfSize:FONT_SIZE] constrainedToSize:constraint lineBreakMode:NSLineBreakByWordWrapping];
    
    CGSize sizeTitolo = [textTitolo sizeWithFont:[UIFont systemFontOfSize:FONT_SIZE] constrainedToSize:constraint lineBreakMode:NSLineBreakByWordWrapping];
    
    
    CGSize sizeMessaggio = [textMessaggio sizeWithFont:[UIFont systemFontOfSize:FONT_SIZE] constrainedToSize:constraint lineBreakMode:NSLineBreakByWordWrapping];
    
    
    if (!labelUser)
        labelUser = (UILabel*)[cell viewWithTag:1];
    if (!labelData)
        labelData = (UILabel*)[cell viewWithTag:2];
    if (!labelTitolo)
        labelTitolo = (UILabel*)[cell viewWithTag:3];
    if (!labelMessaggio)
        labelMessaggio = (UILabel*)[cell viewWithTag:4];
    
    
    [labelUser setText:textUser];
    [labelData setText:textData];
    [labelTitolo setText:textTitolo];
    [labelMessaggio setText:textMessaggio];
    
    [labelUser setFrame:CGRectMake(CELL_CONTENT_MARGIN, CELL_CONTENT_MARGIN, CELL_CONTENT_WIDTH - (CELL_CONTENT_MARGIN * 2), sizeUtente.height)];
    
    
    
    [labelData setFrame:CGRectMake(CELL_CONTENT_MARGIN, CELL_CONTENT_MARGIN+sizeUtente.height, CELL_CONTENT_WIDTH - (CELL_CONTENT_MARGIN * 2),  sizeData.height +5)];
    
    [labelTitolo setFrame:CGRectMake(CELL_CONTENT_MARGIN, CELL_CONTENT_MARGIN+sizeData.height+sizeUtente.height +5, CELL_CONTENT_WIDTH - (CELL_CONTENT_MARGIN * 2),  sizeTitolo.height)];
    
    
    [labelMessaggio setFrame:CGRectMake(CELL_CONTENT_MARGIN, 5+CELL_CONTENT_MARGIN+sizeTitolo.height+sizeUtente.height+sizeData.height, CELL_CONTENT_WIDTH - (CELL_CONTENT_MARGIN * 2), sizeMessaggio.height)];
    
    /*
    UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:labelUser.bounds
                                                   byRoundingCorners:UIRectCornerTopLeft| UIRectCornerTopRight
                                                         cornerRadii:CGSizeMake(7.0, 7.0)];
    // Create the shape layer and set its path
    CAShapeLayer *maskLayer = [CAShapeLayer layer];
    maskLayer.frame = labelUser.bounds;
    maskLayer.path = maskPath.CGPath;
    
    // Set the newly created shape layer as the mask for the image view's layer
    labelUser.layer.mask = maskLayer;
    
    //fine prova
    
    CALayer *layer = cell.layer;
    layer.cornerRadius = 7.0f;
    layer.borderColor = [[UIColor lightGrayColor] CGColor];
    layer.borderWidth = 1.0f;
    */
    return cell;
    
    
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    
    NSString *textUser =[[avvisi objectAtIndexPath: indexPath] titolo];
    
    NSString *textData = [NSString stringWithFormat:@"%@",[[avvisi objectAtIndexPath: indexPath] datacreazione]];
    NSString *textTitolo =@"";//[[avvisi objectAtIndexPath: indexPath] titolo];
    
    NSString *textMessaggio = [[avvisi objectAtIndexPath: indexPath] descrizione];
    
    
    CGSize constraint = CGSizeMake(CELL_CONTENT_WIDTH - (CELL_CONTENT_MARGIN * 2), 20000.0f);
    
    CGSize sizeUser = [textUser sizeWithFont:[UIFont systemFontOfSize:FONT_SIZE] constrainedToSize:constraint lineBreakMode:NSLineBreakByWordWrapping];
    
    
    
    CGSize sizeData = [textData sizeWithFont:[UIFont systemFontOfSize:FONT_SIZE] constrainedToSize:constraint lineBreakMode:NSLineBreakByWordWrapping];
    
    
    CGSize sizeTitolo = [textTitolo sizeWithFont:[UIFont systemFontOfSize:FONT_SIZE] constrainedToSize:constraint lineBreakMode:NSLineBreakByWordWrapping];
    
    CGSize sizeMessaggio = [textMessaggio sizeWithFont:[UIFont systemFontOfSize:FONT_SIZE] constrainedToSize:constraint lineBreakMode:NSLineBreakByWordWrapping];
    
    CGFloat height = sizeUser.height+sizeTitolo.height+ sizeMessaggio.height + sizeData.height;
    
   
    
    return height+CELL_CONTENT_MARGIN  +20;
}



//fine prova

- (void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    /*
    if ([[segue identifier] isEqualToString: @"goToComuni"]) {
        ComuniViewController *destViewController = segue.destinationViewController;
        destViewController.IdProvincia =(NSNumber *)sender ;
    }
     */
}

- (void)controllerWillChangeContent:(NSFetchedResultsController *)controller {
    // The fetch controller is about to start sending change notifications, so prepare the table view for updates.
    [self.tableView beginUpdates];
}


- (void)controller:(NSFetchedResultsController *)controller didChangeObject:(id)anObject atIndexPath:(NSIndexPath *)indexPath forChangeType:(NSFetchedResultsChangeType)type newIndexPath:(NSIndexPath *)newIndexPath {
    
    UITableView *tableView = self.tableView;
    
    switch(type) {
            
        case NSFetchedResultsChangeInsert:
            [tableView insertRowsAtIndexPaths:[NSArray arrayWithObject:newIndexPath] withRowAnimation:UITableViewRowAnimationFade];
            break;
            
        case NSFetchedResultsChangeDelete:
            [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
            break;
            
        case NSFetchedResultsChangeUpdate:
            //[self configureCell:[tableView cellForRowAtIndexPath:indexPath] atIndexPath:indexPath];
            break;
            
        case NSFetchedResultsChangeMove:
            [tableView deleteRowsAtIndexPaths:[NSArray
                                               arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
            [tableView insertRowsAtIndexPaths:[NSArray
                                               arrayWithObject:newIndexPath] withRowAnimation:UITableViewRowAnimationFade];
            break;
    }
}


- (void)controller:(NSFetchedResultsController *)controller didChangeSection:(id )sectionInfo atIndex:(NSUInteger)sectionIndex forChangeType:(NSFetchedResultsChangeType)type {
    
    switch(type) {
            
        case NSFetchedResultsChangeInsert:
            [self.tableView insertSections:[NSIndexSet indexSetWithIndex:sectionIndex] withRowAnimation:UITableViewRowAnimationFade];
            break;
            
        case NSFetchedResultsChangeDelete:
            [self.tableView deleteSections:[NSIndexSet indexSetWithIndex:sectionIndex] withRowAnimation:UITableViewRowAnimationFade];
            break;
    }
}

/*- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    
    CGSize constraint = CGSizeMake(CELL_CONTENT_WIDTH - (CELL_CONTENT_MARGIN * 2), 20000.0f);
    
    
    CGSize size = [Descrizione sizeWithFont:[UIFont systemFontOfSize:FONT_SIZE] constrainedToSize:constraint lineBreakMode:NSLineBreakByWordWrapping];
    return size.height;
}
 */

- (void)controllerDidChangeContent:(NSFetchedResultsController *)controller {
    // The fetch controller has sent all current change notifications, so tell the table view to process all updates.
    [self.tableView endUpdates];
}

@end
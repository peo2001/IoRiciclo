//
//  CalendarioViewController.m
//  IoRciclo
//
//  Created by Maria Cristina Narcisi on 18/11/13.
//  Copyright (c) 2013 Maria Cristina Narcisi. All rights reserved.
//

#import "CalendarioViewController.h"

#define FONT_SIZE 14.0f
#define FONT_SIZETITLE 14.0f
#define CELL_CONTENT_WIDTH 320.0f
#define CELL_CONTENT_MARGIN 10.0f

@interface CalendarioViewController ()

@end

@implementation CalendarioViewController

@synthesize IdCalendario,Descrizione;

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
       
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    UIColor *background = [[UIColor alloc] initWithPatternImage:[UIImage imageNamed:@"backhome.jpg"]];
    self.tableView.backgroundColor = background;
    
    calendarioDetails =nil;
    
    
    [self performSelectorInBackground:@selector(CaricaCalendarioDetails) withObject:nil];
}

-(void)CaricaCalendarioDetails
{
    calendarioDetails=[CalendarioDetail RC_:IdCalendario];
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
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return calendarioDetails.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"CellCalendario";
    UITableViewCell *cell = nil;
    
    if (cell == nil)
    { //alloc the cell explicitily
        
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:CellIdentifier];
    }
    
    CalendarioDetail *cal = [calendarioDetails objectAtIndex:indexPath.item];
    cell.textLabel.text = [NSDateFormatter localizedStringFromDate:[cal data]
                                                         dateStyle:NSDateFormatterLongStyle
                                                         timeStyle:NSDateFormatterFullStyle];

    return cell;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
   
    
    //prova
    
     UILabel *label  = [[UILabel alloc] initWithFrame:CGRectZero];
    [label setLineBreakMode:NSLineBreakByWordWrapping];
    // [label setMinimumFontSize:FONT_SIZE];
    [label setNumberOfLines:0];
    //[labelUser setFont:[UIFont fontWithName:@"fontname" size:FONT_SIZE ]];
    [label setFont:[UIFont boldSystemFontOfSize:FONT_SIZE]];
    [label setTextColor:[UIColor whiteColor]];
    
    
    CGSize constraint = CGSizeMake(CELL_CONTENT_WIDTH - (CELL_CONTENT_MARGIN * 2), 20000.0f);
    
    CGSize size = [Descrizione sizeWithFont:[UIFont systemFontOfSize:FONT_SIZE] constrainedToSize:constraint lineBreakMode:NSLineBreakByWordWrapping];
    
    label.backgroundColor = [UIColor grayColor];
    [label setText:Descrizione];
   
    
    [label setFrame:CGRectMake(CELL_CONTENT_MARGIN, CELL_CONTENT_MARGIN, CELL_CONTENT_WIDTH - (CELL_CONTENT_MARGIN * 2), size.height)];
    
   // NSLog(@"height %f",size.height);
    
    //fine prova
    
    
   /* UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 280, 40)];
    label.numberOfLines = 2;
    label.textColor=[UIColor whiteColor];
    //label.text = [NSString stringWithFormat:@"Calendario Raccolta:\n%@",Descrizione ];
    label.text = Descrizione;
    label.textAlignment=NSTextAlignmentCenter;
    label.backgroundColor = [UIColor grayColor];
    */
    return [label autorelease];
}


- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    
    CGSize constraint = CGSizeMake(CELL_CONTENT_WIDTH - (CELL_CONTENT_MARGIN * 2), 20000.0f);
    
    
    CGSize size = [Descrizione sizeWithFont:[UIFont systemFontOfSize:FONT_SIZE] constrainedToSize:constraint lineBreakMode:NSLineBreakByWordWrapping];
    return size.height;
}
 
@end

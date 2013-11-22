//
//  AvvisiViewController.h
//  IoRciclo
//
//  Created by Maria Cristina Narcisi on 19/11/13.
//  Copyright (c) 2013 Maria Cristina Narcisi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "avvisi.h"
#import "MyApplicationSingleton.h"
#import "Syncronizer.h"
#import <QuartzCore/QuartzCore.h>

@interface AvvisiViewController : UITableViewController
{
    NSFetchedResultsController * avvisi;
    
    Comuni * comune;
}

@property (nonatomic, strong) IBOutlet UILabel *lblComune;

@end

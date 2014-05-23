//
//  ComuniViewController.h
//  IoRiciclo
//
//  Created by Maria Cristina Narcisi on 29/08/13.
//  Copyright (c) 2013 Maria Cristina Narcisi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Comuni.h"
#import "Zone.h"
#import "MyApplicationSingleton.h"
#import "Syncronizer.h"



@interface ComuniViewController : UITableViewController<UIActionSheetDelegate>
{
    NSFetchedResultsController * comuni;
    NSNumber * IdProvincia;
    NSMutableArray *zone;
    Comuni *comune;
}

@property (nonatomic, retain) NSNumber * IdProvincia;

@end

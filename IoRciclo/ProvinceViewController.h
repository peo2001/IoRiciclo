//
//  ProvinceViewController.h
//  IoRciclo
//
//  Created by Maria Cristina Narcisi on 30/08/13.
//  Copyright (c) 2013 Maria Cristina Narcisi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Comuni.h"
#import "Zone.h"
#import "MyApplicationSingleton.h"
#import "Syncronizer.h"
#import "ComuniViewController.h"

@interface ProvinceViewController : UITableViewController
{
    NSFetchedResultsController * province;
}

@end

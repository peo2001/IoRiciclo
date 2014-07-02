//
//  ComuniSearchViewController.h
//  IoRiciclo
//
//  Created by Maria Cristina Narcisi on 26/05/14.
//  Copyright (c) 2014 Maria Cristina Narcisi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Syncronizer.h"

@interface ComuniSearchViewController : UITableViewController<UIActionSheetDelegate,UISearchDisplayDelegate,UISearchBarDelegate>
{

    NSMutableArray *comuni;
    Comuni *comune;
    NSMutableArray *zone;
    NSString * urlzona;
}

@property (retain, nonatomic) IBOutlet UISearchBar *SearchBar;


@end

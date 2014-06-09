//
//  ComuniSearchViewController.h
//  IoRiciclo
//
//  Created by Maria Cristina Narcisi on 26/05/14.
//  Copyright (c) 2014 Maria Cristina Narcisi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Syncronizer.h"

@interface ComuniSearchViewController : UITableViewController<UIActionSheetDelegate>
{

    NSMutableArray *comuni;
    Comuni *comune;
    NSMutableArray *zone;
}



@end

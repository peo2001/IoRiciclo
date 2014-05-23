//
//  CalendarioViewController.h
//  IoRiciclo
//
//  Created by Maria Cristina Narcisi on 18/11/13.
//  Copyright (c) 2013 Maria Cristina Narcisi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CalendarioDetail.h"

@interface CalendarioViewController : UITableViewController
{
    NSMutableArray * calendarioDetails;
    NSNumber * IdCalendario;
    NSString * Descrizione;

}

@property (nonatomic, retain) NSNumber * IdCalendario;
@property (nonatomic, retain) NSString * Descrizione;


@end

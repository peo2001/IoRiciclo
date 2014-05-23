//
//  CalendarioDetail.h
//  IoRiciclo
//
//  Created by Maria Cristina Narcisi on 18/11/13.
//  Copyright (c) 2013 Maria Cristina Narcisi. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import "ManagedObjectBase.h"


@interface CalendarioDetail : ManagedObjectBase

@property (nonatomic, retain) NSNumber * idcalendariodetail;
@property (nonatomic, retain) NSNumber * idcalendario;
@property (nonatomic, retain) NSDate * data;
@property (nonatomic, retain) NSDate * ora;


+(NSMutableArray*)_parseXmlDictionary:(NSDictionary *)aDictionary : (NSNumber *)IdCalendario;

+(CalendarioDetail *)Load;
+(NSMutableArray *)RC_;
+(NSFetchedResultsController *)RC_Fetch;
+(NSMutableArray *)RC_:(NSNumber *)IdCalendario;
//+ (NSString *)UrlRequest;

@end

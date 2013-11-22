//
//  Avvisi.h
//  IoRciclo
//
//  Created by Maria Cristina Narcisi on 19/11/13.
//  Copyright (c) 2013 Maria Cristina Narcisi. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import "ManagedObjectBase.h"


@interface Avvisi : ManagedObjectBase

@property (nonatomic, retain) NSNumber * idavviso;
@property (nonatomic, retain) NSNumber * idcomune;
@property (nonatomic, retain) NSString * titolo;
@property (nonatomic, retain) NSString * descrizione;
@property (nonatomic, retain) NSDate * datacreazione;

+(NSMutableArray*)_parseXmlDictionary:(NSDictionary *)aDictionary ;

+(Avvisi *)Load;
+(NSMutableArray *)RC_:(NSNumber *)IdComune;
+(NSFetchedResultsController *)RC_Fetch:(NSNumber *)IdComune :(NSString *)Sort;
+ (NSString *)UrlRequest;

@end

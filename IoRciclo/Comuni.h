//
//  Comuni.h
//  IoRciclo
//
//  Created by Maria Cristina Narcisi on 30/08/13.
//  Copyright (c) 2013 Maria Cristina Narcisi. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import "ManagedObjectBase.h"

@interface Comuni : ManagedObjectBase

@property (nonatomic, retain) NSString * comune;
@property (nonatomic, retain) NSNumber * idcomune;
@property (nonatomic, retain) NSNumber * idprovincia;

+(NSMutableArray*)_parseXmlDictionary:(NSDictionary *)aDictionary;

+(Comuni *)Load;
+(NSMutableArray *)RC_perProv:(NSNumber *)Idprovincia;
+(NSFetchedResultsController *)RC_Fetch:(NSNumber *)IdProvincia :(NSString *)Sort;
+(NSMutableArray *)RC_:(NSNumber *)IdComune;
+(NSMutableArray *)RC_Comune:(NSNumber *)IdComune;
+ (NSString *)UrlRequest;

@end
//
//  Province.h
//  IoRciclo
//
//  Created by Maria Cristina Narcisi on 30/08/13.
//  Copyright (c) 2013 Maria Cristina Narcisi. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <XTM_CoreData/XTM_CoreData.h>

@interface Province : ManagedObjectBase

@property (nonatomic, retain) NSNumber * idprovincia;
@property (nonatomic, retain) NSNumber * idregione;
@property (nonatomic, retain) NSString * regione;
@property (nonatomic, retain) NSString * provincia;

+(NSMutableArray*)_parseXmlDictionary:(NSDictionary *)aDictionary;

+(Province *)Load;
+(NSMutableArray *)RC_;
+(NSFetchedResultsController *)RC_Fetch;
+(NSMutableArray *)RC_:(NSNumber *)IdRegione;
+ (NSString *)UrlRequest;

@end

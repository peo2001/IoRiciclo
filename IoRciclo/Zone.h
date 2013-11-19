//
//  Zone.h
//  IoRciclo
//
//  Created by Maria Cristina Narcisi on 07/07/13.
//  Copyright (c) 2013 Maria Cristina Narcisi. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <XTM_CoreData/XTM_CoreData.h>


@interface Zone : ManagedObjectBase

@property (nonatomic, retain) NSNumber * idzona;
@property (nonatomic, retain) NSNumber * idcomune;
@property (nonatomic, retain) NSString * zona;

+(NSMutableArray*)_parseXmlDictionary:(NSDictionary *)aDictionary;

+(Zone *)Load;
+(NSMutableArray *)RC_:(NSNumber *)IdZona;
+(NSMutableArray *)RC_perComune:(NSNumber *)IdComune;
+ (NSString *)UrlRequest;

@end

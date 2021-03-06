//
//  TipiRiciclo.h
//  IoRiciclo
//
//  Created by Maria Cristina Narcisi on 07/07/13.
//  Copyright (c) 2013 Maria Cristina Narcisi. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import "ManagedObjectBase.h"

@interface TipiRiciclo : ManagedObjectBase

@property (nonatomic, retain) NSString * codtiporiciclo;
@property (nonatomic, retain) NSString * immagine;
@property (nonatomic, retain) NSString * tiporiciclo;


+(NSMutableArray*)_parseXmlDictionary:(NSDictionary *)aDictionary;

+(TipiRiciclo *)Load;
+(NSMutableArray *)RC_;
+(NSMutableArray *)RC_: (NSString *) codtiporiciclo;
+ (NSString *)UrlRequest;

@end

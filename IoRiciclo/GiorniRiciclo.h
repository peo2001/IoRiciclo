//
//  GiorniRiciclo.h
//  IoRiciclo
//
//  Created by Maria Cristina Narcisi on 07/09/13.
//  Copyright (c) 2013 Maria Cristina Narcisi. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DateHelper.h"
#import <CoreData/CoreData.h>
#import "ManagedObjectBase.h"


@interface GiorniRiciclo : ManagedObjectBase


@property (nonatomic, retain) NSString * codtiporiciclo;
@property (nonatomic, retain) NSDate * datagiorno;
@property (nonatomic, retain) NSDate * ora;
@property (nonatomic, retain) NSNumber * idcomune;
@property (nonatomic, retain) NSNumber * idgiornoriciclo;
@property (nonatomic, retain) NSNumber * idzona;
@property (nonatomic, retain) NSString * descrizione;
@property (nonatomic, retain) NSString * immagine;
@property (nonatomic, retain) NSString * descrizionepercomune;
@property (nonatomic, retain) NSString * immaginepercomune;
@property (nonatomic, retain) NSString * tiporiciclo;
@property (nonatomic, retain) NSString * colore;
@property (nonatomic, retain) NSNumber * durata;

- (NSDate *) datagiornofine;

+(NSMutableArray*)_parseXmlDictionary:(NSDictionary *)aDictionary;

+(GiorniRiciclo *)Load;
+(NSMutableArray *)RC_;
+(NSMutableArray *)RC_:(NSNumber *)IdComune :(NSNumber *)IdZona :(NSDate *)dataDa : (NSDate *) dataA;
+ (NSString *)UrlRequest;


@end

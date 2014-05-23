//
//  Comuni.h
//  IoRiciclo
//
//  Created by Maria Cristina Narcisi on 30/08/13.
//  Copyright (c) 2013 Maria Cristina Narcisi. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import "ManagedObjectBase.h"
#import <MapKit/MapKit.h>

@interface Comuni : ManagedObjectBase<MKAnnotation>


@property (nonatomic, retain) NSString * comune;
@property (nonatomic, retain) NSNumber * idcomune;
@property (nonatomic, retain) NSNumber * idprovincia;
@property (nonatomic, retain) NSString * provincia;
@property (nonatomic, retain) NSString * cap;
@property (nonatomic, retain) NSString * codiceIstat;
@property (nonatomic, retain) NSString * email;
@property (nonatomic, retain) NSString * emailAmbiente;
@property (nonatomic, retain) NSString * logo;
@property (nonatomic, retain) NSNumber * latitudine;
@property (nonatomic, retain) NSNumber * longitudine;
@property (nonatomic, retain) NSString * regione;
@property (nonatomic, retain) NSString * url;
@property (nonatomic, retain) NSString * urlZone;
@property (nonatomic, retain) NSNumber * numeroAbitanti;
@property (nonatomic, retain) NSNumber * idGestore;
@property (nonatomic, retain) NSString * nomeGestore;
@property (nonatomic, retain) NSString * userGestore;
@property (nonatomic, retain) NSString * urlGestore;
@property (nonatomic, retain) NSString * gestByComune;

@property (nonatomic, assign) CLLocationCoordinate2D coordinate;

+(NSMutableArray*)_parseXmlDictionary:(NSDictionary *)aDictionary;
+(NSMutableArray*)_parseXmlDictionarySingleComune:(NSDictionary *)aDictionary;

-(BOOL)HasUrlZone;
-(BOOL)IsGestorePrivato;

+(Comuni *)Load;
+(NSMutableArray *)RC_perProv:(NSNumber *)Idprovincia;
+(NSFetchedResultsController *)RC_Fetch:(NSNumber *)IdProvincia :(NSString *)Sort;
+(NSMutableArray *)RC_:(NSNumber *)IdComune;
+(NSMutableArray *)RC_Comune:(NSNumber *)IdComune;
+ (NSString *)UrlRequest;
+ (NSString *)UrlRequestSingoloComune;

@end
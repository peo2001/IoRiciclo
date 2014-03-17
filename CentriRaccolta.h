//
//  CentriRaccolta.h
//  IoRiciclo
//
//  Created by Maria Cristina Narcisi on 15/11/13.
//  Copyright (c) 2013 Maria Cristina Narcisi. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import "ManagedObjectBase.h"
#import "CalendarioDetail.h"
#import <MapKit/MapKit.h>


@interface CentriRaccolta : ManagedObjectBase<MKAnnotation>

@property (nonatomic, retain) NSNumber * idcentroraccolta;
@property (nonatomic, retain) NSNumber * idcomune;
@property (nonatomic, retain) NSNumber * idcalendario;
@property (nonatomic, retain) NSString * centroraccolta;
@property (nonatomic, retain) NSNumber * latitudine;
@property (nonatomic, retain) NSNumber * longitudine;
@property (nonatomic, retain) NSString * descrizione;
@property (nonatomic, assign) CLLocationCoordinate2D coordinate;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *subtitle;

+(NSMutableArray*)_parseXmlDictionary:(NSDictionary *)aDictionary;

+(CentriRaccolta *)Load;
+(NSMutableArray *)RC_:(NSNumber *)IdCentroRaccolta;
+(NSMutableArray *)RC_perComune:(NSNumber *)IdComune;

+ (NSString *)UrlRequest;

@end

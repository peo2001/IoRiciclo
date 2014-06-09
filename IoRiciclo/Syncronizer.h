//
//  Syncronizer.h
//  MyWedding
//
//  Created by Maria Cristina Narcisi on 01/06/13.
//  Copyright (c) 2013 Maria Cristina Narcisi. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Connector.h"
#import "Comuni.h"
#import "Zone.h"
#import "TipiRiciclo.h"
#import "GiorniRiciclo.h"
#import "Province.h"
#import "CentriRaccolta.h"
#import "Cassonetto.h"
#import "CalendarioDetail.h"
#import "Avvisi.h"
#import "Utenti.h"
#import <CoreData/CoreData.h>
#import <CoreLocation/CoreLocation.h>

#import "MyApplicationSingleton.h"


@protocol SyncronizerDelegate <NSObject> 

- (void)startLoading;
- (void)endLoading;


@end

@interface Syncronizer : NSObject
{
     //RemoteConnector * myRemoteConnector;
   
   
}

@property (nonatomic, retain) id <SyncronizerDelegate> delegate;

+(NSMutableArray *)SyncComuni:(NSNumber *)IdProvincia;
+(NSMutableArray *)SyncComuniGeo;
+(NSMutableArray *) SyncComuniStringSearch:strSearch;

+(void)SyncProvince;
+(NSMutableArray *)SyncZone:(NSNumber *)IdComune;
+(NSMutableArray *)SyncGiorniRiciclo:(NSDate *) data;
+(NSMutableArray *)SyncTipiRiciclo;
+(NSMutableArray *)SyncCassonetti;
+(NSMutableArray *)SyncCentriRaccolta;
+(void)SyncAvvisi;
+(void)SyncComune;

+(void)SyncUtente;

+ (NSString *)UrlRequestSendUdid;

@end

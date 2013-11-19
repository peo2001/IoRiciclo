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
#import <XTM_Communication/XTM_Communication.h>

#import "MyApplicationSingleton.h"


@protocol SyncronizerDelegate <NSObject> 

- (void)startLoading;
- (void)endLoading;


@end

@interface Syncronizer : NSObject
{
     RemoteConnector * myRemoteConnector;
}

@property (nonatomic, retain) id <SyncronizerDelegate> delegate;

+(NSMutableArray *)SyncComuni:(NSNumber *)IdProvincia;
+(void)SyncProvince;
+(NSMutableArray *)SyncZone:(NSNumber *)IdComune;
+(NSMutableArray *)SyncGiorniRiciclo:(NSDate *) data;
+(NSMutableArray *)SyncTipiRiciclo;



@end

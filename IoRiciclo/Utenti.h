//
//  Utenti.h
//  IoRiciclo
//
//  Created by Maria Cristina Narcisi on 26/02/14.
//  Copyright (c) 2014 Maria Cristina Narcisi. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import "ManagedObjectBase.h"
#import <FacebookSDK/FacebookSDK.h>

@interface Utenti : ManagedObjectBase

@property (nonatomic, retain) NSNumber * idiosudid;
@property (nonatomic, retain) NSString * iosudid;
@property (nonatomic, retain) NSDate * datacreazione;
@property (nonatomic, retain) NSNumber * idcomune;
@property (nonatomic, retain) NSNumber * idzona;
@property (nonatomic, retain) NSString * nomeutente;

@property (retain, nonatomic) NSURLConnection *connection;

+ (Utenti *)Load;
+ (NSString *)UrlRequest;
+(NSMutableArray*)_parseXmlDictionary:(NSDictionary *)aDictionary;
+(NSMutableArray *)RC_;
- (BOOL)IsUserLogged;
-(void)logoff;
-(void)login : (id<FBGraphUser>)user;

@end

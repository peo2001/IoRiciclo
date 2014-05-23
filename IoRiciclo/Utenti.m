//
//  Utenti.m
//  IoRiciclo
//
//  Created by Maria Cristina Narcisi on 26/02/14.
//  Copyright (c) 2014 Maria Cristina Narcisi. All rights reserved.
//

#import "Utenti.h"


@implementation Utenti

@dynamic idiosudid;
@dynamic iosudid;
@dynamic datacreazione;
@dynamic idcomune;
@dynamic idzona;
@dynamic nomeutente;

+(Utenti *)Load
{
    return (Utenti *) [super LoadEntity:@"Utenti"];
}

+(NSMutableArray *)RC_
{
    
    [super setEntity:@"Utenti"];
    
    UIDevice *myDevice = [UIDevice currentDevice];
    NSString * deviceUDID = [[myDevice identifierForVendor]UUIDString];
    
    [self AddPredicate:  (NSPredicate *) [NSString stringWithFormat:@"1=1"]];
    [self AddPredicate:  (NSPredicate *) [NSString stringWithFormat:@"iosudid='%@'",
                                          deviceUDID]];
    return [super RC_];
    
    
}

+ (NSString *)UrlRequest
{
    
    return [NSString stringWithFormat: @"ExportZonaUtentePlist.asp"];
    
}

+(NSMutableArray*)_parseXmlDictionary:(NSDictionary *)aDictionary
{
    if (aDictionary != NULL && [aDictionary count] > 0) {
        NSArray *presents = [aDictionary objectForKey:@"utente"];
        
        if (presents != NULL)
        {
            NSMutableArray *resultArray = [[NSMutableArray alloc] init];
            for (NSDictionary *currentResult in presents)
            {
                Utenti *utente = [Utenti Load];
                utente.idiosudid = [NSNumber numberWithLong:[[currentResult objectForKey:@"idutente"] integerValue]];
                utente.idzona =[NSNumber numberWithLong:[[currentResult objectForKey:@"idzona"] integerValue]];
                utente.iosudid =[currentResult objectForKey:@"iosudid"];
                utente.idcomune =[currentResult objectForKey:@"idcomune"] ;
                [resultArray addObject:utente];
            }
            
            return resultArray;
        }
        else {
            return NULL;
        }
    }
    else {
        return NULL;
    }
}


@end

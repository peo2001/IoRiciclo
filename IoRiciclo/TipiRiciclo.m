//
//  TipiRiciclo.m
//  IoRiciclo
//
//  Created by Maria Cristina Narcisi on 07/07/13.
//  Copyright (c) 2013 Maria Cristina Narcisi. All rights reserved.
//

#import "TipiRiciclo.h"


@implementation TipiRiciclo

@dynamic codtiporiciclo;
@dynamic immagine;
@dynamic tiporiciclo;

+(TipiRiciclo *)Load
{
    return (TipiRiciclo *) [super LoadEntity:@"TipiRiciclo"];
}


+(NSMutableArray *)RC_
{
    
    [super setEntity:@"TipiRiciclo"];
    // [self AddGroupBy:[NSArray arrayWithObjects:@"codtipologiaprodotto", nil]];
    
    [self AddPredicate:  (NSPredicate *)[NSString stringWithFormat:@"1=1"]];
    
    return [super RC_];
    
    
}

+(NSMutableArray *)RC_: (NSString *) codtiporiciclo
{
    
    [super setEntity:@"TipiRiciclo"];
    // [self AddGroupBy:[NSArray arrayWithObjects:@"codtipologiaprodotto", nil]];
    
    [self AddPredicate:   (NSPredicate *)[NSString stringWithFormat:@"1=1"]];
    [self AddPredicate:   (NSPredicate *)[NSString stringWithFormat:@"codtiporiciclo='%@'",codtiporiciclo]];
    
    return [super RC_];
    
    
}

+ (NSString *)UrlRequest
{
    // return [NSString stringWithFormat:@"http://cassandra22.altervista.org/IoRiciclo/www/ExportTipiRicicloPlist.php"];
    return [NSString stringWithFormat:@"http://hq.xtremesoftware.it/IoRiciclo/ExportTipiRicicloPlist.asp"];
}

+(NSMutableArray*)_parseXmlDictionary:(NSDictionary *)aDictionary
{
    if (aDictionary != NULL && [aDictionary count] > 0) {
        NSArray *presents = [aDictionary objectForKey:@"tipiriciclo"];
        
        if (presents != NULL)
        {
            NSMutableArray *resultArray = [[NSMutableArray alloc] init];
            for (NSDictionary *currentResult in presents)
            {
                TipiRiciclo *tiporiciclo = [TipiRiciclo Load];
                // NSLog(@"IdMatrimonio:%@",[currentResult objectForKey:@"idmatrimonio"]);
                tiporiciclo.tiporiciclo = [currentResult objectForKey:@"tiporiciclo"] ;
                tiporiciclo.codtiporiciclo = [currentResult objectForKey:@"codtiporiciclo"]  ;
                tiporiciclo.immagine = [currentResult objectForKey:@"immagine"];
                
                [resultArray addObject:tiporiciclo];
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

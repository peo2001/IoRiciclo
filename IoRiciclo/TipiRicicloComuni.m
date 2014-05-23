//
//  TipiRicicloComuni.m
//  IoRiciclo
//
//  Created by Maria Cristina Narcisi on 05/09/13.
//  Copyright (c) 2013 Maria Cristina Narcisi. All rights reserved.
//

#import "TipiRicicloComuni.h"


@implementation TipiRicicloComuni

@dynamic idtiporiciclocomune;
@dynamic idcomune;
@dynamic codtiporiciclo;
@dynamic descrizione;






+(TipiRicicloComuni *)Load
{
    return (TipiRicicloComuni *) [super LoadEntity:@"TipiRicicloComuni"];
}


+(NSMutableArray *)RC_
{
    
    [super setEntity:@"TipiRicicloComuni"];
    // [self AddGroupBy:[NSArray arrayWithObjects:@"codtipologiaprodotto", nil]];
    
    [self AddPredicate: (NSPredicate *) [NSString stringWithFormat:@"1=1"]];
    
    return [super RC_];
    
    
}

+(NSFetchedResultsController *)RC_Fetch
{
    
    [super setEntity:@"TipiRicicloComuni"];
    // [self AddGroupBy:[NSArray arrayWithObjects:@"codtipologiaprodotto", nil]];
    //[self AddPredicate:  [NSString stringWithFormat:@"1=1"]];
    
    return [super RC_Fetch:@"idcomune"];
    
    
}

+(NSMutableArray *)RC_:(NSNumber *)IdComune
{
    
    [super setEntity:@"TipiRicicloComuni"];
    
    [self AddPredicate: (NSPredicate *)[NSString stringWithFormat:@"1=1"]];
    [self AddPredicate: (NSPredicate *)[NSString stringWithFormat:@"idcomune=%@",
                          IdComune]];
    return [super RC_];
    
    
}


+ (NSString *)UrlRequest
{
    
    return [NSString stringWithFormat:@"http://hq.xtremesoftware.it/IoRiciclo/ExportTipiRicicloComuniPlist.asp"];
}

+(NSMutableArray*)_parseXmlDictionary:(NSDictionary *)aDictionary
{
    if (aDictionary != NULL && [aDictionary count] > 0) {
        NSArray *presents = [aDictionary objectForKey:@"province"];
        
        if (presents != NULL)
        {
            NSMutableArray *resultArray = [[NSMutableArray alloc] init];
            for (NSDictionary *currentResult in presents)
            {
                TipiRicicloComuni *tiporiciclocomune = [TipiRicicloComuni Load];
                // NSLog(@"IdMatrimonio:%@",[currentResult objectForKey:@"idmatrimonio"]);
                tiporiciclocomune.idcomune = [NSNumber numberWithLong:[[currentResult objectForKey:@"idcomune"] integerValue]];
                tiporiciclocomune.idtiporiciclocomune =[NSNumber numberWithLong:[[currentResult objectForKey:@"idtiporiciclocomune"] integerValue]];
                tiporiciclocomune.codtiporiciclo =[currentResult objectForKey:@"codtiporiciclo"] ;
                tiporiciclocomune.descrizione =[currentResult objectForKey:@"descrizione"] ;
                
                
                [resultArray addObject:tiporiciclocomune];
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

//
//  Province.m
//  IoRiciclo
//
//  Created by Maria Cristina Narcisi on 30/08/13.
//  Copyright (c) 2013 Maria Cristina Narcisi. All rights reserved.
//

#import "Province.h"


@implementation Province

@dynamic idprovincia;
@dynamic idregione;
@dynamic regione;
@dynamic provincia;




+(Province *)Load
{
    return (Province *) [super LoadEntity:@"Province"];
}


+(NSMutableArray *)RC_
{
    
    [super setEntity:@"Province"];
    // [self AddGroupBy:[NSArray arrayWithObjects:@"codtipologiaprodotto", nil]];
    
    [self AddPredicate:   (NSPredicate *)[NSString stringWithFormat:@"1=1"]];
    
    return [super RC_];
    
    
}

+(NSFetchedResultsController *)RC_Fetch
{
    
    [super setEntity:@"Province"];
    // [self AddGroupBy:[NSArray arrayWithObjects:@"codtipologiaprodotto", nil]];
    //[self AddPredicate:  [NSString stringWithFormat:@"1=1"]];
    
    return [super RC_Fetch:@"regione"];
    
    
}

+(NSMutableArray *)RC_:(NSNumber *)IdRegione
{
    
    [super setEntity:@"Province"];
    
    [self AddPredicate:   (NSPredicate *)[NSString stringWithFormat:@"1=1"]];
    [self AddPredicate:   (NSPredicate *)[NSString stringWithFormat:@"idregione=%@",
                          IdRegione]];
    return [super RC_];
    
    
}


+ (NSString *)UrlRequest
{
    
    return [NSString stringWithFormat:@"ExportProvincePlist.asp"];
    
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
                Province *provincia = [Province Load];
                provincia.idprovincia = [NSNumber numberWithLong:[[currentResult objectForKey:@"idprovincia"] integerValue]];
                provincia.idregione =[NSNumber numberWithLong:[[currentResult objectForKey:@"idregione"] integerValue]];
                provincia.provincia =[currentResult objectForKey:@"provincia"] ;
                provincia.regione =[currentResult objectForKey:@"regione"] ;
                
                
                [resultArray addObject:provincia];
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

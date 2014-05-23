//
//  Avvisi.m
//  IoRiciclo
//
//  Created by Maria Cristina Narcisi on 19/11/13.
//  Copyright (c) 2013 Maria Cristina Narcisi. All rights reserved.
//

#import "Avvisi.h"


@implementation Avvisi

@dynamic idavviso;
@dynamic idcomune;
@dynamic titolo;
@dynamic descrizione;
@dynamic datacreazione;
@dynamic letto;



+(Avvisi *)Load
{
    return (Avvisi *) [super LoadEntity:@"Avvisi"];
}


+(NSMutableArray *)RC_:(NSNumber *)IdComune
{
    
    [super setEntity:@"Avvisi"];
    // [self AddGroupBy:[NSArray arrayWithObjects:@"codtipologiaprodotto", nil]];
    
    [self AddPredicate:  (NSPredicate *)[NSString stringWithFormat:@"1=1"]];
    [self AddPredicate:  (NSPredicate *)[NSString stringWithFormat:@"idcomune=%@",
                                         IdComune]];
   // [self AddSortDescription:@"idprovincia"];
    return [super RC_];
    
    
}

+(NSFetchedResultsController *)RC_Fetch:(NSNumber *)IdComune :(NSString *)Sort
{
    
    [super setEntity:@"Avvisi"];
    [self AddPredicate:  (NSPredicate *) [NSString stringWithFormat:@"idcomune=%@",
                                          IdComune]];
    return [super RC_Fetch:Sort];
    
    
}



+ (NSString *)UrlRequest
{
    
    return [NSString stringWithFormat: @"ExportAvvisiPlist.asp"];
    
}

+(NSMutableArray*)_parseXmlDictionary:(NSDictionary *)aDictionary
{
    if (aDictionary != NULL && [aDictionary count] > 0) {
        NSArray *presents = [aDictionary objectForKey:@"avvisi"];
        
        if (presents != NULL)
        {
            NSMutableArray *resultArray = [[NSMutableArray alloc] init];
            for (NSDictionary *currentResult in presents)
            {
                Avvisi *avviso = [Avvisi Load];
                avviso.idavviso = [NSNumber numberWithLong:[[currentResult objectForKey:@"idav"] integerValue]];
                avviso.idcomune = [NSNumber numberWithLong:[[currentResult objectForKey:@"idcom"] integerValue]];
                
                avviso.titolo =[currentResult objectForKey:@"tit"] ;
                avviso.descrizione =[currentResult objectForKey:@"desc"] ;
                avviso.datacreazione =[currentResult objectForKey:@"datc"] ;

                [resultArray addObject:avviso];
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

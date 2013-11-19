//
//  Comuni.m
//  IoRciclo
//
//  Created by Maria Cristina Narcisi on 30/08/13.
//  Copyright (c) 2013 Maria Cristina Narcisi. All rights reserved.
//

#import "Comuni.h"


@implementation Comuni

@dynamic comune;
@dynamic idcomune;
@dynamic idprovincia;





+(Comuni *)Load
{
    return (Comuni *) [super LoadEntity:@"Comuni"];
}


+(NSMutableArray *)RC_perProv:(NSNumber *)Idprovincia
{
    
    [super setEntity:@"Comuni"];
    // [self AddGroupBy:[NSArray arrayWithObjects:@"codtipologiaprodotto", nil]];
    
    [self AddPredicate:  (NSPredicate *)[NSString stringWithFormat:@"1=1"]];
    [self AddPredicate:  (NSPredicate *)[NSString stringWithFormat:@"idprovincia=%@",
                          Idprovincia]];
    [self AddSortDescription:@"idprovincia"];
    return [super RC_];
    
    
}

+(NSFetchedResultsController *)RC_Fetch:(NSNumber *)Idprovincia :(NSString *)Sort
{
    
    [super setEntity:@"Comuni"];
    [self AddPredicate:  (NSPredicate *) [NSString stringWithFormat:@"idprovincia=%@",
                          Idprovincia]];
    return [super RC_Fetch:Sort];
    
    
}

+(NSMutableArray *)RC_:(NSNumber *)IdComune
{
    
    [super setEntity:@"Comuni"];
    
    [self AddPredicate:  (NSPredicate *) [NSString stringWithFormat:@"1=1"]];
    [self AddPredicate:  (NSPredicate *) [NSString stringWithFormat:@"idprovincia=%@",
                          IdComune]];
    return [super RC_];
    
    
}
+(NSMutableArray *)RC_Comune:(NSNumber *)IdComune
{
    
    [super setEntity:@"Comuni"];
    
    [self AddPredicate:   (NSPredicate *)[NSString stringWithFormat:@"1=1"]];
    [self AddPredicate:   (NSPredicate *)[NSString stringWithFormat:@"idcomune=%@",
                          IdComune]];
    return [super RC_];
    
    
}


+ (NSString *)UrlRequest
{
    
    return [NSString stringWithFormat: @"ExportComuniPlist.asp"];
    
}

+(NSMutableArray*)_parseXmlDictionary:(NSDictionary *)aDictionary
{
    if (aDictionary != NULL && [aDictionary count] > 0) {
        NSArray *presents = [aDictionary objectForKey:@"comuni"];
        
        if (presents != NULL)
        {
            NSMutableArray *resultArray = [[NSMutableArray alloc] init];
            for (NSDictionary *currentResult in presents)
            {
                Comuni *comune = [Comuni Load];
                comune.idcomune = [NSNumber numberWithInt:[[currentResult objectForKey:@"idcomune"] integerValue]];
                comune.idprovincia =[NSNumber numberWithInt:[[currentResult objectForKey:@"idprovincia"] integerValue]];
                comune.comune =[currentResult objectForKey:@"comune"] ;
                
                [resultArray addObject:comune];
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

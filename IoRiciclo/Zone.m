//
//  Zone.m
//  IoRiciclo
//
//  Created by Maria Cristina Narcisi on 07/07/13.
//  Copyright (c) 2013 Maria Cristina Narcisi. All rights reserved.
//

#import "Zone.h"


@implementation Zone

@dynamic idzona;
@dynamic idcomune;
@dynamic zona;



+(Zone *)Load
{
    return (Zone *) [super LoadEntity:@"Zone"];
}


+(NSMutableArray *)RC_:(NSNumber *)IdZona
{
    
    [super setEntity:@"Zone"];
    // [self AddGroupBy:[NSArray arrayWithObjects:@"codtipologiaprodotto", nil]];
    
    [self AddPredicate:   (NSPredicate *)[NSString stringWithFormat:@"1=1"]];
    [self AddPredicate:   (NSPredicate *)[NSString stringWithFormat:@"idzona=%@",
                          IdZona]];
    
    
    return [super RC_];
    
    
}

+(NSMutableArray *)RC_perComune:(NSNumber *)IdComune
{
    
    [super setEntity:@"Zone"];
    // [self AddGroupBy:[NSArray arrayWithObjects:@"codtipologiaprodotto", nil]];
    
    [self AddPredicate:   (NSPredicate *)[NSString stringWithFormat:@"1=1"]];
    // NSLog(@"id :%@",IdComune);
    [self AddPredicate:  (NSPredicate *) [NSString stringWithFormat:@"idcomune=%@",
                          IdComune]];
    [self AddSortDescription: @"zona"];
    return [super RC_];
    
    
}
+ (NSString *)UrlRequest
{
    return [NSString stringWithFormat:@"ExportZonePlist.asp?IdComune="];
    
}
+(NSMutableArray*)_parseXmlDictionary:(NSDictionary *)aDictionary
{
    if (aDictionary != NULL && [aDictionary count] > 0) {
        NSArray *presents = [aDictionary objectForKey:@"zone"];
        
        if (presents != NULL)
        {
            NSMutableArray *resultArray = [[NSMutableArray alloc] init];
            for (NSDictionary *currentResult in presents)
            {
                Zone *zona = [Zone Load];
                // NSLog(@"IdMatrimonio:%@",[currentResult objectForKey:@"idmatrimonio"]);
                zona.idzona = [NSNumber numberWithLong:[[currentResult objectForKey:@"idzona"] integerValue]] ;
                zona.idcomune = [NSNumber numberWithLong:[[currentResult objectForKey:@"idcomune"] integerValue]] ;
                zona.zona = [currentResult objectForKey:@"zona"];
                
                [resultArray addObject:zona];
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

//
//  Cassonetto.m
//  IoRiciclo
//
//  Created by Maria Cristina Narcisi on 15/11/13.
//  Copyright (c) 2013 Maria Cristina Narcisi. All rights reserved.
//

#import "Cassonetto.h"


@implementation Cassonetto

@dynamic idcassonetto;
@dynamic idcomune;
@dynamic idcalendario;
@dynamic codtipologiarifiuto;
@dynamic latitudine;
@dynamic longitudine;
@dynamic descrizione;
@dynamic tipologiarifiuto;
@synthesize coordinate;

@synthesize title;
@synthesize subtitle;


+(Cassonetto *)Load
{
    return (Cassonetto *) [super LoadEntity:@"Cassonetto"];
}

+(NSMutableArray *)RC_
{
    
    [super setEntity:@"Cassonetto"];
    // [self AddGroupBy:[NSArray arrayWithObjects:@"codtipologiaprodotto", nil]];
    
    [self AddPredicate:   (NSPredicate *)[NSString stringWithFormat:@"1=1"]];
    
    return [super RC_];
    
    
}

+(NSMutableArray *)RC_:(NSNumber *)IdCassonetto
{
    
    [super setEntity:@"Cassonetto"];
    // [self AddGroupBy:[NSArray arrayWithObjects:@"codtipologiaprodotto", nil]];
    
    [self AddPredicate:   (NSPredicate *)[NSString stringWithFormat:@"1=1"]];
    [self AddPredicate:   (NSPredicate *)[NSString stringWithFormat:@"idcassonetto=%@",
                                          IdCassonetto]];
    
    
    return [super RC_];
    
    
}

+(NSMutableArray *)RC_perComune:(NSNumber *)IdComune
{
    
    [super setEntity:@"Cassonetto"];
    // [self AddGroupBy:[NSArray arrayWithObjects:@"codtipologiaprodotto", nil]];
    
    [self AddPredicate:   (NSPredicate *)[NSString stringWithFormat:@"1=1"]];
    // NSLog(@"id :%@",IdComune);
    [self AddPredicate:  (NSPredicate *) [NSString stringWithFormat:@"idcomune=%@",
                                          IdComune]];
    
    return [super RC_];
    
    
}
+ (NSString *)UrlRequest
{
    return [NSString stringWithFormat:@"ExportCassonettiPlist.asp"];
    
}
+(NSMutableArray*)_parseXmlDictionary:(NSDictionary *)aDictionary
{
    if (aDictionary != NULL && [aDictionary count] > 0) {
        NSArray *presents = [aDictionary objectForKey:@"cassonetti"];
        
        if (presents != NULL)
        {
            NSMutableArray *resultArray = [[NSMutableArray alloc] init];
            for (NSDictionary *currentResult in presents)
            {
                Cassonetto *cassonetto = [Cassonetto Load];
                // NSLog(@"IdMatrimonio:%@",[currentResult objectForKey:@"idmatrimonio"]);
                cassonetto.idcassonetto = [NSNumber numberWithLong:[[currentResult objectForKey:@"idcas"] integerValue]] ;
                cassonetto.idcomune = [NSNumber numberWithLong:[[currentResult objectForKey:@"idcom"] integerValue]] ;
                cassonetto.idcalendario = [NSNumber numberWithLong:[[currentResult objectForKey:@"idcal"] integerValue]] ;
               
                cassonetto.codtipologiarifiuto = [currentResult objectForKey:@"ctr"] ;
                cassonetto.tipologiarifiuto = [currentResult objectForKey:@"tir"] ;
                
                cassonetto.descrizione = [currentResult objectForKey:@"desc"] ;
                
                CLLocationDegrees latitude = [[[currentResult objectForKey:@"coordinate"] objectForKey:@"lat"] floatValue];
                CLLocationDegrees longitude = [[[currentResult objectForKey:@"coordinate"] objectForKey:@"lon"] floatValue];
                CLLocationCoordinate2D location;
                location.latitude = latitude;
                location.longitude = longitude;
                
                cassonetto.coordinate = location;

                cassonetto.latitudine = [[currentResult objectForKey:@"coordinate"] objectForKey:@"lat"] ;
                cassonetto.longitudine = [[currentResult objectForKey:@"coordinate"] objectForKey:@"lon"] ;
                [resultArray addObject:cassonetto];
                [CalendarioDetail _parseXmlDictionary:[currentResult objectForKey:@"calritiro"] : cassonetto.idcalendario ];
                
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

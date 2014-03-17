//
//  CentriRaccolta.m
//  IoRiciclo
//
//  Created by Maria Cristina Narcisi on 15/11/13.
//  Copyright (c) 2013 Maria Cristina Narcisi. All rights reserved.
//

#import "CentriRaccolta.h"


@implementation CentriRaccolta

@dynamic idcentroraccolta;
@dynamic idcomune;
@dynamic idcalendario;
@dynamic centroraccolta;
@dynamic latitudine;
@dynamic longitudine;
@dynamic descrizione;
@synthesize coordinate;
@synthesize title;
@synthesize subtitle;


+(CentriRaccolta *)Load
{
    return (CentriRaccolta *) [super LoadEntity:@"CentriRaccolta"];
}


+(NSMutableArray *)RC_:(NSNumber *)IdCentroRccolta
{
    
    [super setEntity:@"CentriRaccolta"];
    // [self AddGroupBy:[NSArray arrayWithObjects:@"codtipologiaprodotto", nil]];
    
    [self AddPredicate:   (NSPredicate *)[NSString stringWithFormat:@"1=1"]];
    [self AddPredicate:   (NSPredicate *)[NSString stringWithFormat:@"IdCentroRccolta=%@",
                                          IdCentroRccolta]];
    
    
    return [super RC_];
    
    
}

+(NSMutableArray *)RC_perComune:(NSNumber *)IdComune
{
    
    [super setEntity:@"CentriRaccolta"];
    // [self AddGroupBy:[NSArray arrayWithObjects:@"codtipologiaprodotto", nil]];
    
    [self AddPredicate:   (NSPredicate *)[NSString stringWithFormat:@"1=1"]];
    // NSLog(@"id :%@",IdComune);
    [self AddPredicate:  (NSPredicate *) [NSString stringWithFormat:@"idcomune=%@",
                                          IdComune]];
    
    return [super RC_];
    
    
}
+ (NSString *)UrlRequest
{
    return [NSString stringWithFormat:@"ExportCentriRaccoltaPlist.asp"];
    
}
+(NSMutableArray*)_parseXmlDictionary:(NSDictionary *)aDictionary
{
    if (aDictionary != NULL && [aDictionary count] > 0) {
        NSArray *presents = [aDictionary objectForKey:@"centriraccolta"];
        
        if (presents != NULL)
        {
            NSMutableArray *resultArray = [[NSMutableArray alloc] init];
            for (NSDictionary *currentResult in presents)
            {
                CentriRaccolta *centroraccolta = [CentriRaccolta Load];
                // NSLog(@"IdMatrimonio:%@",[currentResult objectForKey:@"idmatrimonio"]);
                centroraccolta.idcentroraccolta = [NSNumber numberWithInt:[[currentResult objectForKey:@"idcen"] integerValue]] ;
                centroraccolta.idcomune = [NSNumber numberWithInt:[[currentResult objectForKey:@"idcom"] integerValue]] ;
                centroraccolta.idcalendario = [NSNumber numberWithInt:[[currentResult objectForKey:@"idcal"] integerValue]] ;
                
                CLLocationDegrees latitude = [[[currentResult objectForKey:@"coordinate"] objectForKey:@"lat"] floatValue];
                CLLocationDegrees longitude = [[[currentResult objectForKey:@"coordinate"] objectForKey:@"lon"] floatValue];
                CLLocationCoordinate2D location;
                location.latitude = latitude;
                location.longitude = longitude;
                
                centroraccolta.coordinate = location;
                
                centroraccolta.latitudine = [[currentResult objectForKey:@"coordinate"] objectForKey:@"lat"] ;
                centroraccolta.longitudine = [[currentResult objectForKey:@"coordinate"] objectForKey:@"lon"] ;
                
                centroraccolta.centroraccolta = [currentResult objectForKey:@"cc"] ;
                centroraccolta.descrizione = [currentResult objectForKey:@"desc"] ;
                
                [resultArray addObject:centroraccolta];
                [CalendarioDetail _parseXmlDictionary:[currentResult objectForKey:@"calritiro"] : centroraccolta.idcalendario ];
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

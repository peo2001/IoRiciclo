//
//  GiorniRiciclo.m
//  IoRciclo
//
//  Created by Maria Cristina Narcisi on 07/09/13.
//  Copyright (c) 2013 Maria Cristina Narcisi. All rights reserved.
//

#import "GiorniRiciclo.h"


@implementation GiorniRiciclo

@dynamic codtiporiciclo;
@dynamic datagiorno;
@dynamic ora;
@dynamic idcomune;
@dynamic idgiornoriciclo;
@dynamic idzona;
@dynamic descrizione;
@dynamic immagine;
@dynamic descrizionepercomune;
@dynamic immaginepercomune;
@dynamic tiporiciclo;
@dynamic colore;




+(GiorniRiciclo *)Load
{
    return (GiorniRiciclo *) [super LoadEntity:@"GiorniRiciclo"];
}


+(NSMutableArray *)RC_
{
    
    [super setEntity:@"GiorniRiciclo"];
    // [self AddGroupBy:[NSArray arrayWithObjects:@"codtipologiaprodotto", nil]];
    
    [self AddPredicate:  (NSPredicate *)[NSString stringWithFormat:@"1=1"]];
    
    return [super RC_];
    
    
}

/*
-(NSDate *)DataMezzanotte:(NSDate*)Data
{
    
    NSCalendar *calendar = [NSCalendar currentCalendar]; // gets default calendar
    NSDateComponents *components = [calendar components:(NSYearCalendarUnit | NSMonthCalendarUnit |  NSDayCalendarUnit | NSHourCalendarUnit | NSMinuteCalendarUnit) fromDate:Data]; // gets the year, month, day,hour and minutesfor today's date
    
    NSDateComponents *componentsHour = [calendar components:(NSYearCalendarUnit | NSMonthCalendarUnit |  NSDayCalendarUnit | NSHourCalendarUnit | NSMinuteCalendarUnit) fromDate:Data];
    [componentsHour setTimeZone:[NSTimeZone systemTimeZone]];
    
    
    [components setHour:[componentsHour hour]];
    [components setMinute:[componentsHour minute]];
    
    NSLog(@"mezzanotte data %@",[calendar dateFromComponents:components]);
    
    
    return [calendar dateFromComponents:components];
    
}
 */

+(NSMutableArray *)RC_:(NSNumber *)IdComune :(NSNumber *)IdZona :(NSDate *)dataDa :(NSDate *)dataA
{
    
    [super setEntity:@"GiorniRiciclo"];
    
    // NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    //[dateFormat setDateFormat:@"yyyy-MM-dd HH:mm:ss +0000"];
    
    // NSLog (@"%@",[NSString stringWithFormat:@"(datagiorno BETWEEN %@)  AND (idcomune=%@) AND (idzona=%@)",[NSArray arrayWithObjects:[dateFormat stringFromDate:[self dataInizioGiorno: data]], [dateFormat stringFromDate:[self dataFineGiorno :data]], nil],IdComune ,IdZona]);
    
    //OK
    
    /*
     [[[CoreDataMethods getInstance]req]setPredicate:[NSPredicate predicateWithFormat:@"(datagiorno >%@) AND (datagiorno <%@)  AND (idcomune=%@) AND (idzona=%@)",[data dateByAddingTimeInterval: -86400.0] ,[data dateByAddingTimeInterval: 86400.0],IdComune ,IdZona] ];
     */
    
    //NSLog(@"data RC_ %@",data);
    
    [[[CoreDataMethods getInstance]req]setPredicate:[NSPredicate predicateWithFormat:@"(datagiorno >= %@) AND (datagiorno  < %@)  AND (idcomune=%@) AND (idzona=%@)", dataDa,dataA,IdComune ,IdZona]];
    
    
    /*  [[[CoreDataMethods getInstance]req]setPredicate:[NSPredicate predicateWithFormat:@"(datagiorno BETWEEN %@)  AND (idcomune=%@) AND (idzona=%@)",[NSArray arrayWithObjects:[dateFormat stringFromDate:[self dataInizioGiorno: data]], [dateFormat stringFromDate:[self dataFineGiorno :data]], nil],IdComune ,IdZona] ];
     */
    
    /* [[[CoreDataMethods getInstance]req]setPredicate:[NSPredicate predicateWithFormat:@"(datagiorno >=%@) AND (datagiorno <%@) ",[self dateWithNoTime: data], [[self dateWithNoTime: data] dateByAddingTimeInterval: 86400.0]]];
     
     NSLog (@"(datagiorno >=%@) AND (datagiorno <=%@) ",[self dateWithNoTime: data], [[self dateWithNoTime: data] dateByAddingTimeInterval: 86400.0] );
     */
    
    
    [self AddSortDescription:@"datagiorno"];
    
    return [super RC_];
    
}



+ (NSString *)UrlRequest
{
    return [NSString stringWithFormat:@"ExportGiorniRicicloPlist.asp"];
}

+(NSMutableArray*)_parseXmlDictionary:(NSDictionary *)aDictionary
{
    
    
    if (aDictionary != NULL && [aDictionary count] > 0) {
        NSArray *presents = [aDictionary objectForKey:@"giorniriciclo"];
        
        if (presents != NULL)
        {
            NSMutableArray *resultArray = [[NSMutableArray alloc] init];
            for (NSDictionary *currentResult in presents)
            {
                GiorniRiciclo *giornoriciclo = [GiorniRiciclo Load];
                // NSLog(@"IdMatrimonio:%@",[currentResult objectForKey:@"idmatrimonio"]);
                giornoriciclo.idcomune = [NSNumber numberWithInt:[[currentResult objectForKey:@"idcomune"] integerValue]];
                giornoriciclo.codtiporiciclo = [currentResult objectForKey:@"codtiporiciclo"] ;
                giornoriciclo.tiporiciclo = [currentResult objectForKey:@"tiporiciclo"] ;
                giornoriciclo.immagine = [currentResult objectForKey:@"immagine"] ;
                giornoriciclo.idzona = [NSNumber numberWithInt:[[currentResult objectForKey:@"idzona"] integerValue]];
                giornoriciclo.datagiorno = [currentResult objectForKey:@"data"];
                //NSLog(@"giornoriciclo.datagiorno:%@",[currentResult objectForKey:@"data"]);
                giornoriciclo.ora = [currentResult objectForKey:@"ora"];
                giornoriciclo.colore = [currentResult objectForKey:@"colore"] ;
                
                giornoriciclo.descrizione = [currentResult objectForKey:@"descrizione"] ;
                giornoriciclo.descrizionepercomune = [currentResult objectForKey:@"descrizionepercomune"] ;
                giornoriciclo.immaginepercomune = [currentResult objectForKey:@"immaginepercomune"] ;
                
                [resultArray addObject:giornoriciclo];
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

//
//  CalendarioDetail.m
//  IoRiciclo
//
//  Created by Maria Cristina Narcisi on 18/11/13.
//  Copyright (c) 2013 Maria Cristina Narcisi. All rights reserved.
//

#import "CalendarioDetail.h"


@implementation CalendarioDetail

@dynamic idcalendariodetail;
@dynamic idcalendario;
@dynamic data;
@dynamic ora;




+(CalendarioDetail *)Load
{
    return (CalendarioDetail *) [super LoadEntity:@"CalendarioDetail"];
}


+(NSMutableArray *)RC_
{
    
    [super setEntity:@"CalendarioDetail"];
    // [self AddGroupBy:[NSArray arrayWithObjects:@"codtipologiaprodotto", nil]];
    
    [self AddPredicate:   (NSPredicate *)[NSString stringWithFormat:@"1=1"]];
    
    return [super RC_];
    
    
}

+(NSFetchedResultsController *)RC_Fetch
{
    
    [super setEntity:@"CalendarioDetail"];
    // [self AddGroupBy:[NSArray arrayWithObjects:@"codtipologiaprodotto", nil]];
    //[self AddPredicate:  [NSString stringWithFormat:@"1=1"]];
    
    return [super RC_Fetch:@""];
    
    
}

+(NSMutableArray *)RC_:(NSNumber *)IdCalendario
{
    
    [super setEntity:@"CalendarioDetail"];
    
    [self AddPredicate:   (NSPredicate *)[NSString stringWithFormat:@"1=1"]];
    [self AddPredicate:   (NSPredicate *)[NSString stringWithFormat:@"idcalendario=%@",
                                          IdCalendario]];
    return [super RC_];
    
    
}

/*
+ (NSString *)UrlRequest
{
    
    return [NSString stringWithFormat:@"ExportProvincePlist.asp"];
    
}

 */

+(NSMutableArray*)_parseXmlDictionary:(NSDictionary *)aDictionary : (NSNumber *)IdCalendario
{
    if (aDictionary != NULL && [aDictionary count] > 0) {
        NSMutableArray * calendario;
        calendario =nil;
        
        calendario=[CalendarioDetail RC_ :IdCalendario];
               for(CalendarioDetail *cal in calendario )
        {
            //elimino i luogh vecchi
            [CalendarioDetail Delete: cal];
            
        }

        
        NSMutableArray *resultArray = [[NSMutableArray alloc] init];
            for (NSDictionary *currentResult in aDictionary)
            {
                CalendarioDetail *cal = [CalendarioDetail Load];
                cal.idcalendariodetail = [NSNumber numberWithLong:[[currentResult objectForKey:@"idcd"] integerValue]];
                cal.idcalendario =[NSNumber numberWithLong:[[currentResult objectForKey:@"idcal"] integerValue]];
                cal.data =[currentResult objectForKey:@"dat"] ;
                
                [resultArray addObject:cal];
            }
            
            return resultArray;
        }
        else {
            return NULL;
        }
   /* }
    else {
        return NULL;
    }
    */
}




@end

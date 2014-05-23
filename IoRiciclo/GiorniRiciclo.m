//
//  GiorniRiciclo.m
//  IoRiciclo
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
@dynamic durata;





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


+(NSMutableArray *)RC_:(NSNumber *)IdComune :(NSNumber *)IdZona :(NSDate *)dataDa :(NSDate *)dataA
{
    
    [super setEntity:@"GiorniRiciclo"];
    
    
    [[[CoreDataMethods getInstance]req]setPredicate:[NSPredicate predicateWithFormat:@"(datagiorno >= %@) AND (datagiorno  < %@)  AND (idcomune=%@) AND (idzona=%@)", dataDa,dataA,IdComune ,IdZona]];
    
  
    [self AddSortDescription:@"datagiorno"];
    
    return [super RC_];
    
}



+ (NSString *)UrlRequest
{
    return [NSString stringWithFormat:@"ExportGiorniRicicloPlist.asp"];
}

-(NSDate *)datagiornofine
{
    
    
    NSDateComponents *offset = [[[NSDateComponents alloc] init] autorelease];
    [offset setMinute:[self.durata integerValue]];
   // NSLog(@"durata %d data %@",[self.durata integerValue], self.datagiorno);
    NSDate *newDate = [[NSCalendar currentCalendar] dateByAddingComponents:offset toDate:self.datagiorno options:0];
    //NSLog(@" data nuova %@",newDate);

    return newDate;
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
                giornoriciclo.idcomune = [NSNumber numberWithLong:[[currentResult objectForKey:@"idcomune"] integerValue]];
                giornoriciclo.codtiporiciclo = [currentResult objectForKey:@"codtiporiciclo"] ;
                giornoriciclo.tiporiciclo = [currentResult objectForKey:@"tiporiciclo"] ;
                giornoriciclo.immagine = [currentResult objectForKey:@"immagine"] ;
                giornoriciclo.idzona = [NSNumber numberWithLong:[[currentResult objectForKey:@"idzona"] integerValue]];
                giornoriciclo.datagiorno = [currentResult objectForKey:@"data"];
                //NSLog(@"giornoriciclo.datagiorno:%@",[currentResult objectForKey:@"data"]);
                giornoriciclo.ora = [currentResult objectForKey:@"ora"];
                giornoriciclo.colore = [currentResult objectForKey:@"colore"] ;
                
                giornoriciclo.descrizione = [currentResult objectForKey:@"descrizione"] ;
                giornoriciclo.descrizionepercomune = [currentResult objectForKey:@"descrizionepercomune"] ;
                giornoriciclo.immaginepercomune = [currentResult objectForKey:@"immaginepercomune"] ;
                giornoriciclo.durata = [NSNumber numberWithLong:[[currentResult objectForKey:@"durata"] integerValue]];
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

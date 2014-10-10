//
//  Comuni.m
//  IoRiciclo
//
//  Created by Maria Cristina Narcisi on 30/08/13.
//  Copyright (c) 2013 Maria Cristina Narcisi. All rights reserved.
//

#import "Comuni.h"


@implementation Comuni

@dynamic comune;
@dynamic idcomune;
@dynamic idprovincia;
@dynamic cap;
@dynamic codiceIstat;
@dynamic provincia;
@dynamic email;
@dynamic emailAmbiente;
@dynamic logo;
@dynamic latitudine;
@dynamic longitudine;
@dynamic regione;
@dynamic url;
@dynamic urlZone;
@dynamic numeroAbitanti;
@dynamic idGestore;
@dynamic nomeGestore;
@dynamic userGestore;
@dynamic urlGestore;
@dynamic gestByComune;

@synthesize coordinate;

-(BOOL)HasUrlZone
{
    return !([self.urlZone  isEqual:@""]|| (self.urlZone==nil));
}

-(BOOL)IsGestorePrivato
{
    return false;
}


+(Comuni *)Load
{
    return (Comuni *) [super LoadEntity:@"Comuni"];
}

+(NSMutableArray *)RC_
{
    
    [super setEntity:@"Comuni"];
    
    [self AddPredicate:   (NSPredicate *)[NSString stringWithFormat:@"1=1"]];
    
    return [super RC_sort:@"comune"];
   
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


+ (NSString *)UrlRequestSingoloComune
{
    
    return [NSString stringWithFormat: @"ExportComunePlist.asp"];
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
                comune.idcomune = [NSNumber numberWithLong:[[currentResult objectForKey:@"idcomune"] integerValue]];
                comune.idprovincia =[NSNumber numberWithLong:[[currentResult objectForKey:@"idprovincia"] integerValue]];
                
                comune.comune =[currentResult objectForKey:@"comune"] ;
                comune.urlZone=[currentResult objectForKey:@"urlzone"] ;
                comune.gestByComune =[currentResult objectForKey:@"gestByComune"] ;
                comune.idGestore =[NSNumber numberWithLong:[[currentResult objectForKey:@"idgestore"] integerValue]];
                
                comune.userGestore =[currentResult objectForKey:@"usernamecliente"];
                comune.nomeGestore =[currentResult objectForKey:@"nominativocliente"];
                comune.urlGestore =[currentResult objectForKey:@"socialcliente"];
                
              /*  Comuni *comune = [Comuni Load];
                comune.idcomune = [NSNumber numberWithInt:[[currentResult objectForKey:@"idcom"] integerValue]];
                comune.idprovincia =[NSNumber numberWithInt:[[currentResult objectForKey:@"idprov"] integerValue]];
                
                comune.comune =[currentResult objectForKey:@"comune"] ;
                comune.provincia =[currentResult objectForKey:@"prov"] ;
                comune.logo =[currentResult objectForKey:@"logo"] ;
                comune.email=[currentResult objectForKey:@"email"] ;
                comune.emailAmbiente=[currentResult objectForKey:@"emailAmb"];
                
                comune.cap=[NSNumber numberWithInt:[[currentResult objectForKey:@"cap"] integerValue]];
                comune.codiceIstat=[currentResult objectForKey:@"cIstat"] ;
                comune.latitudine=[[currentResult objectForKey:@"coordinate"] objectForKey:@"lat"] ;
                comune.longitudine=[[currentResult objectForKey:@"coordinate"] objectForKey:@"lon"] ;
                comune.regione=[currentResult objectForKey:@"sprov"] ;
                comune.url=[currentResult objectForKey:@"url"] ;
                comune.urlZone=[currentResult objectForKey:@"urlzone"] ;
                comune.numeroAbitanti=0;
                comune.numeroAbitanti=[NSNumber numberWithInteger:[[currentResult objectForKey:@"numAb"] integerValue] ];
                NSLog(@"%@",comune.numeroAbitanti);
                
                CLLocationDegrees latitude = [[[currentResult objectForKey:@"coordinate"] objectForKey:@"lat"] floatValue];
                CLLocationDegrees longitude = [[[currentResult objectForKey:@"coordinate"] objectForKey:@"lon"] floatValue];
                CLLocationCoordinate2D location;
                location.latitude = latitude;
                location.longitude = longitude;
                
                comune.coordinate = location;
                */
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

+(NSMutableArray*)_parseXmlDictionarySingleComune:(NSDictionary *)aDictionary
{
    if (aDictionary != NULL && [aDictionary count] > 0) {
        NSArray *presents = [aDictionary objectForKey:@"comune"];
        
        if (presents != NULL)
        {
            NSMutableArray *resultArray = [[NSMutableArray alloc] init];
            for (NSDictionary *currentResult in presents)
            {
                Comuni *comune = [Comuni Load];
                comune.idcomune = [NSNumber numberWithLong:[[currentResult objectForKey:@"idcom"] integerValue]];
                comune.idprovincia =[NSNumber numberWithLong:[[currentResult objectForKey:@"idprov"] integerValue]];
                
                comune.comune =[currentResult objectForKey:@"comune"] ;
                comune.provincia =[currentResult objectForKey:@"prov"] ;
                comune.logo =[currentResult objectForKey:@"logo"] ;
                comune.email=[currentResult objectForKey:@"email"] ;
                comune.emailAmbiente=[currentResult objectForKey:@"emailAmb"];
                
                comune.cap=[currentResult objectForKey:@"cap"] ;
                comune.codiceIstat=[currentResult objectForKey:@"cIstat"] ;
                comune.latitudine=[[currentResult objectForKey:@"coordinate"] objectForKey:@"lat"] ;
                comune.longitudine=[[currentResult objectForKey:@"coordinate"] objectForKey:@"lon"] ;
                comune.regione=[currentResult objectForKey:@"sprov"] ;
                comune.url=[currentResult objectForKey:@"url"] ;
                comune.urlZone=[currentResult objectForKey:@"urlzone"] ;
                comune.numeroAbitanti=0;
                comune.numeroAbitanti=[NSNumber numberWithInteger:[[currentResult objectForKey:@"numAb"] integerValue] ];
                //NSLog(@"%@",comune.numeroAbitanti);
                
                CLLocationDegrees latitude = [[[currentResult objectForKey:@"coordinate"] objectForKey:@"lat"] floatValue];
                CLLocationDegrees longitude = [[[currentResult objectForKey:@"coordinate"] objectForKey:@"lon"] floatValue];
                CLLocationCoordinate2D location;
                location.latitude = latitude;
                location.longitude = longitude;
                
                comune.coordinate = location;
                
                comune.gestByComune =[currentResult objectForKey:@"gestByComune"] ;
                comune.idGestore =[NSNumber numberWithLong:[[currentResult objectForKey:@"idgestore"] integerValue]];
                
                comune.userGestore =[currentResult objectForKey:@"gestuser"];
                comune.nomeGestore =[currentResult objectForKey:@"gestnome"];
                comune.urlGestore =[currentResult objectForKey:@"gesturl"];

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

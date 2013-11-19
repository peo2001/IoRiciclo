//
//  Syncronizer.m
//  MyWedding
//
//  Created by Maria Cristina Narcisi on 01/06/13.
//  Copyright (c) 2013 Maria Cristina Narcisi. All rights reserved.
//

#import "Syncronizer.h"


@implementation Syncronizer
@synthesize delegate;

+ (NSString *)UrlRequest
{
    
   
    //return [NSString stringWithFormat:@"http://hq1.xtremesoftware.it/ioriciclo/webservices/"];
   // return [NSString stringWithFormat:@"http://kiss/IoRiciclo/WebServices/"];
   return [NSString stringWithFormat:@"http://www.iriciclo.it/webservices/"];
}

+(NSMutableArray *)SyncComuni:(NSNumber *)IdProvincia
{
    NSMutableArray * comuni;
    //recuper i comuni dal db
    comuni=[Comuni RC_:IdProvincia];
    
    NSString *fullUrlRequest =[NSString stringWithFormat: @"%@%@?IdProvincia=%@",[self UrlRequest],[Comuni UrlRequest],IdProvincia];
    
    //NSLog(@"fullUrlRequest comuni %@",fullUrlRequest );
    
    //se il teefono è connesso
    if ([Connector connected])
    {
        //recuper il plist dalla rete
        NSMutableDictionary *DictionaryComuni = [[NSMutableDictionary alloc] initWithContentsOfURL:[NSURL URLWithString: fullUrlRequest]];
        
        for(Comuni *comune in comuni )
        {
            //elimino i luogh vecchi
            [Comuni Delete: comune];
            
        }
        
        comuni = nil;
        //parso l'xml del plist
        comuni= [Comuni _parseXmlDictionary:DictionaryComuni];
        [Comuni Save];
                
    }
    return comuni;
    
}

+(NSMutableArray *)SyncZone:(NSNumber *)IdComune
{
    NSMutableArray * zone;
    zone =nil;
    zone = [Zone RC_perComune:IdComune];
    
   // NSString *fullUrlRequest =[UrlRequest stringByAppendingString:strComune];
     NSString *fullUrlRequest =[NSString stringWithFormat: @"%@%@%@",[self UrlRequest],[Zone UrlRequest],IdComune];
    
    NSLog(@"req: %@",fullUrlRequest);
    //se il teefono è connesso
    if ([Connector connected])
    {
        
        for(Zone *zona in zone )
        {
            //elimino i luogh vecchi
            [Zone Delete: zona];
            
        }
        
       // NSLog(@"dictionary: %@",[[NSMutableDictionary alloc] initWithContentsOfURL:[NSURL URLWithString:fullUrlRequest]]);
        //recuper il plist dalla rete
        NSMutableDictionary *DictionaryZone = [[NSMutableDictionary alloc] initWithContentsOfURL:[NSURL URLWithString:fullUrlRequest]];
             
        zone = nil;
        //parso l'xml del plist
        zone= [Zone _parseXmlDictionary:DictionaryZone];
        //salvo i nuovi luoghi
        [Zone Save];
       
        
    }
    return zone;
    
}

+(void)SyncProvince
{
    NSFetchedResultsController * province;
    province =nil;
    
   // NSString *UrlRequest = [Province UrlRequest];
    NSString *fullUrlRequest =[NSString stringWithFormat: @"%@%@",[self UrlRequest],[Province UrlRequest]];
    province = [Province RC_Fetch];
    
    //NSLog(@"province size %lu",(unsigned long)province.fetchedObjects.count);
    
    //se il teefono è connesso
    if ([Connector connected])
    {
        for(Province *provincia in province.fetchedObjects )
        {
            //elimino i luogh vecchi
            [Province Delete: provincia];
            
        }
        
       // NSLog(@"full request: %@",fullUrlRequest);
        //recuper il plist dalla rete
        NSMutableDictionary *DictionaryProvince = [[NSMutableDictionary alloc] initWithContentsOfURL:[NSURL URLWithString:fullUrlRequest]];
        
        province = nil;
        //parso l'xml del plist
        [Province _parseXmlDictionary:DictionaryProvince];
        //salvo i nuovi luoghi
        [Province Save];
        
        
    }
    
}

+(NSMutableArray *)SyncTipiRiciclo
{
    NSMutableArray * titpiriciclo;
    titpiriciclo =nil;
    
    NSString *UrlRequest = [TipiRiciclo UrlRequest];
    NSString *fullUrlRequest =UrlRequest;
    titpiriciclo=[TipiRiciclo RC_ ];
    
    //se il teefono è connesso
    if ([Connector connected])
    {
        
        for(TipiRiciclo *tiporic in titpiriciclo )
        {
            //elimino i luogh vecchi
            [TipiRiciclo Delete: tiporic];
            
        }
       // NSLog(@"fullUrlRequest: %@",fullUrlRequest);
        
       // NSLog(@"dictionary: %@",[[NSMutableDictionary alloc] initWithContentsOfURL:[NSURL URLWithString:fullUrlRequest]]);
        //recuper il plist dalla rete
        NSMutableDictionary *DictionaryTipiRiciclo = [[NSMutableDictionary alloc] initWithContentsOfURL:[NSURL URLWithString:fullUrlRequest]];
        
        titpiriciclo = nil;
        //parso l'xml del plist
        titpiriciclo= [TipiRiciclo _parseXmlDictionary:DictionaryTipiRiciclo];
        //salvo i nuovi luoghi
        [TipiRiciclo Save];
        
        
    }
    return titpiriciclo;
    
}
+(NSString*)normalizedDateWithDate:(NSDate*)date
{
    NSDate *today = date;
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setDateFormat:@"yyyy-MM-dd"];
    NSString *dateString = [dateFormat stringFromDate:today];
   // NSLog(@"date: %@", dateString);
    return dateString;
    [dateFormat release];
}

+(NSMutableArray *)SyncGiorniRiciclo:(NSDate *) data
{
    NSMutableArray * gorniriciclo;
    gorniriciclo =nil;
   
    gorniriciclo=[GiorniRiciclo RC_ ];
    
    NSString *UrlRequest = [NSString stringWithFormat: @"%@%@",[self UrlRequest],[GiorniRiciclo UrlRequest]];
    NSString* s2= [NSString stringWithFormat: @"?IdComune=%@",  [MyApplicationSingleton getIdComune]];
    NSString* s3= [NSString stringWithFormat: @"&IdZona=%@",  [MyApplicationSingleton getIdZona]];
    NSString* s4= [NSString stringWithFormat: @"&Data=%@",[self normalizedDateWithDate:data ]  ];
    
    NSString *fullUrlRequest =[UrlRequest stringByAppendingString:s2];
    fullUrlRequest =[fullUrlRequest stringByAppendingString:s3];
    fullUrlRequest =[fullUrlRequest stringByAppendingString:s4];
    
    NSString* encodedUrl = [fullUrlRequest stringByAddingPercentEscapesUsingEncoding:
                            NSASCIIStringEncoding];
    
    //se il teefono è connesso
    if ([Connector connected])
    {
        
        for(GiorniRiciclo *giorno in gorniriciclo )
        {
            //elimino i luogh vecchi
            [GiorniRiciclo Delete: giorno];
            
        }
       NSLog(@"fullUrlRequest: %@",encodedUrl);
       // NSLog(@"dictionary: %@",[[NSMutableDictionary alloc] initWithContentsOfURL:[NSURL URLWithString:encodedUrl]]);
        //recuper il plist dalla rete
        NSMutableDictionary *DictionaryZone = [[NSMutableDictionary alloc] initWithContentsOfURL:[NSURL URLWithString:encodedUrl]];
        
        gorniriciclo = nil;
        //parso l'xml del plist
        gorniriciclo= [GiorniRiciclo _parseXmlDictionary:DictionaryZone];
        //salvo i nuovi luoghi
        [GiorniRiciclo Save];
        
        
    }
    return gorniriciclo;
    
}


@end

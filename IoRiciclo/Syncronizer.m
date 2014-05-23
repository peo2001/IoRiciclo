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
   //return [NSString stringWithFormat:@"http://hq.xtremesoftware.it/ioriciclo/webservices/"];
    //return [NSString stringWithFormat:@"http://kiss/IoRiciclo/WebServices/"];
  return [NSString stringWithFormat:@"http://www.iriciclo.it/webservices/"];
}
+ (NSString *)UrlRequestSendUdid
{
    
    
   // return [NSString stringWithFormat:@"http://hq.xtremesoftware.it/ioriciclo/Appleregister.asp?"];
  //return [NSString stringWithFormat:@"http://kiss/IoRiciclo/Appleregister.asp?"];
    return [NSString stringWithFormat:@"http://www.iriciclo.it/Appleregister.asp?"];

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
        // NSLog(@"dictionary: %@",[[NSMutableDictionary alloc] initWithContentsOfURL:[NSURL URLWithString:fullUrlRequest]]);
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
    
    //NSLog(@"req: %@",fullUrlRequest);
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
       //NSLog(@"fullUrlRequest: %@",encodedUrl);
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

+(NSMutableArray *)SyncCentriRaccolta
{
    NSMutableArray * centriraccolta;
    centriraccolta =nil;
    
    centriraccolta=[CentriRaccolta RC_perComune:[MyApplicationSingleton getIdComune]];
    
    NSString *UrlRequest = [NSString stringWithFormat: @"%@%@",[self UrlRequest],[CentriRaccolta UrlRequest]];
    NSString* s2= [NSString stringWithFormat: @"?IdComune=%@",  [MyApplicationSingleton getIdComune]];
    
    NSString *fullUrlRequest =[UrlRequest stringByAppendingString:s2];
    
    NSString* encodedUrl = [fullUrlRequest stringByAddingPercentEscapesUsingEncoding:
                            NSASCIIStringEncoding];
    
    //se il teefono è connesso
    if ([Connector connected])
    {
        
        for(CentriRaccolta *centro in centriraccolta )
        {
            //elimino i luogh vecchi
            [CentriRaccolta Delete: centro];
            
        }
        //NSLog(@"fullUrlRequest: %@",encodedUrl);
        //NSLog(@"dictionary: %@",[[NSMutableDictionary alloc] initWithContentsOfURL:[NSURL URLWithString:encodedUrl]]);
        //recuper il plist dalla rete
        NSMutableDictionary *DictionaryCentri = [[NSMutableDictionary alloc] initWithContentsOfURL:[NSURL URLWithString:encodedUrl]];
        
        centriraccolta = nil;
        //parso l'xml del plist
        centriraccolta= [CentriRaccolta _parseXmlDictionary:DictionaryCentri];
        //salvo i nuovi luoghi
        [CentriRaccolta Save];
        
        
    }
    return centriraccolta;
    
}

+(NSMutableArray *)SyncCassonetti
{
    NSMutableArray * cassonetti;
    cassonetti =nil;
    
    cassonetti=[Cassonetto RC_ ];
    
    
    NSString *UrlRequest = [NSString stringWithFormat: @"%@%@",[self UrlRequest],[Cassonetto UrlRequest]];
    NSString* s2= [NSString stringWithFormat: @"?IdComune=%@",  [MyApplicationSingleton getIdComune]];
    NSString* s3= [NSString stringWithFormat: @"&Data=%@",[self normalizedDateWithDate:[NSDate date] ]  ];
    
    NSString *fullUrlRequest =[UrlRequest stringByAppendingString:s2];
    fullUrlRequest =[fullUrlRequest stringByAppendingString:s3];
    
    
    NSString* encodedUrl = [fullUrlRequest stringByAddingPercentEscapesUsingEncoding:
                            NSASCIIStringEncoding];
    
    //se il teefono è connesso
    if ([Connector connected])
    {
        
        for(Cassonetto *cassonetto in cassonetti )
        {
            //elimino i luogh vecchi
            [Cassonetto Delete: cassonetto];
            
        }
       // NSLog(@"fullUrlRequest: %@",encodedUrl);
        //NSLog(@"dictionary: %@",[[NSMutableDictionary alloc] initWithContentsOfURL:[NSURL URLWithString:encodedUrl]]);
        //recuper il plist dalla rete
        NSMutableDictionary *DictionaryCassonetti = [[NSMutableDictionary alloc] initWithContentsOfURL:[NSURL URLWithString:encodedUrl]];
        
        cassonetti = nil;
        //parso l'xml del plist
        cassonetti= [Cassonetto _parseXmlDictionary:DictionaryCassonetti];
        //salvo i nuovi luoghi
        [Cassonetto Save];
        
        
    }
    return cassonetti;
    
}

+(void)SyncAvvisi

{
    NSFetchedResultsController * avvisi;
    avvisi =nil;
    
    // NSString *UrlRequest = [Province UrlRequest];
    NSString *fullUrlRequest =[NSString stringWithFormat: @"%@%@%@%@",[self UrlRequest],[Avvisi UrlRequest], @"?IdComune=",  [MyApplicationSingleton getIdComune]];
    
    avvisi = [Avvisi RC_Fetch:[MyApplicationSingleton getIdComune] : @"datacreazione"];
    
   // NSLog(@"avvisi size %lu",(unsigned long)avvisi.fetchedObjects.count);
    
    //se il teefono è connesso
    if ([Connector connected])
    {
        for(Avvisi *avviso in avvisi.fetchedObjects )
        {
            //elimino i luogh vecchi
            [Avvisi Delete: avviso];
            
        }
        
        // NSLog(@"full request: %@",fullUrlRequest);
        //recuper il plist dalla rete
        NSMutableDictionary *DictionaryAvvisi = [[NSMutableDictionary alloc] initWithContentsOfURL:[NSURL URLWithString:fullUrlRequest]];
        //NSLog(@"dictionary: %@",[[NSMutableDictionary alloc] initWithContentsOfURL:[NSURL URLWithString:fullUrlRequest]]);
        avvisi = nil;
        //parso l'xml del plist
        [Avvisi _parseXmlDictionary:DictionaryAvvisi];
        //salvo i nuovi luoghi
        [Avvisi Save];
        
        
    }
    
}

+(void)SyncComune

{
    NSMutableArray * comuni;
    comuni =nil;
    
    // NSString *UrlRequest = [Province UrlRequest];
    NSString *fullUrlRequest =[NSString stringWithFormat: @"%@%@%@%@",[self UrlRequest],[Comuni UrlRequestSingoloComune], @"?IdComune=",  [MyApplicationSingleton getIdComune]];
    
    comuni = [Comuni RC_Comune:[MyApplicationSingleton getIdComune] ];
    
    // NSLog(@"avvisi size %lu",(unsigned long)avvisi.fetchedObjects.count);
    
    //se il teefono è connesso
    if ([Connector connected])
    {
        for(Comuni *comune in comuni )
        {
            //elimino i luogh vecchi
            [Comuni Delete: comune];
            
        }
        
        // NSLog(@"full request: %@",fullUrlRequest);
        //recuper il plist dalla rete
        NSMutableDictionary *DictionaryComune = [[NSMutableDictionary alloc] initWithContentsOfURL:[NSURL URLWithString:fullUrlRequest]];
        NSLog(@"dictionary: %@",[[NSMutableDictionary alloc] initWithContentsOfURL:[NSURL URLWithString:fullUrlRequest]]);
        comuni = nil;
        //parso l'xml del plist
        [Comuni _parseXmlDictionarySingleComune:DictionaryComune];
        //salvo i nuovi luoghi
        [Comuni Save];
        
        
    }
    
}

+(void)SyncUtente

{
    NSMutableArray * utente;
    utente =nil;
    
    UIDevice *myDevice = [UIDevice currentDevice];
    NSString * deviceUDID = [[myDevice identifierForVendor]UUIDString];
    
    NSString *fullUrlRequest =[NSString stringWithFormat: @"%@%@%@%@",[self UrlRequest],[Utenti UrlRequest], @"?regId=",  deviceUDID];
    
    utente = [Utenti RC_];
    
    // NSLog(@"avvisi size %lu",(unsigned long)avvisi.fetchedObjects.count);
    
    //se il teefono è connesso
    if ([Connector connected])
    {
        
       //  NSLog(@"full request: %@",fullUrlRequest);
        //recuper il plist dalla rete
        NSMutableDictionary *DictionaryUtente = [[NSMutableDictionary alloc] initWithContentsOfURL:[NSURL URLWithString:fullUrlRequest]];
        //NSLog(@"dictionary: %@",[[NSMutableDictionary alloc] initWithContentsOfURL:[NSURL URLWithString:fullUrlRequest]]);
        
        if (!( DictionaryUtente ==nil ))
        {
        //parso l'xml del plist
            [Utenti _parseXmlDictionary:DictionaryUtente];
        
            for(Utenti *ut in utente )
            {
            //elimino i luogh vecchi
                [Utenti Delete: ut];
            
            }
            utente = nil;
        //salvo
            [Utenti Save];
        }
    
        
        
    }
    
}



@end

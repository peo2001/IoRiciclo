//
//  Utenti.m
//  IoRiciclo
//
//  Created by Maria Cristina Narcisi on 26/02/14.
//  Copyright (c) 2014 Maria Cristina Narcisi. All rights reserved.
//

#import "Utenti.h"
#import "MyApplicationSingleton.h"

@implementation Utenti

@dynamic idiosudid;
@dynamic iosudid;
@dynamic datacreazione;
@dynamic idcomune;
@dynamic idzona;
@synthesize nomeutente;

@synthesize connection;

+(Utenti *)Load
{
    return (Utenti *) [super LoadEntity:@"Utenti"];
}

+(NSMutableArray *)RC_
{
    
    [super setEntity:@"Utenti"];
    
    UIDevice *myDevice = [UIDevice currentDevice];
    NSString * deviceUDID = [[myDevice identifierForVendor]UUIDString];
    
    [self AddPredicate:  (NSPredicate *) [NSString stringWithFormat:@"1=1"]];
    [self AddPredicate:  (NSPredicate *) [NSString stringWithFormat:@"iosudid='%@'",
                                          deviceUDID]];
    return [super RC_];
    
    
}

+ (NSString *)UrlRequest
{
    
    return [NSString stringWithFormat: @"ExportZonaUtentePlist.asp"];
    
}

+(NSMutableArray*)_parseXmlDictionary:(NSDictionary *)aDictionary
{
    if (aDictionary != NULL && [aDictionary count] > 0) {
        NSArray *presents = [aDictionary objectForKey:@"utente"];
        
        if (presents != NULL)
        {
            NSMutableArray *resultArray = [[NSMutableArray alloc] init];
            for (NSDictionary *currentResult in presents)
            {
                Utenti *utente = [Utenti Load];
                utente.idiosudid = [NSNumber numberWithLong:[[currentResult objectForKey:@"idutente"] integerValue]];
                utente.idzona =[NSNumber numberWithLong:[[currentResult objectForKey:@"idzona"] integerValue]];
                utente.iosudid =[currentResult objectForKey:@"iosudid"];
                utente.idcomune =[currentResult objectForKey:@"idcomune"] ;
                [resultArray addObject:utente];
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



- (BOOL)IsUserLogged
{
    NSString *idFB = [[NSUserDefaults standardUserDefaults] valueForKey:@"idFB"];
    //NSString *nameFB =[[NSUserDefaults standardUserDefaults] valueForKey:@"nameFB"];
    
    return ![ idFB isEqualToString:@""] &&  !(idFB ==nil) ;

}

-(void)login : (id<FBGraphUser>)user
{
    self.nomeutente =user.name;
    //self.emailutente =[user objectForKey:@"email"];
    //self.idutente =[user objectForKey:@"id"] ;
    
    
    [self SaveUserNameIdFB :[user objectForKey:@"id"] :[user name]];
    
    //if there is a connection going on just cancel it.
    [self.connection cancel];
    NSURL *url = [NSURL URLWithString: [self MakeWebServiceFacebookUrl:user ]];
    
    //initialize a request from url
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[url standardizedURL]];
    
    //set http method
    [request setHTTPMethod:@"POST"];
    //initialize a post data
    //NSString *postData = @"fname=example&amp;lname=example";
    //set request content type we MUST set this value.
    
    [request setValue:@"application/x-www-form-urlencoded; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    
    //set post data of request
    // [request setHTTPBody:[postData dataUsingEncoding:NSUTF8StringEncoding]];
    
    //initialize a connection from request
    //NSURLConnection *connection = [[NSURLConnection alloc] initWithRequest:request delegate:self];
    connection = [[NSURLConnection alloc] initWithRequest:request delegate:self];
    // [connection release];
    
    //start the connection
    [connection start];
    
    
}

-(void)SaveUserNameIdFB :(NSString *) idFB : (NSString *) name
{
    [[NSUserDefaults standardUserDefaults] setValue:idFB forKey:@"idFB"];
    [[NSUserDefaults standardUserDefaults] setValue:name forKey:@"nameFB"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    //recuper le informazioni del comune e della zona dal registro del telefono e li salva nelle variabili globali dell'applicazione
    
    [MyApplicationSingleton setIdFB:idFB];
    [MyApplicationSingleton setNameFB:name];
}


-(void)logoff
{
    self.nomeutente=@"" ;
    [[NSUserDefaults standardUserDefaults] setValue:@"" forKey:@"idFB"];
    [[NSUserDefaults standardUserDefaults] setValue:@"" forKey:@"nameFB"];
    
    [[NSUserDefaults standardUserDefaults] synchronize];
    
}

- (NSString *) MakeWebServiceFacebookUrl :(id<FBGraphUser>) user
{
    //NSString *sUrl = @"http://kiss/IoRiciclo/WebServices/ReceiveFacebookData.asp?";
    
    NSString *sUrl = @"http:www.iriciclo.it/WebServices/ReceiveFacebookData.asp?";

    
    sUrl =[sUrl stringByAppendingString: [NSString stringWithFormat:@"DeviceType=IOS"]];
    
    UIDevice *myDevice = [UIDevice currentDevice];
    NSString * deviceUDID = [[myDevice identifierForVendor]UUIDString];
    
    sUrl= [sUrl stringByAppendingString: [NSString stringWithFormat:@"&AppId=%@", deviceUDID]];
    
    
    if (![user.first_name  isEqual:@""])
    {
        sUrl = [sUrl stringByAppendingString: [NSString stringWithFormat:@"&FName=%@",user.first_name ]];
        
    }
    
    if (![user.last_name  isEqual:@""])
    {
        sUrl = [sUrl stringByAppendingString: [NSString stringWithFormat:@"&LName=%@",user.last_name]];
        
    }
    
    if (![[user objectForKey:@"id"]  isEqual:@""])
    {
        sUrl = [sUrl stringByAppendingString: [NSString stringWithFormat:@"&Id=%@",[user objectForKey:@"id"]]];
        
    }
  
    if ([user username]  !=NULL)
    {
        sUrl = [sUrl stringByAppendingString: [NSString stringWithFormat:@"&UName=%@",user.username]];
    }
    
    
    
     if ([user birthday]  !=NULL)
     {
          sUrl = [sUrl stringByAppendingString: [NSString stringWithFormat:@"&Dn=%@",[user birthday]]];
     
     }
     if (user[@"gender"] !=NULL)
     {
         
         sUrl = [sUrl stringByAppendingString: [NSString stringWithFormat:@"&Gen=%@",user[@"gender"]]];
     }
    
    if (user[@"timezone"] !=NULL)
    {
        
        sUrl = [sUrl stringByAppendingString: [NSString stringWithFormat:@"&Tz=%@",user[@"timezone"]]];
    }
    if (user[@"locale"] !=NULL)
    {
        
        sUrl = [sUrl stringByAppendingString: [NSString stringWithFormat:@"&Loc=%@",user[@"locale"]]];
    }
    if (user[@"updated_time"] !=NULL)
    {
        
        sUrl = [sUrl stringByAppendingString: [NSString stringWithFormat:@"&Ut=%@",user[@"updated_time"]]];
    }
   
    
     if ([user location]!=nil)
     {
          sUrl = [sUrl stringByAppendingString: [NSString stringWithFormat:@"&Loc=%@",[[user location] name]]];
     
     }
     if (user[@"education"]!=NULL)
     {
          sUrl = [sUrl stringByAppendingString: [NSString stringWithFormat:@"&Edu=%@",user[@"education"]]];
         }
    
   
    
    if (![[user objectForKey:@"email"]  isEqual:@""])
    {
        sUrl = [sUrl stringByAppendingString: [NSString stringWithFormat:@"&Em=%@",user[@"email"]]];
    }
    
     NSLog(@"url= %@", [sUrl stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]);
    return [sUrl stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
}


- (void)connection:(NSURLConnection*)connection didReceiveData:(NSData*)data
{
    // NSLog(@"Did Receive Data %@", data);
    //[responseData appendData:data];
  //  NSString *string = [[NSString alloc] initWithData:data encoding:NSASCIIStringEncoding];
    //NSLog(@"Did Receive Data %@", string);
    
    //NSDictionary *dictionary = [string propertyList];
    //NSLog(@"%@",dictionary);
    
    
    //FARE IL PARSE CHE TORNA ARRAY DI CAFFE
    // [_delegate DidCaffeLoaded:[self _parseXmlDictionary:dictionary]];
    
}





@end

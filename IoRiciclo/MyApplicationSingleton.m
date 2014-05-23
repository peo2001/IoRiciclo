//
//  SingletonSample.m
//  BigBallOfMud
//
//  Created by Jason Agostoni on 1/22/12.
//

#import "MyApplicationSingleton.h"


@implementation MyApplicationSingleton

@synthesize IdComune,IdZona, OraNotifica,MinutiNotifica;

#pragma mark Singleton Implementation
static MyApplicationSingleton *sharedObject;


+ (MyApplicationSingleton*)sharedInstance {
    
   /* static dispatch_once_t onceToken = 0;
    
    dispatch_once(&onceToken, ^{
        sharedObject = [[MyApplicationSingleton alloc] init];
        
    });
    */
    @synchronized(self)
    {
        if(sharedObject==nil)
        {
            sharedObject=  [[MyApplicationSingleton alloc] init];
            sharedObject.OraNotifica = 0;
            sharedObject.MinutiNotifica=0;
        }
    }
    
    return sharedObject;
}

#pragma mark Shared Public Methods

+(NSNumber *) getIdComune {
    // Ensure we are using the shared instance
    MyApplicationSingleton *shared = [MyApplicationSingleton sharedInstance];
    return (shared.IdComune);
}

+(void) setIdComune:(NSNumber *)IdComune {
    // Ensure we are using the shared instance
    MyApplicationSingleton *shared = [MyApplicationSingleton sharedInstance];
    shared.IdComune = IdComune;
}

+(NSNumber *) getIdZona{
    // Ensure we are using the shared instance
    MyApplicationSingleton *shared = [MyApplicationSingleton sharedInstance];
    return (shared.IdZona);
}

+(void) setIdZona:(NSNumber *)IdZona {
    // Ensure we are using the shared instance
    MyApplicationSingleton *shared = [MyApplicationSingleton sharedInstance];
    shared.IdZona = IdZona;
}

+(NSInteger ) getOraNotifica {
    // Ensure we are using the shared instance
    MyApplicationSingleton *shared = [MyApplicationSingleton sharedInstance];
    return (shared.OraNotifica);
}

+(void) setOraNotifica:(NSInteger )OraNotifica {
    // Ensure we are using the shared instance
    MyApplicationSingleton *shared = [MyApplicationSingleton sharedInstance];
    shared.OraNotifica = OraNotifica;
}

+(NSInteger ) getMinutiNotifica{
    // Ensure we are using the shared instance
    MyApplicationSingleton *shared = [MyApplicationSingleton sharedInstance];
    return (shared.MinutiNotifica);
}

+(void) setMinutiNotifica:(NSInteger )MinutiNotifica {
    // Ensure we are using the shared instance
    MyApplicationSingleton *shared = [MyApplicationSingleton sharedInstance];
    shared.MinutiNotifica = MinutiNotifica;
}


+ (Boolean) IsUserLogged
{
         return true;
    
}
@end

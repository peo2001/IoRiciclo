//
//  SingletonSample.h
//  BigBallOfMud
//
//  Created by Jason Agostoni on 1/22/12.
//

#import <Foundation/Foundation.h>
#import "Utenti.h"

@interface MyApplicationSingleton : NSObject {
    // Instance variables:
    //   - Declare as usual.  The alloc/sharedIntance.
    NSNumber *IdComune;
    NSNumber *IdZona;
    NSInteger OraNotifica;
    NSInteger MinutiNotifica;
}

// Properties as usual
@property (nonatomic,assign) NSNumber *IdComune;
@property (nonatomic,assign) NSNumber *IdZona;
@property (nonatomic,assign) NSInteger OraNotifica;
@property (nonatomic,assign) NSInteger MinutiNotifica;
@property (nonatomic,assign) NSString * idFB;
@property (nonatomic,assign) NSString * nameFB;
@property (nonatomic,assign) Utenti * utente;

 
// Required: A method to retrieve the shared instance
+(MyApplicationSingleton *) sharedInstance;


// Shared Public Methods:
//   - Using static methods for opertations is a nice convenience
//   - Each method should ensure it is using the above sharedInstance

+(NSNumber *) getIdComune;
+(void) setIdComune:(NSNumber *)IdComune;
+(NSNumber *) getIdZona;
+(void) setIdZona:(NSNumber *)IdZona;
+(void)setIdFB: (NSString *) idFB;
+(void)setNameFB: (NSString *) nameFB;

+(Boolean)IsUserLogged;

+(NSInteger ) getOraNotifica;
+(void) setOraNotifica:(NSInteger )OraNotifica;
+(NSInteger ) getMinutiNotifica;
+(void) setMinutiNotifica:(NSInteger )MinutiNotifica;





// Instance Methods: Declare and implement as usual
@end

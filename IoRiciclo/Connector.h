//
//  Connector.h
//  MyWedding
//
//  Created by Maria Cristina Narcisi on 01/06/13.
//  Copyright (c) 2013 Maria Cristina Narcisi. All rights reserved.
//

#import <Foundation/Foundation.h>

@class Reachability;
@interface Connector : NSObject{
    
    Reachability* hostReach;
    Reachability* internetReach;
    Reachability* wifiReach;
}


+(BOOL)connected;
+(BOOL) isConnectionAvailable;

@end

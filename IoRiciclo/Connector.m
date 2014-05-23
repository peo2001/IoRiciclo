//
//  Connector.m
//  MyWedding
//
//  Created by Maria Cristina Narcisi on 01/06/13.
//  Copyright (c) 2013 Maria Cristina Narcisi. All rights reserved.
//

#import "Connector.h"
#import "Reachability.h"

@implementation Connector


+(BOOL)connected
{
    Reachability *reachability = [Reachability reachabilityForInternetConnection];
    NetworkStatus networkStatus = [reachability currentReachabilityStatus];
    return !(networkStatus == NotReachable);
}

+ (BOOL) isConnectionAvailable
{
	SCNetworkReachabilityFlags flags;
    BOOL receivedFlags;
    
    SCNetworkReachabilityRef reachability = SCNetworkReachabilityCreateWithName(CFAllocatorGetDefault(), [@"www.google.it" UTF8String]);
    receivedFlags = SCNetworkReachabilityGetFlags(reachability, &flags);
    CFRelease(reachability);
    
    if (!receivedFlags || (flags == 0) )
    {
        return FALSE;
    } else {
		return TRUE;
	}
}

@end

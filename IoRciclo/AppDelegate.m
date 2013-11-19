//
//  AppDelegate.m
//  IoRciclo
//
//  Created by Maria Cristina Narcisi on 07/07/13.
//  Copyright (c) 2013 Maria Cristina Narcisi. All rights reserved.
//

#import "AppDelegate.h"
#import "MyApplicationSingleton.h"
#import "Syncronizer.h"
#import "RicicloViewController.h"


@implementation AppDelegate


- (id) init
{
    if (self = [super init])
    {
        // initialize everything else
    }
    return self;
}
- (void)dealloc
{
    [_window release];
    [super dealloc];
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
  
    application.applicationIconBadgeNumber = 0;
    
    NSNumber * IdComune = [[NSUserDefaults standardUserDefaults] valueForKey:@"IdComune"];
    NSNumber * IdZona = [[NSUserDefaults standardUserDefaults] valueForKey:@"IdZona"];
    
    NSInteger OraNotifica = [[NSUserDefaults standardUserDefaults] integerForKey:@"OraNotifica"];
    NSInteger MinutiNotifica = [[NSUserDefaults standardUserDefaults] integerForKey:@"MinutiNotifica"];
    
    
    [MyApplicationSingleton setIdComune:IdComune];
    [MyApplicationSingleton setIdZona:IdZona];
    
    [MyApplicationSingleton setOraNotifica:OraNotifica];
    [MyApplicationSingleton setMinutiNotifica:MinutiNotifica];
   
    // Handle launching from a notification
    UILocalNotification *localNotif =
    [launchOptions objectForKey:UIApplicationLaunchOptionsLocalNotificationKey];
    if (localNotif) {
      //  NSLog(@"Recieved Notification %@",localNotif);
    }
    
    return YES;
    
}


//the notifications will go to the function given below if your app is running in forground
- (void)application:(UIApplication *)app didReceiveLocalNotification:(UILocalNotification *)notif {
    // Handle the notificaton when the app is running
    //NSLog(@"Recieved Notification %@",notif);
}

- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo
{
     //NSLog(@"AppDelegate didReceiveLocalNotification aiuuuto");
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    RicicloViewController *myview = [[RicicloViewController alloc] init];
    [myview viewWillAppear:TRUE];

}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    application.applicationIconBadgeNumber = 0;
   
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end

//
//  CoreDataMethods.m
//  SCuore
//
//  Created by Maria Cristina Narcisi on 19/05/13.
//  Copyright (c) 2013 Maria Cristina Narcisi. All rights reserved.
//

#import "CoreDataMethods.h"

@implementation CoreDataMethods

@synthesize managedObjectModel,managedObjectContext,persistentStoreCoordinator,req;

static CoreDataMethods *instance=nil;

+(CoreDataMethods *)getInstance
{
    @synchronized(self)
    {
        if(instance==nil)
        {
            instance= [CoreDataMethods new];
        }
    }
    return instance;
}


//Metodi CORE DATA
- (NSFetchRequest *) req {
    
    if (req != nil) {
        
        return req;
        
    }else
    {
        
        req = [[NSFetchRequest alloc]init];
        
    }
    
    return req;
}


- (NSManagedObjectContext *) managedObjectContext {
    
    if (managedObjectContext != nil) {
        
        return managedObjectContext;
        
    }
   
    
    NSPersistentStoreCoordinator *coordinator = [self persistentStoreCoordinator];
    
    if (coordinator != nil) {
        
        managedObjectContext = [[NSManagedObjectContext alloc] init];
        
        [managedObjectContext setPersistentStoreCoordinator: coordinator];
        
    }
    
    return managedObjectContext;
}

- (NSManagedObjectModel *)managedObjectModel

{
    if (managedObjectModel != nil) {
        
        return managedObjectModel;
        
    }
    
    else
        
    {
        /*
         NSURL *modelURL = [[NSBundle mainBundle] URLForResource:@"Model" withExtension:@"momd"];
         return[[NSManagedObjectModel alloc] initWithContentsOfURL:modelURL];
         */
        managedObjectModel = [NSManagedObjectModel mergedModelFromBundles:nil];
        
        return managedObjectModel;
        
    }
    
}

- (NSPersistentStoreCoordinator *)persistentStoreCoordinator {
    
    if (persistentStoreCoordinator != nil) {
        
        return persistentStoreCoordinator;
        
    }
    
    NSLog(@"IL PATH:%@",[self applicationDocumentsDirectory]);
    
    NSURL *storeUrl = [NSURL fileURLWithPath: [[self applicationDocumentsDirectory] stringByAppendingPathComponent: @"IoRiciclo3.sqlite"]];
    
    NSError *error = nil;
    
    persistentStoreCoordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:[self managedObjectModel]];
    
    if (![persistentStoreCoordinator addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:storeUrl options:nil error:&error]) {
        
        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
        
        abort();
        
    }
    
    return persistentStoreCoordinator;
    
}

- (NSString *)applicationDocumentsDirectory

{
    return [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    
}



//FINE METODI CORE DATA


@end

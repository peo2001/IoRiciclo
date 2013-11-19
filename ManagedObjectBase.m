//
//  ManagedObjectBase.m
//  SCuore
//
//  Created by Maria Cristina Narcisi on 19/05/13.
//  Copyright (c) 2013 Maria Cristina Narcisi. All rights reserved.
//

#import "ManagedObjectBase.h"

@implementation ManagedObjectBase


+(void) AddPredicate: (NSString *) Predicate
{
    
    [[[CoreDataMethods getInstance]req]setPredicate:[NSPredicate predicateWithFormat:Predicate]];
}

+(void) AddSortDescription: (NSString *) sortFields
{
    NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:sortFields ascending:YES];
    NSArray *sortDescriptors = [NSArray arrayWithObjects:sortDescriptor, nil];
    
    [[[CoreDataMethods getInstance]req] setSortDescriptors:sortDescriptors];
}

+(void) AddGroupBy:(NSArray *) GroupBy
{
    
    [[[CoreDataMethods getInstance]req]  setReturnsDistinctResults:YES];
    [[[CoreDataMethods getInstance]req]  setResultType:NSDictionaryResultType];
    /* NSAttributeDescription* statusDesc = [entity.attributesByName objectForKey:@"status"];*/
    
    [[[CoreDataMethods getInstance]req]  setPropertiesToFetch:GroupBy];
    
    
    [[[CoreDataMethods getInstance]req] setPropertiesToGroupBy:GroupBy];
    
}

+(void) setEntity:(NSString *)EntityName
{
    NSEntityDescription *entity = [NSEntityDescription entityForName:EntityName inManagedObjectContext:[CoreDataMethods getInstance].managedObjectContext];
    
    [CoreDataMethods getInstance].req =[[NSFetchRequest alloc]init];
    
    [[[CoreDataMethods getInstance]req] setEntity:entity];
    
}

//carica l'oggetto nsmanaged
+ (ManagedObjectBase *)LoadEntity:(NSString *)EntityName
{
    return (ManagedObjectBase *)[NSEntityDescription insertNewObjectForEntityForName:EntityName inManagedObjectContext:[CoreDataMethods getInstance].managedObjectContext];
    
}



+(NSMutableArray *)RC_{
    
    
    //CoreDataMethods *app = [CoreDataMethods alloc];
    //  [[[CoreDataMethods getInstance]req] setEntity:[NSEntityDescription entityForName:EntityName inManagedObjectContext:[[CoreDataMethods getInstance] managedObjectContext]]];
    
    
    NSError *error;
    NSMutableArray *array = [[NSMutableArray alloc]init];
    
    
    array =(NSMutableArray *) [[[CoreDataMethods getInstance] managedObjectContext] executeFetchRequest:[[CoreDataMethods getInstance]req] error:&error];
    
    [array retain ];
    
    //azzerare il predicate o il req
    [self AddPredicate: (NSPredicate *)[NSString stringWithFormat:@"1=1"]];
    
    return array;
}


+(NSFetchedResultsController *)RC_Fetch:(NSString *)Sort
{
    
    [[[CoreDataMethods getInstance]req]  setFetchBatchSize:20];
   // [self AddPredicate:  [NSString stringWithFormat:@"1=1"]];
    [self AddSortDescription:Sort];
    
    NSFetchedResultsController *aFetchedResultsController = [[NSFetchedResultsController alloc] initWithFetchRequest:[[CoreDataMethods getInstance]req] managedObjectContext:[[CoreDataMethods getInstance] managedObjectContext]  sectionNameKeyPath:Sort cacheName:@"Root"];
 
    NSError *error = nil;
    if (![aFetchedResultsController performFetch:&error]) {
       
        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
        abort();
    }

    return aFetchedResultsController;
}


/*
 - (NSFetchedResultsController *)fetchedResultsController
 {
 if (__fetchedResultsController != nil) {
 return __fetchedResultsController;
 }
 
 // Set up the fetched results controller.
 // Create the fetch request for the entity.
 NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
 // Edit the entity name as appropriate.
 NSEntityDescription *entity = [NSEntityDescription entityForName:@"Event" inManagedObjectContext:self.managedObjectContext];
 [fetchRequest setEntity:entity];
 
 // Set the batch size to a suitable number.
 [fetchRequest setFetchBatchSize:20];
 
 // Edit the sort key as appropriate.
 NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"timeStamp" ascending:NO];
 NSArray *sortDescriptors = [NSArray arrayWithObjects:sortDescriptor, nil];
 
 [fetchRequest setSortDescriptors:sortDescriptors];
 
 // Edit the section name key path and cache name if appropriate.
 // nil for section name key path means "no sections".
 NSFetchedResultsController *aFetchedResultsController = [[NSFetchedResultsController alloc] initWithFetchRequest:fetchRequest managedObjectContext:self.managedObjectContext sectionNameKeyPath:nil cacheName:@"Master"];
 aFetchedResultsController.delegate = self;
 self.fetchedResultsController = aFetchedResultsController;
 
 NSError *error = nil;
 if (![self.fetchedResultsController performFetch:&error]) {
 *
 Replace this implementation with code to handle the error appropriately.
 
 abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
 *
 NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
 abort();
 }
 
 return __fetchedResultsController;
 }
 */

- (NSManagedObjectContext *) managedObjectContext {
    
    if (managedObjectContext != nil) {
        
        return managedObjectContext;
        
    }
    
    
    NSPersistentStoreCoordinator *coordinator = [[CoreDataMethods getInstance]  persistentStoreCoordinator];
    
    if (coordinator != nil) {
        
        managedObjectContext = [[NSManagedObjectContext alloc] init];
        
        [managedObjectContext setPersistentStoreCoordinator: coordinator];
        
    }
    
    return managedObjectContext;
}
/*-(void)ResetManagedObjectContext{
    managedObjectContext = nil;
}
 */

//salva di contesto
+(void)Save
{
    NSError *error;
    
    if (! [[[CoreDataMethods getInstance] managedObjectContext] save:&error]) {
        NSLog(@"Failed to save - error: %@", [error localizedDescription]);
        
    }
    //[[[CoreDataMethods getInstance] managedObjectContext] refreshObject:self mergeChanges:NO];
   // [[[CoreDataMethods getInstance] managedObjectContext]reset];
    
}


+(void)Delete:(NSManagedObject *)ManagedObject
{
    [[[CoreDataMethods getInstance] managedObjectContext] deleteObject:ManagedObject];
    NSError *error;
	if (![[[CoreDataMethods getInstance] managedObjectContext] save:&error]) {
		
		// Handle the error.
		NSLog(@"%@", [error domain]);
	}
}


@end

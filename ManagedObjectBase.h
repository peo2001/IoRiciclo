//
//  ManagedObjectBase.h
//  SCuore
//
//  Created by Maria Cristina Narcisi on 19/05/13.
//  Copyright (c) 2013 Maria Cristina Narcisi. All rights reserved.
//


#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import "CoreDataMethods.h"

@interface ManagedObjectBase:NSManagedObject
{
      NSManagedObjectContext *managedObjectContext;
}


@property (nonatomic, assign)  NSManagedObjectContext *managedObjectContext;

+(void) AddPredicate: (NSPredicate *) Predicate;
+(void) AddSortDescription: (NSString *) sortFields;
+(void) AddGroupBy: (NSArray *) GroupBy;
+(void) setEntity:(NSString *)EntityName;
+(NSMutableArray *)RC_;
+(NSFetchedResultsController *)RC_Fetch:(NSString * )Sort;
+(ManagedObjectBase *)LoadEntity:(NSString * )EntityName;
+(void)Save;
+(void)Delete:(NSManagedObject *)ManagedObject;
//-(void)ResetManagedObjectContext;

@end


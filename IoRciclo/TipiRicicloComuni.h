//
//  TipiRicicloComuni.h
//  IoRciclo
//
//  Created by Maria Cristina Narcisi on 05/09/13.
//  Copyright (c) 2013 Maria Cristina Narcisi. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import "ManagedObjectBase.h"



@interface TipiRicicloComuni : ManagedObjectBase

@property (nonatomic, retain) NSNumber * idtiporiciclocomune;
@property (nonatomic, retain) NSNumber * idcomune;
@property (nonatomic, retain) NSString * codtiporiciclo;
@property (nonatomic, retain) NSString * descrizione;

@end

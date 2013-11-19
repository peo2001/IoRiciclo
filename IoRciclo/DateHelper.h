//
//  DateHelper.h
//  IoRciclo
//
//  Created by Maria Cristina Narcisi on 11/11/13.
//  Copyright (c) 2013 Maria Cristina Narcisi. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DateHelper : NSObject


+ (NSDate *)dataInizioGiorno : (NSDate *) data;
+ (NSDate *)dataFineGiorno:(NSDate *) data;
+ (NSDate *)dateWithNoTime:(NSDate *)dateTime;
+ (NSDate *)dateAdd:(NSDate*)data :(uint)daysToAdd;


@end

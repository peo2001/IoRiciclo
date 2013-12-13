//
//  DateHelper.m
//  IoRciclo
//
//  Created by Maria Cristina Narcisi on 11/11/13.
//  Copyright (c) 2013 Maria Cristina Narcisi. All rights reserved.
//

#import "DateHelper.h"

@implementation DateHelper




+ (NSDate *)dateWithNoTime:(NSDate *)dateTime {
    
    if( dateTime == nil ) {
        dateTime = [NSDate date];
    }
    
    NSCalendar       *calendar   = [[[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar] autorelease];
    [calendar setTimeZone:[NSTimeZone timeZoneWithAbbreviation:@"UTC"]];
    NSDateComponents *components = [[[NSDateComponents alloc] init] autorelease];
    components = [calendar components:NSYearCalendarUnit|NSMonthCalendarUnit|NSDayCalendarUnit
                             fromDate:dateTime];
    
    NSDate *dateOnly = [calendar dateFromComponents:components];
    
    [dateOnly dateByAddingTimeInterval:(60.0 * 60.0 * 12.0)];           // Push to Middle of day.
    return dateOnly;
}



+ (NSDate *)dataInizioGiorno : (NSDate *) data{
    
    NSCalendar *calendar = [NSCalendar currentCalendar];
    
    //gather date components from date
    NSDateComponents *dateComponents = [calendar components:(NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit) fromDate:data];
    
    //set date components
    [dateComponents setHour:0];
    [dateComponents setMinute:0];
    [dateComponents setSecond:0];
    
    //return date relative from date
    return [calendar dateFromComponents:dateComponents];
    
}

+ (NSDate *)dataFineGiorno:(NSDate *) data {
    
    NSCalendar *calendar = [NSCalendar currentCalendar];
    
    //gather date components from date
    NSDateComponents *dateComponents = [calendar components:(NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit) fromDate:data];
    
    //set date components
    [dateComponents setHour:23];
    [dateComponents setMinute:59];
    [dateComponents setSecond:59];
    
    //return date relative from date
    return [calendar dateFromComponents:dateComponents];
    
}

//aggiunge giorni alla data
+(NSDate *)dateAdd:(NSDate*)data :(uint)daysToAdd
{
    // set up date components
    NSDateComponents *components = [[[NSDateComponents alloc] init] autorelease];
    [components setDay:daysToAdd];
    
    // create a calendar
    NSCalendar *gregorian = [[[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar] autorelease];
    
    //fine dateadd
    
    return [gregorian dateByAddingComponents:components toDate:data options:0];;
}
+(NSDate *)DateTimeZone: (NSDate *)Data
{
    //NSDate* date = [NSDate date];
    NSTimeZone* currentTimeZone = [NSTimeZone timeZoneWithAbbreviation:@"GMT"];
    NSTimeZone* nowTimeZone = [NSTimeZone systemTimeZone];
    
    NSInteger currentGMTOffset = [currentTimeZone secondsFromGMTForDate:Data];
    NSInteger nowGMTOffset = [nowTimeZone secondsFromGMTForDate:Data];
    
    NSTimeInterval interval = nowGMTOffset - currentGMTOffset;
    NSDate* nowDate = [[NSDate alloc] initWithTimeInterval:interval sinceDate:Data];
    return nowDate;
    
}



@end

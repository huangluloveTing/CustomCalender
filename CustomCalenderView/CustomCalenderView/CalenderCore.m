//
//  CalenderCore.m
//  CustomCalenderView
//
//  Created by 黄露 on 2017/1/23.
//  Copyright © 2017年 黄露. All rights reserved.
//

#import "CalenderCore.h"

@implementation CalenderCore

- (NSInteger) currentMonthDaysInDate:(NSDate *)date {
    return [[NSCalendar currentCalendar] rangeOfUnit:NSCalendarUnitDay inUnit:NSCalendarUnitMonth forDate:date].length;
}

- (NSInteger) currentMonthTheWeeksInDate:(NSDate *)date {
    NSInteger firstWeekNum = [self currentMonthTheWeekDayInDate:date];
    NSInteger totalDays = [self currentMonthDaysInDate:date];
    
    //这个月第一天为firstWeekDayNum ， 这个月出去第一周还剩余的天数为 totalDays - （7 - firstWeekNum + 1）
    NSInteger weeks = (totalDays - (7 - firstWeekNum + 1 )) % 7 + 1;
    if ((totalDays - (7 - firstWeekNum + 1 )) / 7 != 0) {
        weeks ++;
    }
    
    return weeks;
}

- (NSUInteger) currentMonthTheWeekDayInDate:(NSDate *)date {
//    NSDate *startDate = nil;
    NSCalendar *calendar = [NSCalendar currentCalendar];
    [calendar setFirstWeekday:1];
//    BOOL getFirstDay = [[NSCalendar currentCalendar] rangeOfUnit:NSCalendarUnitMonth startDate:&startDate interval:NULL forDate:date];
//    if (getFirstDay) {
//        return [[NSCalendar currentCalendar] ordinalityOfUnit:NSCalendarUnitDay inUnit:NSCalendarUnitWeekday forDate:startDate];
//    }
    NSDateComponents *comp = [calendar components:(NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay) fromDate:date];
    [comp setDay:1];
    
    NSDate *firstDayOfMonthDate = [calendar dateFromComponents:comp];
    
    NSUInteger firstWeekday = [calendar ordinalityOfUnit:NSCalendarUnitWeekday inUnit:NSCalendarUnitWeekOfMonth forDate:firstDayOfMonthDate];
    
    return firstWeekday;
}

@end

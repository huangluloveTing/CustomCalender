//
//  NSDate+HLCalender.m
//  CustomCalenderView
//
//  Created by 黄露 on 2017/1/24.
//  Copyright © 2017年 黄露. All rights reserved.
//

#import "NSDate+HLCalender.h"

@implementation NSDate (HLCalender)



- (NSInteger) totalDaysForMonth {
    NSInteger totalDays = [[NSCalendar currentCalendar] rangeOfUnit:NSCalendarUnitDay inUnit:NSCalendarUnitMonth forDate:self].length;
    return totalDays;
}

- (NSInteger) theFirstDayForWeekDay {
    NSCalendar *calender = [NSCalendar currentCalendar];
    NSDateComponents *components = [calender components:NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitDay  fromDate:self];
    components.day = 1;
    NSDate *fisDate = [calender dateFromComponents:components];
    // 日历默认从零开始，所以减一
    NSInteger firstWeek = [calender ordinalityOfUnit:NSCalendarUnitWeekday inUnit:NSCalendarUnitWeekOfMonth forDate:fisDate];
    
    return firstWeek - 1;
}

- (NSInteger) theWeeksForMonth {
    //这个月的第一天时星期几
    NSInteger firtWeek = [self theFirstDayForWeekDay];
    //这个月减去第一周天数 所占有的周数， 实际占用周数跟第一天是星期几和总的天数有关
    NSInteger weekCount = ([self totalDaysForMonth] - (7 - firtWeek)) / 7;
    //大概占用周数后，剩余的天数
    NSInteger retainCOunt = ([self totalDaysForMonth] - (7 - firtWeek)) % 7;
    if (retainCOunt > 0) {
        
        return weekCount + 2;
    }
    return weekCount + 1;
}

- (NSDate *)preMonth {
    NSCalendar *calender = [NSCalendar currentCalendar];
    NSDateComponents *components = [calender components:NSCalendarUnitMonth|NSCalendarUnitYear|NSCalendarUnitDay fromDate:self];
    if (components.month == 1) {
        components.month = 12;
        components.year -= 1;
        
        return [calender dateFromComponents:components];
    }
    
    components.month -= 1;
    return [calender dateFromComponents:components];
}

- (NSDate *)nextMonth {
    NSCalendar *calender = [NSCalendar currentCalendar];
    NSDateComponents *components = [calender components:NSCalendarUnitDay|NSCalendarUnitMonth|NSCalendarUnitYear fromDate:self];
    if (components.month == 12) {
        components.month = 1;
        components.year += 1;
        return [calender dateFromComponents:components];
    }
    
    components.month += 1;
    return [calender dateFromComponents:components];
}

- (BOOL) confirmEqualToDate:(NSDate *)date {
    NSCalendar *calender1 = [NSCalendar currentCalendar];
    NSCalendar *calender2 = [NSCalendar currentCalendar];
    NSDateComponents *components_date = [calender1 components:NSCalendarUnitDay|NSCalendarUnitYear|NSCalendarUnitMonth fromDate:date];
    NSDateComponents *components_cur = [calender2 components:NSCalendarUnitMonth|NSCalendarUnitYear|NSCalendarUnitDay fromDate:self];
    
    if ((components_date.day == components_cur.day) && (components_cur.month == components_date.month) && (components_date.year == components_cur.year)) {
        
        return YES;
    }
    
    return NO;
}

- (BOOL) confirmEqualMonthToDate:(NSDate *)date {
    NSCalendar *calender = [NSCalendar currentCalendar];
    NSDateComponents *components_date = [calender components:NSCalendarUnitYear|NSCalendarUnitMonth fromDate:date];
    NSDateComponents *components_curr = [calender components:NSCalendarUnitYear|NSCalendarUnitMonth fromDate:self];
    if ([self confirmEqualToDate:date]) {
        return YES;
    }
    if ((components_date.month == components_curr.month) && (components_date.year == components_curr.year)) {
        return YES;
    }
    
    return NO;
}

- (NSDate *)specialDateWithDay:(NSInteger)day {
    NSCalendar *calender = [NSCalendar currentCalendar];
    NSDateComponents *components = [calender components:NSCalendarUnitMonth|NSCalendarUnitDay|NSCalendarUnitYear fromDate:self];
    components.day = day;
    NSDate *getDate = [calender dateFromComponents:components];
    return getDate;
}
@end

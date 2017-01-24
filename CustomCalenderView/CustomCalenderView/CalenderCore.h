//
//  CalenderCore.h
//  CustomCalenderView
//
//  Created by 黄露 on 2017/1/23.
//  Copyright © 2017年 黄露. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CalenderCore : NSObject

/**
 *    给定日期的当月有几天
 *
 *    @param date       给定的日期
 */
- (NSInteger) currentMonthDaysInDate:(NSDate *)date;

/**
 *    给定日期的当月第一天是星期几
 *
 *    @param date       给定的日期
 */
- (NSUInteger) currentMonthTheWeekDayInDate:(NSDate *)date;

/**
 *    给定日期的当月有几周
 *
 *    @param date       给定的日期
 */
- (NSInteger) currentMonthTheWeeksInDate:(NSDate *)date;

@end

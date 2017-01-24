//
//  NSDate+HLCalender.h
//  CustomCalenderView
//
//  Created by 黄露 on 2017/1/24.
//  Copyright © 2017年 黄露. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDate (HLCalender)

//一周有几天
- (NSInteger) totalDaysForMonth;

//一周的第一天是星期几
- (NSInteger) theFirstDayForWeekDay;

//一月需占用的周数
- (NSInteger) theWeeksForMonth;

//上一个月的月份
- (NSDate *) preMonth;

//下一个月的月份
- (NSDate *) nextMonth;

//判断给定的日期是不是在同一天
- (BOOL) confirmEqualToDate:(NSDate *)date;

//判断给定的日期是否是在同一月
- (BOOL) confirmEqualMonthToDate:(NSDate *)date;

//指定某一月的某一天的日期
- (NSDate *) specialDateWithDay:(NSInteger)day;

@end

//
//  ViewController.m
//  CustomCalenderView
//
//  Created by 黄露 on 2017/1/6.
//  Copyright © 2017年 黄露. All rights reserved.
//

#import "ViewController.h"
#import "NSDate+HLCalender.h"
#import "HLCalenderView.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSLog(@"days = %ld" ,[[NSCalendar currentCalendar] rangeOfUnit:NSCalendarUnitDay inUnit:NSCalendarUnitMonth forDate:[NSDate date]].length);
    
    NSDate *date = [NSDate date];
    NSLog(@"total:%ld",[date totalDaysForMonth]);
    NSLog(@"first:%ld",[date theFirstDayForWeekDay]);
    NSLog(@"pre:%@",[date preMonth]);
    NSLog(@"next:%@",[date nextMonth]);
    NSLog(@"total:%ld",[date totalDaysForMonth]);
    
    HLCalenderView *hlCalenderView = [[HLCalenderView alloc] initWithFrame:CGRectMake(0, 0, 300, 350)];
    [self.view addSubview:hlCalenderView];
    hlCalenderView.center = self.view.center;
    hlCalenderView.pagingEnabled = YES;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];

}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    UIViewController *vc =  segue.destinationViewController;
    vc.view.backgroundColor = [UIColor redColor];
    UIViewController *sourceVC = segue.sourceViewController;
    sourceVC.view.backgroundColor = [UIColor yellowColor];
    
}

@end

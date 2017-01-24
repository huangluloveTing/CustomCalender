//
//  HLCalenderCollectionViewCell.m
//  CustomCalenderView
//
//  Created by 黄露 on 2017/1/24.
//  Copyright © 2017年 黄露. All rights reserved.
//

#import "HLCalenderCollectionViewCell.h"
#import "NSDate+HLCalender.h"

@interface HLCalenderCollectionViewCell ()

@property (nonatomic ,strong) UILabel *dayLabel;

@end

@implementation HLCalenderCollectionViewCell

- (id) initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        _dayLabel = [[UILabel alloc] initWithFrame:self.contentView.bounds];
        _dayLabel.layer.cornerRadius = CGRectGetWidth(self.frame) / 2;
        _dayLabel.layer.masksToBounds = YES;
        _dayLabel.textAlignment = NSTextAlignmentCenter;
        _dayLabel.font = [UIFont systemFontOfSize:15];
        _dayLabel.textColor = [UIColor blackColor];
        [self.contentView addSubview:self.dayLabel];
    }
    
    return self;
}

- (void) setCellType:(CalenderCellType)cellType {
    _cellType = cellType;
    
    switch (self.cellType) {
        case Type_Today:
            _dayLabel.textColor = [UIColor yellowColor];
            _dayLabel.backgroundColor = [UIColor redColor];
            break;
            
        case Type_TodayForMonth:
            _dayLabel.textColor = [UIColor darkGrayColor];
            break;
            
        case Type_NO_TodayMonth:
            _dayLabel.textColor = [UIColor lightGrayColor];
            self.userInteractionEnabled = NO;
            
            break;
            
        default:
            break;
    }
}

- (void) setCell_date:(NSDate *)cell_date {
    _cell_date = cell_date;
    NSCalendar *calender = [NSCalendar currentCalendar];
    NSDateComponents *components = [calender components:NSCalendarUnitDay|NSCalendarUnitMonth|NSCalendarUnitYear fromDate:cell_date];
    _dayLabel.text = [NSString stringWithFormat:@"%ld",components.day];
    if ([cell_date confirmEqualToDate:[NSDate date]]) {
        _dayLabel.textColor = [UIColor whiteColor];
        _dayLabel.backgroundColor = [UIColor redColor];
    }
    else {
        _dayLabel.backgroundColor = [UIColor whiteColor];
        _dayLabel.textColor = [UIColor lightGrayColor];
    }
}

@end

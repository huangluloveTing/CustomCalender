//
//  HLCalenderCollectionViewCell.h
//  CustomCalenderView
//
//  Created by 黄露 on 2017/1/24.
//  Copyright © 2017年 黄露. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger , CalenderCellType) {
    Type_Today = 1,         //今天
    Type_TodayForMonth,     //当前月
    Type_NO_TodayMonth      //不在当前月
};

@interface HLCalenderCollectionViewCell : UICollectionViewCell

/**
 *  cell 的现实状态
 */

@property (nonatomic ,assign) CalenderCellType cellType;

/**
 *  cell 里的时间
 */
@property (nonatomic ,strong , readwrite) NSDate * cell_date;


@end

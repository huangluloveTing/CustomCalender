//
//  HLCalenderView.m
//  CustomCalenderView
//
//  Created by 黄露 on 2017/1/24.
//  Copyright © 2017年 黄露. All rights reserved.
//

#import "HLCalenderView.h"
#import "HLCalenderCollectionViewCell.h"
#import "NSDate+HLCalender.h"

@interface HLCalenderView ()<UICollectionViewDelegate , UICollectionViewDataSource ,UIScrollViewDelegate>

/**
 *      左边的日历表格
 */
@property (nonatomic ,strong) UICollectionView *calenderView_L;

/**
 *      中间的日历表格
 */
@property (nonatomic ,strong) UICollectionView *calenderView_M;

/**
 *      右边的日历表格
 */
@property (nonatomic ,strong) UICollectionView *calenderView_R;

@property (nonatomic ,strong) NSDate *cuurentDate;

//数组， 保存左边，中间 ， 右边的collectionView应该要现实的日期的对象NSDate
@property (nonatomic ,strong) NSMutableArray<NSDate *> *dates;


@end

@implementation HLCalenderView

- (instancetype) initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.delegate = self;
        self.showsHorizontalScrollIndicator = NO;
        self.cuurentDate = [NSDate date];
        self.dates = [NSMutableArray array];
        [self.dates addObject:[self.cuurentDate preMonth]];
        [self.dates addObject:self.cuurentDate];
        [self.dates addObject:[self.cuurentDate nextMonth]];
        [self configViews];
        
    }
    
    return self;
}

- (void)configViews {
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    CGFloat itemWidth = CGRectGetWidth(self.frame) / 7;
    CGFloat itemHeight = CGRectGetHeight(self.frame) / 6;
    flowLayout.itemSize = CGSizeMake(itemWidth, itemHeight);
    flowLayout.minimumInteritemSpacing = 0;
    flowLayout.minimumLineSpacing = 0;
    CGRect frame_L = CGRectMake(0, 0, CGRectGetWidth(self.frame), CGRectGetHeight(self.frame));
    _calenderView_L = [[UICollectionView alloc] initWithFrame:frame_L collectionViewLayout:flowLayout];
    [self addSubview:self.calenderView_L];
    
    CGRect frame_M = CGRectMake(CGRectGetWidth(self.frame), 0, CGRectGetWidth(self.frame), CGRectGetHeight(self.frame));
    _calenderView_M = [[UICollectionView alloc] initWithFrame:frame_M collectionViewLayout:flowLayout];
    [self addSubview:self.calenderView_M];
    
    CGRect frame_R = CGRectMake(CGRectGetWidth(self.frame) * 2, 0, CGRectGetWidth(self.frame), CGRectGetHeight(self.frame));
    _calenderView_R = [[UICollectionView alloc] initWithFrame:frame_R collectionViewLayout:flowLayout];
    [self addSubview:self.calenderView_R];
    
    [self setContentSize:CGSizeMake(CGRectGetWidth(self.frame) * 3, CGRectGetHeight(self.frame))];
    [self setContentOffset:CGPointMake(CGRectGetWidth(self.frame), 0)];
    self.calenderView_R.backgroundColor = [UIColor whiteColor];
    self.calenderView_M.backgroundColor = [UIColor whiteColor];
    self.calenderView_L.backgroundColor = [UIColor whiteColor];
    [self.calenderView_L registerClass:[HLCalenderCollectionViewCell class] forCellWithReuseIdentifier:@"cellday"];
    [self.calenderView_R registerClass:[HLCalenderCollectionViewCell class] forCellWithReuseIdentifier:@"cellday"];
    [self.calenderView_M registerClass:[HLCalenderCollectionViewCell class] forCellWithReuseIdentifier:@"cellday"];
    self.calenderView_L.delegate = self;
    self.calenderView_L.dataSource = self;
    
    self.calenderView_M.delegate = self;
    self.calenderView_M.dataSource = self;
    
    self.calenderView_R.delegate = self;
    self.calenderView_R.dataSource = self;
}

#pragma mark - UICollectionView   dateSource and Delegate
- (NSInteger) collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 42;
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    HLCalenderCollectionViewCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cellday" forIndexPath:indexPath];
    if (collectionView == self.calenderView_L) {
        
        NSDate *preDate = [self.dates objectAtIndex:0];
        
        //获取这个月的第一天是星期几，从零开始，即0 - 星期日， 1 - 星期一
        NSInteger firstDayWeek = [preDate theFirstDayForWeekDay];   //从零开始
        
        /**
         *当这个月的第一天在第几列，就是这个月的第一天的星期几所决定的，即星期日就在第一列,firstDayWeek = 0，对应的indexPath.row = 0,星期三，在第四列，firstWeek = 4，indexPath.row = 3
         */
        if (indexPath.row >= firstDayWeek && indexPath.row < ([preDate totalDaysForMonth] + [preDate theFirstDayForWeekDay])) {
            
            /**
             *计算indexPath.row 对应的几月几日
             */
            NSInteger day = indexPath.row - [preDate theFirstDayForWeekDay] + 1;
            
            /**
             * 根据天数，求这天对应的日期，并把日期传到cell 里
             */
            cell.cell_date = [preDate specialDateWithDay:day];
            cell.cellType = Type_TodayForMonth;
        }
        
        if (indexPath.row < [preDate theFirstDayForWeekDay]) {
            NSDate *prepreDate = [preDate preMonth];
            NSInteger day = [prepreDate totalDaysForMonth] - ([preDate theFirstDayForWeekDay] - indexPath.row - 1);
            cell.cell_date = [prepreDate specialDateWithDay:day];
            cell.cellType = Type_NO_TodayMonth;
        }
        
        if (indexPath.row >=  ([preDate totalDaysForMonth] + [preDate theFirstDayForWeekDay] - 1)) {
            NSInteger day = indexPath.row - ([preDate totalDaysForMonth] + [preDate theFirstDayForWeekDay]) + 1;
            cell.cell_date = [[preDate nextMonth] specialDateWithDay:day];
            cell.cellType = Type_NO_TodayMonth;
        }
        
        return cell;
    }
    
    if (collectionView == self.calenderView_M) {
        NSDate *m_date = [self.dates objectAtIndex:1];
        NSInteger firstDayWeek = [m_date theFirstDayForWeekDay];   //从零开始
        
        if (indexPath.row >= firstDayWeek && indexPath.row < ([m_date totalDaysForMonth] + [m_date theFirstDayForWeekDay])) {
            NSInteger day = indexPath.row - [m_date theFirstDayForWeekDay] + 1;
            cell.cell_date = [m_date specialDateWithDay:day];
            cell.cellType = Type_TodayForMonth;
        }
        
        if (indexPath.row < [m_date theFirstDayForWeekDay]) {
            NSDate *preDate = [m_date preMonth];
            NSInteger day = [preDate totalDaysForMonth] - ([m_date theFirstDayForWeekDay] - indexPath.row - 1);
            cell.cell_date = [preDate specialDateWithDay:day];
            cell.cellType = Type_NO_TodayMonth;
        }
        
        if (indexPath.row >=  ([m_date totalDaysForMonth] + [m_date theFirstDayForWeekDay])) {
            NSInteger day = indexPath.row - ([m_date totalDaysForMonth] + [m_date theFirstDayForWeekDay]) + 1;
            cell.cell_date = [[m_date nextMonth] specialDateWithDay:day];
            cell.cellType = Type_NO_TodayMonth;
        }
        
        return cell;

    }
    
    if (collectionView == self.calenderView_R) {
        
        NSDate *nextDate = [self.dates objectAtIndex:2];
        
        NSInteger firstDayWeek = [nextDate theFirstDayForWeekDay];   //从零开始
        
        if (indexPath.row >= firstDayWeek && indexPath.row < ([nextDate totalDaysForMonth] + [nextDate theFirstDayForWeekDay])) {
            NSInteger day = indexPath.row - [nextDate theFirstDayForWeekDay] + 1;
            cell.cell_date = [nextDate specialDateWithDay:day];
            cell.cellType = Type_TodayForMonth;
        }
        
        if (indexPath.row < [nextDate theFirstDayForWeekDay]) {
            NSDate *preDate = [nextDate preMonth];
            NSInteger day = [preDate totalDaysForMonth] - ([nextDate theFirstDayForWeekDay] - indexPath.row - 1);
            cell.cell_date = [preDate specialDateWithDay:day];
            cell.cellType = Type_NO_TodayMonth;
        }
        
        if (indexPath.row >=  ([nextDate totalDaysForMonth] + [nextDate theFirstDayForWeekDay] - 1)) {
            NSInteger day = indexPath.row - ([nextDate totalDaysForMonth] + [nextDate theFirstDayForWeekDay]) + 1;
            cell.cell_date = [[nextDate nextMonth] specialDateWithDay:day];
            cell.cellType = Type_NO_TodayMonth;
        }
        
        return cell;
        
    }
    
    return cell;
}


//滑动scrollView停止
- (void) scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    if (scrollView == self) {
        if (scrollView.contentOffset.x < CGRectGetWidth(scrollView.frame)) {
            NSDate *currentDate = [self.dates objectAtIndex:0];
            [self.dates removeAllObjects];
            [self.dates addObject:[currentDate preMonth]];
            [self.dates addObject:currentDate];
            [self.dates addObject:[currentDate nextMonth]];
        }
        
        if (scrollView.contentOffset.x > CGRectGetWidth(self.frame)) {
            self.cuurentDate = [self.dates objectAtIndex:2];
            [self.dates removeAllObjects];
            [self.dates addObject:[self.cuurentDate preMonth]];
            [self.dates addObject:self.cuurentDate];
            [self.dates addObject:[self.cuurentDate nextMonth]];
        }
        
        [self.calenderView_L reloadData];
        [self.calenderView_M reloadData];
        [self.calenderView_R reloadData];
        [scrollView setContentOffset:CGPointMake(CGRectGetWidth(self.frame), 0) animated:NO];
    }
}

- (void) collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    [collectionView deselectItemAtIndexPath:indexPath animated:YES];
    if (collectionView == self.calenderView_M) {
        HLCalenderCollectionViewCell *cell = (HLCalenderCollectionViewCell*)[self.calenderView_M cellForItemAtIndexPath:indexPath];
        NSLog(@"item date : %@",cell.cell_date);
    }
    
}

@end

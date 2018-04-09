//
//  CLCalendarDayView.m
//  CLCalendar
//
//  Created by JmoVxia on 2018/4/9.
//  Copyright © 2018年 JmoVxia. All rights reserved.
//

#import "CLCalendarDayView.h"
#import "Masonry.h"
#import "UIView+CLSetRect.h"

@interface CLCalendarDayView ()

@property (nonatomic, assign) NSInteger currentYear;
@property (nonatomic, assign) NSInteger currentMonth;
@property (nonatomic, assign) NSInteger currentDay;
@property (nonatomic, assign) NSInteger year;
@property (nonatomic, assign) NSInteger month;
@property (nonatomic, assign) NSInteger day;
@property (nonatomic, copy) DataChangeBlock data;

@end

@implementation CLCalendarDayView

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        
        [self getCurrentTime];
        
        [self initUI];

        [self reloadData];

    }
    return self;
}
- (void)getCurrentTime{
 
    NSDateComponents *components = [[NSCalendar currentCalendar] components:NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitHour | NSCalendarUnitMinute fromDate:[NSDate date]];
    _year = [components year];
    _month = [components month];
    _day = [components day];
}
- (void)initUI{
    //每一个日期用一个按钮去创建，当一个月的第一天是星期六并且有31天时为最多个数，5行零2个，共37个
    for (int i = 0; i < 37; i++) {
        UIButton *dayButton = [[UIButton alloc] init];
        dayButton.tag = i + 10097;
        
        [dayButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [dayButton setTitleColor:[UIColor redColor] forState:UIControlStateSelected];
        [self addSubview:dayButton];
        CGFloat btnX = i % 7 * CLscreenWidth / 7.0;
        CGFloat btnY = i / 7 * CLscreenWidth / 7.0;
        [dayButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.height.mas_equalTo(CLscreenWidth / 7.0);
            make.left.mas_equalTo(btnX);
            make.top.mas_equalTo(btnY);
        }];
    }
}

- (void)leftMonth{
    if (self.month == 1) {
        self.year --;
        self.month = 12;
    }else {
        self.month --;
    }
    [self reloadData];
}
- (void)rightMonth{
    if (self.month == 12) {
        self.year ++;
        self.month = 1;
    }else {
        self.month ++;
    }
    [self reloadData];
}

//刷新数据
- (void)reloadData
{
    NSInteger totalDays = [self numberOfDaysInMonth];
    NSInteger firstDay = [self firstDayOfWeekInMonth];
    
    if (self.data) {
        self.data([NSString stringWithFormat:@"%ld年%ld月", _year,_month]);
    }
    
    for (int i = 0; i < 37; i++) {
        UIButton *btn = (UIButton *)[self viewWithTag:i + 10097];
        btn.selected = NO;
        if (i < firstDay - 1 || i > totalDays + firstDay - 2) {
            btn.enabled = NO;
            [btn setTitle:@"" forState:UIControlStateNormal];
        }else {
            if (_year == _currentYear && _month == _currentMonth) {
                if (btn.tag - 10097 - (firstDay - 2) == _currentDay) {
                    btn.selected = YES;
                    _day = _currentDay;
                }
            }else {
                if (i == firstDay - 1) {
                    btn.selected = YES;
                    _day = btn.tag - 10097 - (firstDay - 2);
                }
            }
            btn.enabled = YES;
            [btn setTitle:[NSString stringWithFormat:@"%ld", i - (firstDay - 1) + 1] forState:UIControlStateNormal];
        }
    }
}

- (void)dataChange:(DataChangeBlock)data{
    self.data = data;
}

//获取目标月份的天数
- (NSInteger)numberOfDaysInMonth
{
    //获取选中日期月份的天数
    return [[NSCalendar currentCalendar] rangeOfUnit:NSCalendarUnitDay inUnit:NSCalendarUnitMonth forDate:[self getSelectDate]].length;
}

//获取目标月份第一天星期几
- (NSInteger)firstDayOfWeekInMonth
{
    //获取选中日期月份第一天星期几，因为默认日历顺序为“日一二三四五六”，所以这里返回的1对应星期日，2对应星期一，依次类推
    return [[NSCalendar currentCalendar] ordinalityOfUnit:NSCalendarUnitDay inUnit:NSCalendarUnitWeekOfYear forDate:[self getSelectDate]];
}
//根据选中日期，获取相应NSDate
- (NSDate *)getSelectDate
{
    //初始化NSDateComponents，设置为选中日期
    NSDateComponents *dateComponents = [[NSDateComponents alloc] init];
    dateComponents.year = _year;
    dateComponents.month = _month;
    
    return [[[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian] dateFromComponents:dateComponents];
}


@end

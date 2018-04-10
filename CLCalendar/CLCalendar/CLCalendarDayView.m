//
//  CLCalendarDayView.m
//  CLCalendar
//
//  Created by JmoVxia on 2018/4/9.
//  Copyright © 2018年 JmoVxia. All rights reserved.
//

#import "CLCalendarDayView.h"
#import "CLCalendarDayButton.h"
#import "Masonry.h"
#import "UIView+CLSetRect.h"

@interface CLCalendarDayView ()
//记录当天年月日
@property (nonatomic, assign) NSInteger year;
@property (nonatomic, assign) NSInteger month;
@property (nonatomic, assign) NSInteger day;
//显示的年月日
@property (nonatomic, assign) NSInteger showYear;
@property (nonatomic, assign) NSInteger showMonth;
@property (nonatomic, assign) NSInteger showDay;
//选中的时间回调
@property (nonatomic, copy) DataChangeBlock data;
/**记录选中年*/
@property (nonatomic, assign) NSInteger selectedYear;
/**记录选中月*/
@property (nonatomic, assign) NSInteger selectedMonth;
/**记录选中日*/
@property (nonatomic, assign) NSInteger selectedDay;
/**不可以选择的日期数组*/
@property (nonatomic, strong) NSArray *noSelectedArray;

@end

@implementation CLCalendarDayView

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self initUI];
        [self getCurrentTime];
        [self reloadData];
    }
    return self;
}
- (void)getCurrentTime{
    NSDateComponents *components = [[NSCalendar currentCalendar] components:NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitHour | NSCalendarUnitMinute fromDate:[NSDate date]];
    _showYear = [components year];
    _showMonth = [components month];
    _showDay = [components day];
    _year = [components year];
    _month = [components month];
    _day = [components day];
    [self getDataSource];
}
- (void)getDataSource{
    NSLog(@"%@",[NSString stringWithFormat:@"%ld年%ld月", _showYear,_showMonth]);
    self.noSelectedArray = [NSArray array];
    self.noSelectedArray = @[@"3",@"4",@"8",@"12"];
}
- (void)initUI{
    //每一个日期用一个按钮去创建，当一个月的第一天是星期六并且有31天时为最多个数，5行零2个，共37个
    for (int i = 0; i < 37; i++) {
        CLCalendarDayButton *dayButton = [[CLCalendarDayButton alloc] init];
        dayButton.tag = i + 10097;
        [dayButton addTarget:self action:@selector(dayAction:) forControlEvents:UIControlEventTouchUpInside];
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
- (void)dayAction:(CLCalendarDayButton *)button{
    self.selectedYear = self.showYear;
    self.selectedMonth = self.showMonth;
    self.selectedDay = [button.titleLabel.text integerValue];
    [self reloadData];
}
- (void)leftMonth{
    if (self.showMonth == 1) {
        self.showYear --;
        self.showMonth = 12;
    }else {
        self.showMonth --;
    }
    NSLog(@"%@",[NSString stringWithFormat:@"%ld年%ld月", _showYear,_showMonth]);
    [self reloadData];
}
- (void)rightMonth{
    if (self.showMonth == 12) {
        self.showYear ++;
        self.showMonth = 1;
    }else {
        self.showMonth ++;
    }
    NSLog(@"%@",[NSString stringWithFormat:@"%ld年%ld月", _showYear,_showMonth]);
    [self reloadData];
}
//刷新数据
- (void)reloadData{
    NSInteger totalDays = [self numberOfDaysInMonth];
    NSInteger firstDay = [self firstDayOfWeekInMonth];
    if (self.data) {
        self.data([NSString stringWithFormat:@"%ld年%ld月", _showYear,_showMonth]);
    }
    for (int i = 0; i < 37; i++) {
        CLCalendarDayButton *btn = (CLCalendarDayButton *)[self viewWithTag:i + 10097];
        btn.selected = NO;
        btn.themeColor = [UIColor clearColor];
        if (i < firstDay - 1 || i > totalDays + firstDay - 2) {
            btn.enabled = NO;
            [btn setTitle:@"" forState:UIControlStateNormal];
        }else {
            btn.enabled = YES;
            [btn setTitle:[NSString stringWithFormat:@"%ld", i - (firstDay - 1) + 1] forState:UIControlStateNormal];
            [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            [btn setTitleColor:[UIColor blackColor] forState:UIControlStateSelected];
            //找出当天
            if (_showYear == _year && _showMonth == _month && ([btn.titleLabel.text integerValue]) == _day) {
                [btn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
                [btn setTitleColor:[UIColor redColor] forState:UIControlStateSelected];
            }
            //找出选中日期
            if (_showYear == _selectedYear && _showMonth == _selectedMonth && ([btn.titleLabel.text integerValue]) == _selectedDay) {
                btn.selected = YES;
                btn.themeColor = [UIColor colorWithRed:173/255.0f green:212/255.0f blue:208/255.0f alpha:1.0f];
            }
            //找出不能够选择的日期
            if ([self.noSelectedArray containsObject:btn.titleLabel.text]) {
                btn.enabled = NO;
                btn.themeColor = [UIColor lightGrayColor];
            }
        }
    }
}
- (void)dataChange:(DataChangeBlock)data{
    self.data = data;
}
//获取目标月份的天数
- (NSInteger)numberOfDaysInMonth{
    //获取选中日期月份的天数
    return [[NSCalendar currentCalendar] rangeOfUnit:NSCalendarUnitDay inUnit:NSCalendarUnitMonth forDate:[self getSelectDate]].length;
}
//获取目标月份第一天星期几
- (NSInteger)firstDayOfWeekInMonth{
    //获取选中日期月份第一天星期几，因为默认日历顺序为“日一二三四五六”，所以这里返回的1对应星期日，2对应星期一，依次类推
    return [[NSCalendar currentCalendar] ordinalityOfUnit:NSCalendarUnitDay inUnit:NSCalendarUnitWeekOfYear forDate:[self getSelectDate]];
}
//根据选中日期，获取相应NSDate
- (NSDate *)getSelectDate{
    //初始化NSDateComponents，设置为选中日期
    NSDateComponents *dateComponents = [[NSDateComponents alloc] init];
    dateComponents.year = _showYear;
    dateComponents.month = _showMonth;
    return [[[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian] dateFromComponents:dateComponents];
}


@end

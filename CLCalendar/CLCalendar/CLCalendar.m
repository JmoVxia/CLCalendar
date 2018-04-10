//
//  CLCalendar.m
//  CLCalendar
//
//  Created by JmoVxia on 2018/4/9.
//  Copyright © 2018年 JmoVxia. All rights reserved.
//

#import "CLCalendar.h"
#import "CLCalendarToolBar.h"
#import "CLCalendarDayView.h"
#import "CLCalendarWeekView.h"
#import "UIView+CLSetRect.h"
#import "Masonry.h"

@interface CLCalendar ()

/**工具条*/
@property (nonatomic, weak) CLCalendarToolBar *toolBar;
/**周*/
@property (nonatomic, weak) CLCalendarWeekView *weekView;
/**日*/
@property (nonatomic, weak) CLCalendarDayView *dayView;

@end

@implementation CLCalendar

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        //创建控件
        [self initUI];
        //约束
        [self makeConstraints];
//        self.backgroundColor = RandomColor;
    }
    return self;
}
- (void)initUI{
    //工具条
    CLCalendarToolBar *toolBar = [[CLCalendarToolBar alloc] init];
    [self addSubview:toolBar];
    self.toolBar = toolBar;
    //周
    CLCalendarWeekView *weekView = [[CLCalendarWeekView alloc] init];
    [self addSubview:weekView];
    self.weekView = weekView;
    //日
    CLCalendarDayView *dayView = [[CLCalendarDayView alloc] init];
    [self addSubview:dayView];
    self.dayView = dayView;
    
    [self.toolBar leftBlcokAction:^{
        [self.dayView leftMonth];
    }];
    
    [self.toolBar rightBlcokAction:^{
        [self.dayView rightMonth];
    }];
    
    [self.dayView dataChange:^(NSString *dataString) {
        self.toolBar.yearMonthString = dataString;
    }];

}

- (void)makeConstraints{
    
    [self.toolBar mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.mas_equalTo(self);
        make.height.mas_equalTo(50);
    }];
    
    [self.weekView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(self);
        make.top.mas_equalTo(self.toolBar.mas_bottom);
        make.height.mas_equalTo(CLscreenWidth / 7.0);
    }];
    
    [self.dayView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.bottom.right.mas_equalTo(self);
        make.top.mas_equalTo(self.weekView.mas_bottom);
    }];
}






























@end

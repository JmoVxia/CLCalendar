//
//  CLCalendarToolBar.m
//  CLCalendar
//
//  Created by JmoVxia on 2018/4/9.
//  Copyright © 2018年 JmoVxia. All rights reserved.
//

#import "CLCalendarToolBar.h"
#import "UIView+CLSetRect.h"
#import "Masonry.h"

@interface CLCalendarToolBar ()

/**上一月*/
@property (nonatomic, weak) UIButton *leftButton;
/**年月*/
@property (nonatomic, weak) UILabel *yearMonthLabel;
/**下一月*/
@property (nonatomic, weak) UIButton *rightButton;
/**上月Block*/
@property (nonatomic, copy) LeftBlock left;
/**下月Block*/
@property (nonatomic, copy) RightBlock right;

@end

@implementation CLCalendarToolBar

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self initUI];
    }
    return self;
}
#pragma mark - 创建控件
- (void)initUI{
    //左侧按钮
    UIButton *leftButton = [[UIButton alloc] init];
    [leftButton setImage:[UIImage imageNamed:@"leftArrow"] forState:UIControlStateNormal];
    [leftButton setImage:[UIImage imageNamed:@"leftArrow"] forState:UIControlStateSelected];
    [leftButton addTarget:self action:@selector(leftAction:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:leftButton];
    self.leftButton = leftButton;
    //中间日期Label
    UILabel *yearMonthLabel = [[UILabel alloc] init];
    NSDateComponents *components = [[NSCalendar currentCalendar] components:NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitHour | NSCalendarUnitMinute fromDate:[NSDate date]];
    yearMonthLabel.text = [NSString stringWithFormat:@"%ld年%ld月",[components year],[components month]];
    [self addSubview:yearMonthLabel];
    self.yearMonthLabel = yearMonthLabel;
    //右侧按钮
    UIButton *rightButton = [[UIButton alloc] init];
    [rightButton setImage:[UIImage imageNamed:@"rightArrow"] forState:UIControlStateNormal];
    [rightButton setImage:[UIImage imageNamed:@"rightArrow"] forState:UIControlStateSelected];
    [rightButton addTarget:self action:@selector(rightAction:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:rightButton];
    self.rightButton = rightButton;
    //约束
    [self makeConstraints];
}
#pragma mark - 约束
- (void)makeConstraints{
    [self.leftButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(15);
        make.top.bottom.mas_equalTo(self);
        make.width.mas_equalTo(self.leftButton.mas_height);
    }];
    [self.yearMonthLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self);
        make.top.bottom.mas_equalTo(self);
    }];
    [self.rightButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(-15);
        make.top.bottom.mas_equalTo(self);
        make.width.mas_equalTo(self.rightButton.mas_height);
    }];
}
- (void)leftAction:(UIButton *)left{
    if (self.left) {
        self.left();
    }
}
- (void)rightAction:(UIButton *)right{
    if (self.right) {
        self.right();
    }
}
- (void)leftBlcokAction:(LeftBlock)left{
    self.left = left;
}
- (void)rightBlcokAction:(RightBlock)right{
    self.right = right;
}
-(void)setYearMonthString:(NSString *)yearMonthString{
    _yearMonthString = yearMonthString;
    self.yearMonthLabel.text = _yearMonthString;
}





@end

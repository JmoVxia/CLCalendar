//
//  CLCalendarWeekView.m
//  CLCalendar
//
//  Created by JmoVxia on 2018/4/9.
//  Copyright © 2018年 JmoVxia. All rights reserved.
//

#import "CLCalendarWeekView.h"
#import "Masonry.h"
#import "UIView+CLSetRect.h"
@implementation CLCalendarWeekView
-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self initUI];
    }
    return self;
}
- (void)initUI{
    NSArray *weakArray = @[@"日", @"一", @"二", @"三", @"四", @"五", @"六"];
    UILabel *tempLabel;
    for (NSString *weakString in weakArray) {
        UILabel *weakLabel = [[UILabel alloc] init];
        weakLabel.textAlignment = NSTextAlignmentCenter;
        weakLabel.text = weakString;
        [self addSubview:weakLabel];
        [weakLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.bottom.mas_equalTo(self);
            make.width.mas_equalTo(CLscreenWidth / 7.0);
            if (tempLabel) {
                make.left.mas_equalTo(tempLabel.mas_right);
            }else{
                make.left.mas_equalTo(0);
            }
        }];
        tempLabel = weakLabel;
    }
}

@end

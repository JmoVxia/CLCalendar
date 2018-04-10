//
//  CLCalendarDayButton.m
//  CLCalendar
//
//  Created by JmoVxia on 2018/4/10.
//  Copyright © 2018年 JmoVxia. All rights reserved.
//

#import "CLCalendarDayButton.h"
#import "Masonry.h"
#import "UIView+CLSetRect.h"

@interface CLCalendarDayButton ()

/**颜色View*/
@property (nonatomic, weak) UIView *colorView;

@end

@implementation CLCalendarDayButton

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self initUI];
        [self makeConstraints];
    }
    return self;
}
- (void)initUI{
    UIView *colorView = [[UIView alloc] init];
    [self addSubview:colorView];
    self.colorView = colorView;
    self.colorView.userInteractionEnabled = NO;
    //主线程
    dispatch_async(dispatch_get_main_queue(), ^{
        self.colorView.layer.cornerRadius = self.CLheight * 0.4;
    });
    self.colorView.clipsToBounds = YES;
}
- (void)makeConstraints{
    [self.colorView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.mas_equalTo(self);
        make.width.height.mas_equalTo(self.mas_height).multipliedBy(0.8);
    }];
}
-(void)setThemeColor:(UIColor *)themeColor{
    _themeColor = themeColor;
    self.colorView.backgroundColor = themeColor;
}
















@end

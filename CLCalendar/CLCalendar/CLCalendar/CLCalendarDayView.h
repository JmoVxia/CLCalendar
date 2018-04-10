//
//  CLCalendarDayView.h
//  CLCalendar
//
//  Created by JmoVxia on 2018/4/9.
//  Copyright © 2018年 JmoVxia. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^DataChangeBlock)(NSString *dataString);

@interface CLCalendarDayView : UIView
//刷新上月
- (void)reloadLeftMonth;
//刷新下月
- (void)reloadRightMonth;
//数据变化
- (void)dataChange:(DataChangeBlock)data;

@end

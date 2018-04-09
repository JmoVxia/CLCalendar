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

- (void)leftMonth;
- (void)rightMonth;

- (void)dataChange:(DataChangeBlock)data;

@end

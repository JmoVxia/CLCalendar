//
//  CLCalendarToolBar.h
//  CLCalendar
//
//  Created by JmoVxia on 2018/4/9.
//  Copyright © 2018年 JmoVxia. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^LeftBlock)(void);
typedef void(^RightBlock)(void);

@interface CLCalendarToolBar : UIView

/**年月*/
@property (nonatomic, copy) NSString *yearMonthString;
//上一月回调
- (void)leftBlcokAction:(LeftBlock)left;
//下一月回调
- (void)rightBlcokAction:(LeftBlock)right;

@end

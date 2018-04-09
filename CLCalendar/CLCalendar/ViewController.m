//
//  ViewController.m
//  CLCalendar
//
//  Created by JmoVxia on 2018/4/9.
//  Copyright © 2018年 JmoVxia. All rights reserved.
//

#import "ViewController.h"
#import "CLCalendar.h"
#import "UIView+CLSetRect.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    CLCalendar *calendar = [[CLCalendar alloc] initWithFrame:CGRectMake(0, 99, self.view.CLwidth, self.view.CLwidth + 50)];
    [self.view addSubview:calendar];




}



@end

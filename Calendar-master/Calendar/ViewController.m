//
//  ViewController.m
//  Calendar
//
//  Created by Onway on 2017/4/10.
//  Copyright © 2017年 Onway. All rights reserved.
//

#import "ViewController.h"
#import "BPPCalendar.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {

    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    BPPCalendar *calendarView = [[BPPCalendar alloc] initWithFrame:CGRectMake(0, 20, self.view.frame.size.width, self.view.frame.size.height*0.6) andType:NO];
    [self.view addSubview:calendarView];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end

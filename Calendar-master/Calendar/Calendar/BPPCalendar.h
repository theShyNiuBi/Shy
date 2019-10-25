//
//  BPPCalendar.h
//  Animation
//
//  Created by Onway on 2017/4/7.
//  Copyright © 2017年 Onway. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface BPPCalendar : UIView

/**
提示 可以创建日  或者 月 两种日历
type-> YES 日日历| NO 月日历
*/
- (instancetype)initWithFrame:(CGRect)frame andType:(BOOL)type;

@property (nonatomic ,assign)BOOL isDay;

/**
        注释。。。
*/

@end

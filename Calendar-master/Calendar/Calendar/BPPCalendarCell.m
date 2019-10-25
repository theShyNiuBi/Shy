//
//  BPPCalendarCell.m
//  Animation
//
//  Created by Onway on 2017/4/7.
//  Copyright © 2017年 Onway. All rights reserved.
//

#import "BPPCalendarCell.h"

@implementation BPPCalendarCell

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self layoutUI];
    }
    return self;
}

- (void)layoutUI {
    
    self.textLabel = [[UILabel alloc] initWithFrame:CGRectMake(0.5*(self.frame.size.width-38), 0.5*(self.frame.size.width-38), 38, 38)];
    self.textLabel.textAlignment = NSTextAlignmentCenter;
   // self.textLabel.backgroundColor = [UIColor redColor];
   // self.textLabel.textColor = [UIColor blueColor];
   // self.textLabel.text = @"sss";
    [self.contentView addSubview:self.textLabel];
    
    self.pointView = [[UIView alloc]initWithFrame:CGRectMake(self.bounds.size.width*0.5-4, CGRectGetMaxY(self.textLabel.frame)+7, 4, 4)];
    [self.pointView setBackgroundColor:[UIColor colorWithRed:255/255.0 green:132/255.0 blue:21/255.0 alpha:1.0]];
//    [self.contentView addSubview:self.pointView];
}

@end

//
//  ViewWithVertixView.m
//  circleDemo
//
//  Created by apple on 15/12/3.
//  Copyright © 2015年 apple. All rights reserved.
//

#import "ViewWithVertixView.h"

@implementation ViewWithVertixView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (!self) {
        self = nil;
    }
    
    self = [super initWithFrame:frame];
    
    CGFloat pointWidth = 0;
    
    _point1 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, pointWidth, pointWidth)];
    [self addSubview:_point1];
    _point2 = [[UIView alloc] initWithFrame:CGRectMake(frame.size.width, 0, pointWidth, pointWidth)];
    [self addSubview:_point2];
    _point3 = [[UIView alloc] initWithFrame:CGRectMake(frame.size.width, frame.size.height, pointWidth, pointWidth)];
    [self addSubview:_point3];
    _point4 = [[UIView alloc] initWithFrame:CGRectMake(0, frame.size.height, pointWidth, pointWidth)];
    [self addSubview:_point4];
    
//    _point1.backgroundColor = [UIColor blackColor];
//    _point2.backgroundColor = [UIColor blackColor];
//    _point3.backgroundColor = [UIColor blackColor];
//    _point4.backgroundColor = [UIColor blackColor];
    
    return self;
}

@end

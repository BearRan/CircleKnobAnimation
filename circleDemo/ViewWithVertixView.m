//
//  ViewWithVertixView.m
//  circleDemo
//
//  Created by apple on 15/12/3.
//  Copyright © 2015年 apple. All rights reserved.
//

#import "ViewWithVertixView.h"

@implementation ViewWithVertixView

static CGFloat pointWidth = 2.0f;

- (instancetype)initWithFrame:(CGRect)frame
{
    if (!self) {
        self = nil;
    }
    
    self = [super initWithFrame:frame];
    
    _point_V1 = [[UIView alloc] initWithFrame:CGRectMake(- pointWidth/2, - pointWidth/2, pointWidth, pointWidth)];
    [self setPointViewProperty:_point_V1];
    [self addSubview:_point_V1];
    
    _point_V2 = [[UIView alloc] initWithFrame:CGRectMake(frame.size.width - pointWidth/2, 0 - pointWidth/2, pointWidth, pointWidth)];
    [self setPointViewProperty:_point_V2];
    [self addSubview:_point_V2];
    
    _point_V3 = [[UIView alloc] initWithFrame:CGRectMake(frame.size.width - pointWidth/2, frame.size.height - pointWidth/2, pointWidth, pointWidth)];
    [self setPointViewProperty:_point_V3];
    [self addSubview:_point_V3];
    
    _point_V4 = [[UIView alloc] initWithFrame:CGRectMake(0 - pointWidth/2, frame.size.height - pointWidth/2, pointWidth, pointWidth)];
    [self setPointViewProperty:_point_V4];
    [self addSubview:_point_V4];
    
    _centerPointV = [[UIView alloc] initWithFrame:CGRectMake((frame.size.width - pointWidth)/2, (frame.size.height - pointWidth)/2, pointWidth, pointWidth)];
    [self setPointViewProperty:_centerPointV];
    [self addSubview:_centerPointV];
    
    return self;
}

- (void)setPointViewProperty:(UIView *)pointV
{
    pointV.backgroundColor = [UIColor blackColor];
    pointV.layer.cornerRadius = pointWidth/2.0f;
}

@end

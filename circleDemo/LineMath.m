//
//  LineMath.m
//  circleDemo
//
//  Created by apple on 15/12/3.
//  Copyright © 2015年 apple. All rights reserved.
//

#import "LineMath.h"

@implementation LineMath

- (instancetype)initWithPoint1:(CGPoint)point1 withPoint2:(CGPoint)point2
{

    if (!self) {
        self = nil;
    }
    
    if (point1.x == point2.x) {
        NSLog(@"斜率不存在!");
        _k = 0;
    }else{
        _k = (point2.y - point1.y) / (point2.x - point1.x);
    }
    
    _b = point2.y - _k * point2.x;
    
    self = [super init];
    return self;
}

@end

//
//  LineMath.h
//  circleDemo
//
//  Created by apple on 15/12/3.
//  Copyright © 2015年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

//  直线的表达式参数 y = k * x + b;
@interface LineMath : UIView

@property (assign, nonatomic) float k;  //斜率
@property (assign, nonatomic) float b;  //x＝0时,y的位置

- (instancetype)initWithPoint1:(CGPoint)point1 withPoint2:(CGPoint)point2;

@end

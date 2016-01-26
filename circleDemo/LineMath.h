//
//  LineMath.h
//  circleDemo
//
//  Created by apple on 15/12/3.
//  Copyright © 2015年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LineMath : UIView

@property (assign, nonatomic) float k;
@property (assign, nonatomic) float b;

- (instancetype)initWithPoint1:(CGPoint)point1 withPoint2:(CGPoint)point2;

@end

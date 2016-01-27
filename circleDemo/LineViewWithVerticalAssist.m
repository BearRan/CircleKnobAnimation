//
//  LineViewWithVerticalAssist.m
//  circleDemo
//
//  Created by apple on 15/12/3.
//  Copyright © 2015年 apple. All rights reserved.
//

#import "LineViewWithVerticalAssist.h"
#import "UIView+MySet.h"

@implementation LineViewWithVerticalAssist

- (instancetype)initWithFrame:(CGRect)frame
{
    if (!self) {
        self = nil;
    }
    
    self = [super initWithFrame:frame];
    
    return self;
}

- (void)drawRect:(CGRect)rect
{
    [super drawRect:rect];
    
    //和光源的连线
    [self drawLineWithPoint1:_point_FinalCenter withPoint2:_point_LightSource];
    //和光源连线的反向延长线
    [self drawLineWithOriginPoint:_point_FinalCenter withLine:_line_LightToFinal withLength:-3 needSetShaowPoint:YES];

    //垂直平分线
    [self drawLineWithOriginPoint:_point_FinalCenter withLine:_line_PerBise withLength:_length_PerBise needSetShaowPoint:NO];
    //垂直平分线反向延长线
    BOOL drawFullLine = YES;
    if (drawFullLine) {
        [self drawLineWithOriginPoint:_point_FinalCenter withLine:_line_PerBise withLength:-_length_PerBise needSetShaowPoint:NO];
    }
}


//根据两点绘制一条直线
- (void)drawLineWithPoint1:(CGPoint)point1 withPoint2:(CGPoint)point2
{
    if (drawAssistLine == NO) {
        return;
    }
    
    //1.获得图形上下文
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    //将上下文复制一份到栈中
    CGContextSaveGState(context);
    
    //2.绘制图形
    //第一条线
    //设置线段宽度
    CGContextSetLineWidth(context, 0.5);
    //设置线条头尾部的样式
    CGContextSetLineCap(context, kCGLineCapRound);
    
    //设置颜色
    CGContextSetStrokeColorWithColor(context, [UIColor purpleColor].CGColor);
    //设置起点
    CGContextMoveToPoint(context, point1.x, point1.y);
    //画线
    CGContextAddLineToPoint(context, point2.x, point2.y);
    
    //3.显示到View
    CGContextStrokePath(context);//以空心的方式画出
    
    //将图形上下文出栈，替换当前的上下文
    CGContextRestoreGState(context);
}


- (void)drawLineWithOriginPoint:(CGPoint)point withLine:(LineMath *)line withLength:(CGFloat)length needSetShaowPoint:(BOOL)needSetShaowPoint
{
    //斜率转换成角度
    CGFloat angle = atan(line.k);
    CGFloat y2;
    CGFloat x2;
    int i = angle > 0 ? -1 : 1;
    
    CGFloat radius = radiansToDegrees(angle);
    
//    if (radius != 0) {
//        
//        
//        
//        CGFloat sin1 = sin(radius);
//        CGFloat cos1 = cos(radius);
//        
////        NSLog(@"radius:%f", radius);
////        NSLog(@"sin1:%f", sin1);
////        NSLog(@"cos1:%f", cos1);
////        NSLog(@"angle:%f", angle);
//        
////        NSLog(@"--");
//    }
    
    
    CGFloat sin1 = sin(radius);
    CGFloat cos1 = cos(radius);

    
    
//    if (radius == 0) {
//        NSLog(@"sin1:%f", sin1);
//        NSLog(@"cos1:%f", cos1);
//    }
    
    CGFloat ratioX = 1;
    CGFloat ratioY = 1;
    
    //左上象限
    if (_point_LightSource.x <= _point_FinalCenter.x && _point_LightSource.y < _point_FinalCenter.y) {
        ratioX = -1;
        ratioY = -1;
//        NSLog(@"左上 -1");
    }
    //右上象限
    else if (_point_LightSource.x > _point_FinalCenter.x && _point_LightSource.y < _point_FinalCenter.y){
        ratioX = 1;
        ratioY = 1;
//        NSLog(@"右上 +1");
    }
    //左下象限
    else if (_point_LightSource.x <= _point_FinalCenter.x && _point_LightSource.y > _point_FinalCenter.y){
        ratioX = -1;
        ratioY = -1;
//        NSLog(@"左下 -1");
    }
    //右下象限
    else if (_point_LightSource.x > _point_FinalCenter.x && _point_LightSource.y > _point_FinalCenter.y){
        ratioX = 1;
        ratioY = 1;
//        NSLog(@"右下 +1");
    }
    
    
    //反向延长线的点
    y2 = point.y + ratioY * sin(angle)*length;
    x2 = point.x + ratioX * cos(angle)*length;
    
    if (length == -3) {
        //左
        if (_point_LightSource.x < _point_FinalCenter.x && _point_LightSource.y == _point_FinalCenter.y) {
            x2 = point.x + (-1) * length;
            //y2 = point.y;
//            NSLog(@"左 －1  x2:%f, point.x%f, length:%f", x2, point.x, length);
        }
        //右
        else if (_point_LightSource.x > _point_FinalCenter.x && _point_LightSource.y == _point_FinalCenter.y){
            x2 = point.x + (+1) * length;
            //y2 = point.y;
//            NSLog(@"右 ＋1  x2:%f, point.x%f, length:%f", x2, point.x, length);
        }
        //上
        else if (_point_LightSource.x == _point_FinalCenter.x && _point_LightSource.y < _point_FinalCenter.y){
            x2 = point.x;
            y2 = point.y + (-1) * length;
//            NSLog(@"上 ＋1  y2:%f, point.y%f, length:%f", y2, point.y, length);
        }
        //下
        else if (_point_LightSource.x == _point_FinalCenter.x && _point_LightSource.y > _point_FinalCenter.y){
            x2 = point.x;
            y2 = point.y + (+1) * length;
//            NSLog(@"下 -1  y2:%f, point.y%f, length:%f", y2, point.y, length);
        }
    }
    else{
        //左
        if (_point_LightSource.x < _point_FinalCenter.x && _point_LightSource.y == _point_FinalCenter.y) {
//            x2 = point.x + (-1) * length;
//            NSLog(@"左 －1  x2:%f, point.x%f, length:%f", x2, point.x, length);
        }
        //右
        else if (_point_LightSource.x > _point_FinalCenter.x && _point_LightSource.y == _point_FinalCenter.y){
//            x2 = point.x + (+1) * length;
//            NSLog(@"右 ＋1  x2:%f, point.x%f, length:%f", x2, point.x, length);
        }
        //上
        else if (_point_LightSource.x == _point_FinalCenter.x && _point_LightSource.y < _point_FinalCenter.y){
//            y2 = point.y + (-1) * length;
//            NSLog(@"上 ＋1  y2:%f, point.y%f, length:%f", y2, point.y, length);
        }
        //下
        else if (_point_LightSource.x == _point_FinalCenter.x && _point_LightSource.y > _point_FinalCenter.y){
//            y2 = point.y + (+1) * length;
//            NSLog(@"下 -1  y2:%f, point.y%f, length:%f", y2, point.y, length);
        }
    }
    
    
    CGPoint point2 = CGPointMake(x2, y2);
    
    if ([line isEqual:_line_PerBise]) {
        NSLog(@"point:%@", NSStringFromCGPoint(point));
        NSLog(@"point2:%@", NSStringFromCGPoint(point2));
        NSLog(@"sin(angle):%f", sin(angle));
        NSLog(@"cos(angle):%f", cos(angle));
        NSLog(@"--");
    }
    
    //绘制线
    [self drawLineWithPoint1:point withPoint2:point2];
    
    //给代理返回 计算出的阴影center
    if (needSetShaowPoint) {
        if ([_getDelegate respondsToSelector:@selector(getShadowPoint:tempView:)]) {
            [_getDelegate getShadowPoint:point2 tempView:_perBiseView_Base];
        }
    }
}

//point:{187.5, 333.5}
//point2:{212.5, 358.5}

#pragma mark Rewrite Method

@synthesize line_LightToFinal = _line_LightToFinal;
- (void)setLine_LightToFinal:(LineMath *)line_LightToFinal
{
    _line_LightToFinal = line_LightToFinal;
    [self setNeedsDisplay];
}

@synthesize point_FinalCenter = _point_FinalCenter;
- (void)setpoint_FinalCenter:(CGPoint)point_FinalCenter
{
    _point_FinalCenter = point_FinalCenter;
    [self setNeedsDisplay];
}

@synthesize point_LightSource = _point_LightSource;
- (void)setpoint_LightSource:(CGPoint)point_LightSource
{
    _point_LightSource = point_LightSource;
    [self setNeedsDisplay];
}

@synthesize length_PerBise = _length_PerBise;
- (void)setLength_PerBise:(CGFloat)length_PerBise
{
    _length_PerBise = length_PerBise;
    [self setNeedsDisplay];
}

@synthesize line_PerBise = _line_PerBise;
- (void)setLine_PerBise:(LineMath *)line_PerBise
{
    _line_PerBise = line_PerBise;
    [self setNeedsDisplay];
}

@end

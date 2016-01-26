//
//  DrawLineView.m
//  circleDemo
//
//  Created by apple on 15/12/3.
//  Copyright © 2015年 apple. All rights reserved.
//

#import "DrawLineView.h"

@implementation DrawLineView

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
//    [self drawLineWithPoint1:_point1 withPoint2:_point2];
    //和光源连线的延长
    [self drawLineWithOriginPoint:_point1 withLine:_lineWithLight withLength:-3 needSetShaowPoint:YES];

    //垂直平分线
//    [self drawLineWithOriginPoint:_point1 withLine:_line withLength:_length needSetShaowPoint:NO];
    //垂直平分线反向延长
    BOOL drawFullLine = YES;
//    if (drawFullLine) {
//        [self drawLineWithOriginPoint:_point1 withLine:_line withLength:-_length needSetShaowPoint:NO];
//    }
}

- (void)drawLineWithPoint1:(CGPoint)point1 withPoint2:(CGPoint)point2
{
    //1.获得图形上下文
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    //将上下文复制一份到栈中
    CGContextSaveGState(context);
    
    //2.绘制图形
    //第一条线
    //设置线段宽度
    CGContextSetLineWidth(context, 2);
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
    CGFloat angle = atan(line.k);
    CGFloat y2;
    CGFloat x2;
    int i = angle > 0 ? -1 : 1;
    
    y2 = point.y + i * sin(angle)*length;
    x2 = point.x + i * cos(angle)*length;
    CGPoint point2 = CGPointMake(x2, y2);
    
    //绘制线
//    [self drawLineWithPoint1:point withPoint2:point2];
    
    if (needSetShaowPoint) {
        if ([_getDelegate respondsToSelector:@selector(getShadowPoint:tempView:lineView:)]) {
            [_getDelegate getShadowPoint:point2 tempView:_tempView1 lineView:_lineView];
        }
    }
}




//@synthesize lineWithLight = _lineWithLight;
//- (void)setLineWithLight:(LineMath *)lineWithLight
//{
//    _lineWithLight = lineWithLight;
//    [self setNeedsDisplay];
//}
//
//@synthesize point1 = _point1;
//- (void)setPoint1:(CGPoint)point1
//{
//    _point1 = point1;
//    [self setNeedsDisplay];
//}
//
//@synthesize point2 = _point2;
//- (void)setPoint2:(CGPoint)point2
//{
//    _point2 = point2;
//    [self setNeedsDisplay];
//}
//
//@synthesize length = _length;
//- (void)setLength:(CGFloat)length
//{
//    _length = length;
//    [self setNeedsDisplay];
//}
//
//@synthesize line = _line;
//- (void)setLine:(LineMath *)line
//{
//    _line = line;
//    [self setNeedsDisplay];
//}

@end

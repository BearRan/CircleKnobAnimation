//
//  UIView+MySet.m
//  songshu-mall
//
//  Created by zmit on 15/5/25.
//  Copyright (c) 2015年 ZhongMeng. All rights reserved.
//

#import "UIView+MySet.h"

@implementation UIView (MySet)

#pragma mark 设置边框
/*
 设置边框颜色和宽度
 */
- (void)setMyBorder:(UIColor *)borderColor borderWidth:(CGFloat)borderWidth
{
    self.layer.borderColor = borderColor.CGColor;
    self.layer.borderWidth = borderWidth;
}

#pragma mark 自定义分割线View OffY
/*
 根据offY在任意位置画横向分割线
 */
- (void)setMySeparatorLineOffY:(int)offStart offEnd:(int)offEnd lineWidth:(CGFloat)lineWidth lineColor:(UIColor *)lineColor offY:(CGFloat)offY
{
    int parentView_width    = CGRectGetWidth(self.frame);
    
    UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(offStart, offY, parentView_width - offStart - offEnd, lineWidth)];
    
    if (!lineColor) {
        lineView.backgroundColor = [UIColor blackColor];
    }else{
        lineView.backgroundColor = lineColor;
    }
    
    [self addSubview:lineView];
}

#pragma mark 自定义分底部割线View
/*
 自动在底部横向分割线
 */
- (void)setMySeparatorLine:(CGFloat)offStart offEnd:(CGFloat)offEnd lineWidth:(CGFloat)lineWidth lineColor:(UIColor *)lineColor
{
    CGFloat parentView_height   = CGRectGetHeight(self.frame);
    CGFloat parentView_width    = CGRectGetWidth(self.frame);
    
//    NSLog(@"kkkkk parentView_width:%f", parentView_width);
    
    UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(offStart, parentView_height - lineWidth, parentView_width - offStart - offEnd, lineWidth)];
    
    if (!lineColor) {
        lineView.backgroundColor = [UIColor blackColor];
    }else{
        lineView.backgroundColor = lineColor;
    }
    
    [self addSubview:lineView];
}

#pragma mark - 画线--View
/*
 通过view，画任意方向的线
 */
- (void) drawLine:(CGPoint)startPoint endPoint:(CGPoint)endPoint lineWidth:(CGFloat)lineWidth lineColor:(UIColor *)lineColor
{
    UIView *lineView = [[UIView alloc] init];
    lineView.backgroundColor = lineColor;
    
    //竖线
    if (startPoint.x == endPoint.x) {
        lineView.frame = CGRectMake(startPoint.x, startPoint.y, lineWidth, endPoint.y - startPoint.y);
    }
    
    //横线
    else if (startPoint.y == endPoint.y){
        lineView.frame = CGRectMake(startPoint.x, startPoint.y, endPoint.x - startPoint.x, lineWidth);
    }
    
    [self addSubview:lineView];
    
}

#pragma mark - 画线--Layer
/*
 通过layer，画任意方向的线
 */
- (void) drawLineWithLayer:(CGPoint)startPoint endPoint:(CGPoint)endPoint lineWidth:(CGFloat)lineWidth lineColor:(UIColor *)lineColor
{
    //1.获得图形上下文
    CGContextRef context = UIGraphicsGetCurrentContext();

    //将上下文复制一份到栈中
    CGContextSaveGState(context);

    //2.绘制图形
    //设置线段宽度
    CGContextSetLineWidth(context, lineWidth);
    //设置线条头尾部的样式
    CGContextSetLineCap(context, kCGLineCapRound);

    //设置颜色
    CGContextSetStrokeColorWithColor(context, lineColor.CGColor);

    //设置起点
    CGContextMoveToPoint(context, startPoint.x, startPoint.y);
    //画线
    CGContextAddLineToPoint(context, endPoint.x, endPoint.y);

    //3.显示到View
    CGContextStrokePath(context);//以空心的方式画出

    //将图形上下文出栈，替换当前的上下文
    CGContextRestoreGState(context);
}

/*
 优化建议：
 1.status改为enum
 */
#pragma mark 和指定的view剧中
- (void)setCenterWithHorizontal:(BOOL)status parentView:(UIView *)parentView
{
    if (status) {
        self.center = CGPointMake(CGRectGetWidth(parentView.frame)/2, self.center.y);
    }else{
        self.center = CGPointMake(self.center.x, CGRectGetHeight(parentView.frame)/2);
    }
}

#pragma mark 和指定的view剧中(默认在父类view剧中)
- (void)setMyCenter:(Direction_HorVer)direction destinationView:(UIView *)destinationView parentRelation:(BOOL)parentRelation
{
    //父子类view关系
    if (parentRelation) {
        if (!destinationView) {
            destinationView = [self superview];
        }
        
        switch (direction) {
            case dir_Horizontal:
                self.center = CGPointMake(CGRectGetWidth(destinationView.frame)/2, self.center.y);
                break;
                
            case dir_Vertical:
                self.center = CGPointMake(self.center.x, CGRectGetHeight(destinationView.frame)/2);
            default:
                break;
        }
    }
    
    //非父子类view关系
    else{
        if (!destinationView) {
            NSLog(@"非父子类关系的view，并且没有目标view");
            return;
        }
        
        if (![self.superview isEqual:destinationView.superview]) {
            NSLog(@"非父子类关系的view，并且不属于同一个父类view");
            return;
        }
        
        switch (direction) {
            case dir_Horizontal:
                self.center = CGPointMake(self.center.x, destinationView.center.y);
                break;
                
            case dir_Vertical:
                self.center = CGPointMake(destinationView.center.x, self.center.y);
            default:
                break;
        }
    }
}

/*
    在父类view中的话,destinationView可为nil 设置位置约束，上下左右，是否父类view
 */
- (void)setMyDirectionDistance:(Direction_Four)direction destinationView:(UIView *)destinationView parentRelation:(BOOL)parentRelation distance:(CGFloat)distance center:(BOOL)center
{
    CGRect tempRect = self.frame;
    
    //在父类view中
    if (parentRelation) {
        if (!destinationView) {
            destinationView = [self superview];
        }
        
        switch (direction) {
                
            //上边距
            case dir_Up:{
                tempRect.origin.y = distance;
                self.frame = tempRect;
                if (center) {
                    [self setMyCenter:dir_Horizontal destinationView:destinationView parentRelation:YES];
                }
            }
                break;
              
            //下边距
            case dir_Down:{
                tempRect.origin.y = CGRectGetHeight(destinationView.frame) - CGRectGetHeight(self.frame) - distance;
                self.frame = tempRect;
                if (center) {
                    [self setMyCenter:dir_Horizontal destinationView:destinationView parentRelation:YES];
                }
            }
                
                break;
                
            //左边距
            case dir_Left:{
                tempRect.origin.x = distance;
                self.frame = tempRect;
                if (center) {
                    [self setMyCenter:dir_Vertical destinationView:destinationView parentRelation:YES];
                }
            }
                
                break;
              
            //右边距
            case dir_Right:{
                tempRect.origin.x = CGRectGetWidth(destinationView.frame) - CGRectGetWidth(self.frame) - distance;
                self.frame = tempRect;
                if (center) {
                    [self setMyCenter:dir_Vertical destinationView:destinationView parentRelation:YES];
                }
            }
                
                break;
                
            default:
                break;
        }
        
    }
    
    //不在父类view中，其他view
    /*    -----      -----
     *   | self |   | des  |
     *   |      |   |      |   -----------------    ------------------
     *   | up   |   | down |  | self  left  des |  | des  right  self |
     *   |      |   |      |   -----------------    ------------------
     *   | des  |   | self |
     *    -----      -----
     */
    else{
        switch (direction) {
            case dir_Up:
                tempRect.origin.y = CGRectGetMinY(destinationView.frame) - distance - CGRectGetHeight(self.frame);
                self.frame = tempRect;
                if (center) {
                    [self setMyCenter:dir_Vertical destinationView:destinationView parentRelation:NO];
                }
                
                break;
                
            case dir_Down:
                tempRect.origin.y = CGRectGetMaxY(destinationView.frame) + distance;
                self.frame = tempRect;
                if (center) {
                    [self setMyCenter:dir_Vertical destinationView:destinationView parentRelation:NO];
                }
                
                break;
                
            case dir_Left:
                tempRect.origin.x = CGRectGetMinX(destinationView.frame) - distance - CGRectGetWidth(self.frame);
                self.frame = tempRect;
                if (center) {
                    [self setMyCenter:dir_Horizontal destinationView:destinationView parentRelation:NO];
                }
                
                break;
                
            case dir_Right:
                tempRect.origin.x = CGRectGetMaxX(destinationView.frame) + distance;
                
                self.frame = tempRect;
                if (center) {
                    [self setMyCenter:dir_Horizontal destinationView:destinationView parentRelation:NO];
                }
                
                break;
                
            default:
                break;
        }
    }
}


//  设置宽
- (void)setMyWidth:(CGFloat)width
{
    CGRect tempFrame = self.frame;
    tempFrame.size.width = width;
    self.frame = tempFrame;
}

//  设置高
- (void)setMyHeight:(CGFloat)height
{
    CGRect tempFrame = self.frame;
    tempFrame.size.height = height;
    self.frame = tempFrame;
}

//  设置x
- (void)setMyX:(CGFloat)x
{
    CGRect tempFrame = self.frame;
    tempFrame.origin.x = x;
    self.frame = tempFrame;
}

//  设置y
- (void)setMyY:(CGFloat)y
{
    CGRect tempFrame = self.frame;
    tempFrame.origin.y = y;
    self.frame = tempFrame;
}

//  设置centerX
- (void)setMyCenterX:(CGFloat)x
{
    CGPoint tempCenter = self.center;
    tempCenter.x = x;
    self.center = tempCenter;
}

//  设置centerY
- (void)setmyCenterY:(CGFloat)y
{
    CGPoint tempCenter = self.center;
    tempCenter.y = y;
    self.center = tempCenter;
}

@end

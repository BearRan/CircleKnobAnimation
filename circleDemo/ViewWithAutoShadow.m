//
//  ViewWithAutoShadow.m
//  circleDemo
//
//  Created by apple on 15/12/3.
//  Copyright © 2015年 apple. All rights reserved.
//

#import "ViewWithAutoShadow.h"
#import "LineMath.h"
#import "UIView+MySet.h"
#import "AppDelegate.h"
#import "LineViewWithVerticalAssist.h"

@interface ViewWithAutoShadow ()<getShaowPoint>

@end


@implementation ViewWithAutoShadow

static CGFloat pointWidth = 2.0f;

- (instancetype)initWithFrame:(CGRect)frame
{
    if (!self) {
        self = nil;
    }
    
    self = [super initWithFrame:frame];
    
    _point_V1 = [[UIView alloc] initWithFrame:CGRectMake(- pointWidth/2, - pointWidth/2, pointWidth, pointWidth)];
    _point_V2 = [[UIView alloc] initWithFrame:CGRectMake(frame.size.width - pointWidth/2, 0 - pointWidth/2, pointWidth, pointWidth)];
    _point_V3 = [[UIView alloc] initWithFrame:CGRectMake(frame.size.width - pointWidth/2, frame.size.height - pointWidth/2, pointWidth, pointWidth)];
    _point_V4 = [[UIView alloc] initWithFrame:CGRectMake(0 - pointWidth/2, frame.size.height - pointWidth/2, pointWidth, pointWidth)];
    _centerPointV = [[UIView alloc] initWithFrame:CGRectMake((frame.size.width - pointWidth)/2, (frame.size.height - pointWidth)/2, pointWidth, pointWidth)];
    
    return self;
}

- (void)setPointViewProperty:(UIView *)pointV
{
    pointV.backgroundColor = [UIColor blackColor];
    pointV.layer.cornerRadius = pointWidth/2.0f;
}

CGPoint getCenterPoint(CGPoint point1, CGPoint point2)
{
    return CGPointMake((point1.x + point2.x)/2, (point1.y + point2.y)/2);
}

- (void)calucateAngleWithSourcePoint:(CGPoint)sourcePoint
{
    CGPoint pointA = [self convertPoint:self.point_V1.center fromView:self];
    CGPoint pointA1 = [self convertPoint:pointA toView:nil];
    
    CGPoint pointB = [self convertPoint:self.point_V2.center fromView:self];
    CGPoint pointB1 = [self convertPoint:pointB toView:nil];
    
    CGPoint pointC = [self convertPoint:self.point_V3.center fromView:self];
    CGPoint pointC1 = [self convertPoint:pointC toView:nil];
    
    CGPoint pointD = [self convertPoint:self.point_V4.center fromView:self];
    CGPoint pointD1 = [self convertPoint:pointD toView:nil];
    
    
    CGPoint centerPoint = getCenterPoint(pointA1, pointC1);
    CGPoint sidePoint = getCenterPoint(pointA1, pointB1);   //边上的垂直平分线的交点
    
    //垂直平分线
    LineMath *line1 = [[LineMath alloc] initWithPoint1:centerPoint withPoint2:sidePoint];
    //和光源的连线
    LineMath *line2 = [[LineMath alloc] initWithPoint1:centerPoint withPoint2:sourcePoint];
    
    CGFloat tanA = ABS( (line2.k - line1.k) / (1 + line1.k*line2.k) );
    CGFloat calucateAngle = atan(tanA);
    CGFloat radius = radiansToDegrees(calucateAngle);
    
    AppDelegate *myDelegate = [[UIApplication sharedApplication] delegate];
    LineViewWithVerticalAssist *lineView = [[LineViewWithVerticalAssist alloc] initWithFrame:myDelegate.window.bounds];
    lineView.backgroundColor = [UIColor clearColor];
    lineView.userInteractionEnabled = NO;
    [myDelegate.window addSubview:lineView];
    
    //点与光源的连线
    lineView.point_LightSource = centerPoint;
    lineView.point_FinalCenter = sourcePoint;
    lineView.line_LightToFinal = line2;
    
    //垂直平分线
    lineView.line_PerBise = line1;
    lineView.length_PerBise = 25;
    
    lineView.perBiseView_Base = self;
    lineView.getDelegate = self;
    [lineView setNeedsDisplay];
}

- (void)getShadowPoint:(CGPoint)shadowPoint tempView:(ViewWithAutoShadow *)tempView
{
    //绘制阴影
    CGPoint shadowPointFinal = [tempView convertPoint:shadowPoint fromView:self.window];
    UIColor *shadowColor = RGB(169, 159, 146);
    
    tempView.layer.shadowColor = shadowColor.CGColor;
    tempView.layer.shadowOffset = CGSizeMake(shadowPointFinal.x - CGRectGetWidth(tempView.layer.bounds)/2, shadowPointFinal.y - CGRectGetHeight(tempView.layer.bounds)/2);
    tempView.layer.shadowOpacity = 1.0f;
    tempView.layer.shadowRadius = 2.0f;
}

#pragma mark Rewrite showAssisPoint

@synthesize showAssistPoint = _showAssistPoint;
- (void)setShowAssistPoint:(BOOL)showAssistPoint
{
    _showAssistPoint = showAssistPoint;
    
    if (showAssistPoint == YES) {
        [self setPointViewProperty:_point_V1];
        [self addSubview:_point_V1];
        
        [self setPointViewProperty:_point_V2];
        [self addSubview:_point_V2];
        
        [self setPointViewProperty:_point_V3];
        [self addSubview:_point_V3];
    
        [self setPointViewProperty:_point_V4];
        [self addSubview:_point_V4];
        
        [self setPointViewProperty:_centerPointV];
        [self addSubview:_centerPointV];
    }else{
    
        [_point_V1 removeFromSuperview];
        [_point_V2 removeFromSuperview];
        [_point_V3 removeFromSuperview];
        [_point_V3 removeFromSuperview];
        [_centerPointV removeFromSuperview];
    }
}

@end

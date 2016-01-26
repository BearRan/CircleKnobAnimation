//
//  FanView.m
//  circleDemo
//
//  Created by apple on 15/12/1.
//  Copyright © 2015年 apple. All rights reserved.
//

#import "FanView.h"
#import "DrawLineView.h"
#import "UIView+MySet.h"

static CGFloat  lineWidth = 10.0f;

@interface FanView ()
{
    //扇环形进度条 背景
    CGContextRef    contextBack;
    UIBezierPath    *bezierPathBack;
    
    //扇环形进度条 前景
    CGContextRef    contextFore;
    UIBezierPath    *bezierPathFore;
}

@end



@implementation FanView

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
    contextBack = UIGraphicsGetCurrentContext();
    contextFore = UIGraphicsGetCurrentContext();
    
    [self drawFan:contextBack
       bezierPath:bezierPathBack
        knobAngle:180 + endAngleValue
      strokeColor:[UIColor colorWithRed:202/255.0 green:207/255.0 blue:202/255.0 alpha:1.0f]];
    
    [self drawFan:contextFore
       bezierPath:bezierPathFore
        knobAngle:_knobValue
      strokeColor:[UIColor colorWithRed:174/255.0 green:0/255.0 blue:0/255.0 alpha:1.0f]];
}



/***********************
          角度说明
 
            90度
            |
            |
            |
            |
0度  ----------------  180度
            |
－30或者330  |
            |
            |
            270 度
 
 **************************/

//  绘制扇形
- (void)drawFan:(CGContextRef)context bezierPath:(UIBezierPath *)bezierPath knobAngle:(CGFloat)knobAngle strokeColor:(UIColor *)strokeColor
{
    CGRect          frame           = self.frame;
    CGFloat         radius          = (CGRectGetWidth(frame) - lineWidth) / 2;
    CGFloat         angleForOne     = M_PI / 180.0f;
    CGFloat         circleLength    = radius * 2 * M_PI;
    int             gapCount        = fanShowCount - 1;                         //间隙个数
    CGFloat         gapWidth        = 5;                                        //间隙距离
    
    //  计算需要绘制的角度（角度制）
    knobAngle = knobAngle < -startAngleValue ? -startAngleValue : knobAngle;
    knobAngle = knobAngle > 180 + endAngleValue ? 180 + endAngleValue : knobAngle;

    //  设置弧线路径
    bezierPath = [UIBezierPath bezierPathWithArcCenter:CGPointMake(CGRectGetWidth(frame)/2, CGRectGetHeight(frame)/2) radius:(CGRectGetWidth(frame) - lineWidth)/2.0 startAngle:angleForOne * (180 - startAngleValue) endAngle:angleForOne * (180 + knobAngle) clockwise:YES];
    CGContextAddPath(context, bezierPath.CGPath);
    
    //  设置线的颜色，线宽，接头样式
    CGContextSetStrokeColorWithColor(context, strokeColor.CGColor);
    CGContextSetFillColorWithColor(context, [UIColor clearColor].CGColor);
    CGContextSetLineWidth(context, lineWidth);
    CGContextSetLineCap(context, kCGLineCapButt);
    
    //  绘制虚线
    CGFloat drawLineLength = circleLength * (1- (startAngleValue + endAngleValue)/fullAngleValue);
    CGFloat showLineLengthPer = (drawLineLength - gapWidth * gapCount)/(fanShowCount - 1);
    CGFloat lengths[2] = {showLineLengthPer,gapWidth};
    CGContextSetLineDash(context, 0, lengths, 2);
    CGContextDrawPath(context, kCGPathFillStroke);//最后一个参数是填充类型
    
    //  绘制小方格view
    static BOOL     drawBlock = NO;
    if (!drawBlock) {
        drawBlock = YES;
	
        for (int i = 1; i < fanShowCount; i++) {
            CGFloat blockWidth  = lineWidth + 8;
            CGFloat blockHeight = 5;
            CGFloat block_x     = CGRectGetWidth(frame) / 2 - radius - blockWidth/2;
            CGFloat block_y     = CGRectGetHeight(frame) / 2;
            
            //  角度修正
            if (blockHeight > gapWidth) {
                block_y = block_y - blockHeight/2;
            }else{
                block_y = block_y + (gapWidth - blockHeight)/2;
            }
            
            //  方格view 可辅助绘制垂直平分线
            ViewWithVertixView *viewBlock = [[ViewWithVertixView alloc] initWithFrame:CGRectMake(block_x, block_y, blockWidth, blockHeight)];
            viewBlock.showAssistPoint = YES;
            viewBlock.backgroundColor = [UIColor colorWithRed:248/255.0 green:238/255.0 blue:237/255.0 alpha:1.0f];
            [self addSubview:viewBlock];
            
            //  根据锚点旋转
            CGFloat blockAngle = (180 + startAngleValue + endAngleValue)/fanShowCount*i - startAngleValue;
            CGAffineTransform rotate = GetCGAffineTransformRotateAroundPoint1(viewBlock.center.x, viewBlock.center.y, CGRectGetWidth(frame)/2, CGRectGetHeight(frame)/2, blockAngle/180.0 * M_PI);
            [viewBlock setTransform:rotate];
            
            [viewBlock calucateAngleWithSourcePoint:_lightSource_InWindow];
        }
    }
}

//根据某个锚点旋转
CGAffineTransform GetCGAffineTransformRotateAroundPoint1(float centerX, float centerY, float x ,float y ,float angle)
{
    x = x - centerX; //计算(x,y)从(0,0)为原点的坐标系变换到(CenterX ，CenterY)为原点的坐标系下的坐标
    y = y - centerY; //(0，0)坐标系的右横轴、下竖轴是正轴,(CenterX,CenterY)坐标系的正轴也一样
    
    CGAffineTransform  trans = CGAffineTransformMakeTranslation(x, y);
    trans = CGAffineTransformRotate(trans,angle);
    trans = CGAffineTransformTranslate(trans,-x, -y);
    return trans;
}

@synthesize knobValue = _knobValue;
- (void)setKnobValue:(CGFloat)knobValue
{
    _knobValue = knobValue;
    [self setNeedsDisplay];
}

@end

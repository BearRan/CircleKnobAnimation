//
//  ViewController.m
//  circleDemo
//
//  Created by apple on 15/12/1.
//  Copyright © 2015年 apple. All rights reserved.
//

#import "ViewController.h"
#import "UIView+MySet.h"
#import "FanView.h"

static CGFloat knob_width = 150;
static CGFloat lastRadius = 0;

@interface ViewController (){
    UIView  *knob;          //  旋钮view
    UIView  *knobCircle1;   //  里面的小的旋钮
    UIView  *knobCircle2;   //  旋钮外面大的圆
    FanView *fanView;       //  扇形view
    UIView  *controlView;   //  手势控制台view
    CGPoint lightSource;    //  光源点
}
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = RGB(235, 235, 235);
    [self initSetKnobView];
    [self initSetFanView];
}


#pragma mark - 设置外围的扇环形
- (void)initSetFanView
{
    CGFloat delta_distance = 26;
    
    fanView = [[FanView alloc] initWithFrame:CGRectMake(0, 0, knob_width + delta_distance * 2, knob_width + delta_distance * 2)];
    fanView.center = knob.center;
    fanView.backgroundColor = [UIColor clearColor];
    fanView.userInteractionEnabled = NO;
    [self.view addSubview:fanView];
    
    //设置光源
    lightSource = CGPointMake(300, 100);
    fanView.knobValue = -startAngleValue;//设置起始点
    fanView.lightSource_InWindow = lightSource;
    UIView *lightView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10, 10)];
    lightView.backgroundColor = [UIColor blackColor];
    lightView.center = lightSource;
    [self.view addSubview:lightView];
}


#pragma mark - 设置中间的旋钮
- (void)initSetKnobView
{
    //  外面大的旋钮底座
    knobCircle2 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, knob_width + 15, knob_width + 15)];
    [knobCircle2 setCenter:CGPointMake(SCREEN_WIDTH/2, SCREEN_HEIGHT/2)];
    knobCircle2.layer.cornerRadius = CGRectGetWidth(knobCircle2.frame) / 2;
    knobCircle2.backgroundColor = RGB(215, 215, 215);
    [self.view addSubview:knobCircle2];
    
    knobCircle2.layer.shadowColor = RGB(169, 159, 146).CGColor;
    knobCircle2.layer.shadowOffset = CGSizeMake(-2, 3);
    knobCircle2.layer.shadowOpacity = 0.5f;
    knobCircle2.layer.shadowRadius = 0.5f;
    
    
    //  里面的旋钮
    knobCircle1 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, knob_width, knob_width)];
    [knobCircle1 setCenter:CGPointMake(SCREEN_WIDTH/2, SCREEN_HEIGHT/2)];
    knobCircle1.layer.cornerRadius = knob_width / 2;
    knobCircle1.backgroundColor = RGB(225, 225, 225);
    [self.view addSubview:knobCircle1];
    
    knobCircle1.layer.shadowColor = RGB(169, 159, 146).CGColor;
    knobCircle1.layer.shadowOffset = CGSizeMake(-4, 6);
    knobCircle1.layer.shadowOpacity = 0.9f;
    knobCircle1.layer.shadowRadius = 5.5;
    
    
    //  Main旋钮
    knob = [[UIView alloc] initWithFrame:CGRectMake(0, 0, knob_width, knob_width)];
    [knob setCenter:CGPointMake(SCREEN_WIDTH/2, SCREEN_HEIGHT/2)];
    knob.layer.cornerRadius = knob_width / 2;
    knob.backgroundColor = [UIColor clearColor];
    [self.view addSubview:knob];
    
    
    //  参考线开关
    BOOL showReferenceLine = NO;
    if (showReferenceLine) {
        int seperateLineCount = fanCount / 2;
        for (int i = 0; i < seperateLineCount; i++) {
            UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(0, knob_width/2, knob_width, 1)];
            
            if (i == 0) {
                lineView.backgroundColor = [UIColor greenColor];
            }else{
                lineView.backgroundColor = [UIColor blackColor];
            }
            lineView.center = knob.center;
            [self.view addSubview:lineView];
            
            [lineView setTransform:CGAffineTransformMakeRotation((i * (180/seperateLineCount) - startAngleValue) / 180.0 * M_PI)];
        }
    }
    
    
    //  手势view
    controlView = [[UIView alloc] initWithFrame:knob.frame];
    controlView.layer.cornerRadius = knob.layer.cornerRadius;
    [self.view addSubview:controlView];
    
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapEvent:)];
    tapGesture.numberOfTapsRequired = 1;
    [controlView addGestureRecognizer:tapGesture];
    
    UIPanGestureRecognizer *panGesture = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(tapEvent:)];
    [controlView addGestureRecognizer:panGesture];
    
    
    //  指示点
    CGFloat pointWidth = 15.0f;
    UIView *indicatorPoint = [[UIView alloc] initWithFrame:CGRectMake(10, (knob_width - pointWidth)/2, pointWidth, pointWidth)];
    indicatorPoint.backgroundColor = [UIColor colorWithRed:140/255.0 green:24/255.0 blue:24/255.0 alpha:1.0f];
    indicatorPoint.layer.cornerRadius = 15/2.0f;
    [knob addSubview:indicatorPoint];
    
    CGAffineTransform rotate = CGAffineTransformMakeRotation(-startAngleValue/180.0 * M_PI);
    [knob setTransform:rotate];
}


- (void)tapEvent:(UIGestureRecognizer *)tapGesture
{
    CGPoint point;
    point = [tapGesture locationInView:controlView];
    
    if ([tapGesture isKindOfClass:[UIPanGestureRecognizer class]]) {
        [self pointConvert:point closeAnimation:YES];
    }else{
        [self pointConvert:point closeAnimation:NO];
    }
}


//  转动到某一角度，并且是否执行动画
- (void)pointConvert:(CGPoint)point closeAnimation:(BOOL)closeAnimation
{
    CGFloat x0 = CGRectGetWidth(controlView.frame)/2;
    CGFloat y0 = CGRectGetHeight(controlView.frame)/2;
    CGFloat x1 = point.x;
    CGFloat y1 = point.y;
    
    CGFloat angle = atan((y1 - y0)/(x1 - x0));
    CGFloat radius = radiansToDegrees(angle);
    
    typedef enum {
        areaLeftUp,
        areaLeftDown,
        areaRightUp,
        AreaRightDown,
    }AreaEnum;
    
    AreaEnum pointInArea;
    if (x1 < x0 && y1 < y0) {
        pointInArea = areaLeftUp;
    }
    else if(x1 < x0 && y1 >= y0){
        pointInArea = areaLeftDown;
    }
    else if (x1 >= x0 && y1 < y0){
        pointInArea = areaRightUp;
        radius = 180 + radius;
    }
    else if (x1 >= x0 && y1 >= y0){
        pointInArea = AreaRightDown;
        radius = 180 + radius;
    }
    
    radius = radius <= -startAngleValue ? -startAngleValue : radius;
    radius = radius >= 180 + endAngleValue ? 180 + endAngleValue : radius;
    
    //  显示动画
    if (closeAnimation == NO) {
        
        CGFloat countAll = ABS(radius - lastRadius);
        CGFloat animationTime = countAll * 0.003;
        
        [self changeRadiusWithAnimation:radius lastRadius:lastRadius duration:animationTime];
    }
    
    //  不显示动画
    else{
        
        [knob.layer removeAllAnimations];
        CGAffineTransform rotate = CGAffineTransformMakeRotation(radius/180.0 * M_PI);
        [knob setTransform:rotate];
        fanView.knobValue = radius;
    }
    
    lastRadius = radius;
}


//  执行动画
- (void)changeRadiusWithAnimation:(CGFloat)radius lastRadius:(CGFloat)lastRadius duration:(CGFloat)duration
{
    CGFloat countAll = ABS(radius - lastRadius);
    double delaySeconds = 0.001f;
    CGFloat animateCount = duration/delaySeconds;
    __block int i = 0;
    
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_source_t timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, queue);
    dispatch_source_set_timer(timer, DISPATCH_TIME_NOW, delaySeconds * NSEC_PER_SEC, 0);
    dispatch_source_set_event_handler(timer, ^{
        
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            
            if (i >= animateCount) {
                
                dispatch_source_cancel(timer);
            }else{
                
                i ++;
                dispatch_sync(dispatch_get_main_queue(), ^{
                    
                    //  扇环进度条动画
                    CGFloat anglePer = countAll/animateCount * i;
                    int k = radius > lastRadius ? anglePer : -anglePer;
                    CGFloat needValue = lastRadius + k;
                    fanView.knobValue = needValue;
                    
                    //  该方法会重新调用drawRect方法
                    [fanView setNeedsDisplay];
                    
                    //  旋钮转动
                    knob.transform = CGAffineTransformMakeRotation((needValue/180.0 - 0) * M_PI);
                });
            }
        });
        
    });
    dispatch_resume(timer);
    
}

@end






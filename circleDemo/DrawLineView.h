//
//  DrawLineView.h
//  circleDemo
//
//  Created by apple on 15/12/3.
//  Copyright © 2015年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LineMath.h"
#import "ViewWithVertixView.h"

@class DrawLineView;

@protocol getShaowPoint <NSObject>

@required
- (void)getShadowPoint:(CGPoint)shadowPoint tempView:(ViewWithVertixView *)tempView lineView:(DrawLineView *)lineView;

@end



@interface DrawLineView : UIView

- (instancetype)initWithFrame:(CGRect)frame;

@property (assign, nonatomic) id getDelegate;

@property (assign, nonatomic) CGPoint point_LightSource;    //  光源
@property (assign, nonatomic) CGPoint point_FinalCenter;    //  目的view中心
@property (strong, nonatomic) LineMath *lineWithLight;      //  光源和目的中心连线 表达式

@property (assign, nonatomic) CGFloat length;               //  垂直平分线长度
@property (strong, nonatomic) LineMath *line;               //  垂直平分线 表达式


@property (strong, nonatomic) ViewWithVertixView *tempView1;
@property (strong, nonatomic) DrawLineView      *lineView;

@end

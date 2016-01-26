//
//  LineViewWithVerticalAssist.h
//  circleDemo
//
//  Created by apple on 15/12/3.
//  Copyright © 2015年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LineMath.h"
#import "ViewWithAutoShadow.h"

@class LineViewWithVerticalAssist;

@protocol getShaowPoint <NSObject>

@required
- (void)getShadowPoint:(CGPoint)shadowPoint tempView:(ViewWithAutoShadow *)tempView;

@end



@interface LineViewWithVerticalAssist : UIView

- (instancetype)initWithFrame:(CGRect)frame;

@property (assign, nonatomic) id getDelegate;

@property (assign, nonatomic) CGPoint   point_LightSource;      //  光源
@property (assign, nonatomic) CGPoint   point_FinalCenter;      //  目的view中心
@property (strong, nonatomic) LineMath  *line_LightToFinal;     //  光源和目的中心连线 表达式

@property (assign, nonatomic) CGFloat   length_PerBise;         //  垂直平分线长度(PerpendicularBisector)
@property (strong, nonatomic) LineMath  *line_PerBise;          //  垂直平分线 表达式


@property (strong, nonatomic) ViewWithAutoShadow    *perBiseView_Base;  //  绘制垂直平分线的BaseView

@end

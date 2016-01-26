//
//  ViewWithAutoShadow.h
//  circleDemo
//
//  Created by apple on 15/12/3.
//  Copyright © 2015年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

/**
 ** 功能
 ** 1，绘制四个顶点，中心点，垂直平分线的view
 ** 根据光源所在位置绘制出仿真的阴影
 **/
@interface ViewWithAutoShadow : UIView

@property (strong, nonatomic) UIView    *point_V1;
@property (strong, nonatomic) UIView    *point_V2;
@property (strong, nonatomic) UIView    *point_V3;
@property (strong, nonatomic) UIView    *point_V4;
@property (strong, nonatomic) UIView    *centerPointV;
@property (assign, nonatomic) BOOL      showAssistPoint;    //  是否显示辅助点

- (instancetype)initWithFrame:(CGRect)frame;

- (void)calucateAngleWithSourcePoint:(CGPoint)sourcePoint parentView:(UIView *)parentView;

@end

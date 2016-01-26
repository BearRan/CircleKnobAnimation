//
//  ViewWithVertixView.h
//  circleDemo
//
//  Created by apple on 15/12/3.
//  Copyright © 2015年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

//绘制出view的四个顶点
@interface ViewWithVertixView : UIView

@property (strong, nonatomic) UIView *point_V1;
@property (strong, nonatomic) UIView *point_V2;
@property (strong, nonatomic) UIView *point_V3;
@property (strong, nonatomic) UIView *point_V4;
@property (strong, nonatomic) UIView *centerPointV;

- (instancetype)initWithFrame:(CGRect)frame;

@end

//
//  ViewWithVertixView.h
//  circleDemo
//
//  Created by apple on 15/12/3.
//  Copyright © 2015年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewWithVertixView : UIView

@property (strong, nonatomic) UIView *point1;
@property (strong, nonatomic) UIView *point2;
@property (strong, nonatomic) UIView *point3;
@property (strong, nonatomic) UIView *point4;

- (instancetype)initWithFrame:(CGRect)frame;

@end

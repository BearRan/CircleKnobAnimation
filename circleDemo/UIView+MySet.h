//
//  UIView+MySet.h
//  songshu-mall
//
//  Created by zmit on 15/5/25.
//  Copyright (c) 2015年 ZhongMeng. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum {
    dir_Horizontal,
    dir_Vertical,
}Direction_HorVer;

typedef enum {
    dir_Left,
    dir_Right,
    dir_Up,
    dir_Down,
}Direction_Four;


@interface UIView (MySet)

// 设置边框
- (void)setMyBorder:(UIColor *)borderColor borderWidth:(CGFloat)borderWidth;

// 自定义分割线View OffY
- (void)setMySeparatorLineOffY:(int)offStart offEnd:(int)offEnd lineWidth:(CGFloat)lineWidth lineColor:(UIColor *)lineColor offY:(CGFloat)offY;

// 自定义底部分割线View
- (void)setMySeparatorLine:(CGFloat)offStart offEnd:(CGFloat)offEnd lineWidth:(CGFloat)lineWidth lineColor:(UIColor *)lineColor;

// 通过view，画任意方向的线
- (void) drawLine:(CGPoint)startPoint endPoint:(CGPoint)endPoint lineWidth:(CGFloat)lineWidth lineColor:(UIColor *)lineColor;


// 通过layer，画任意方向的线
- (void) drawLineWithLayer:(CGPoint)startPoint endPoint:(CGPoint)endPoint lineWidth:(CGFloat)lineWidth lineColor:(UIColor *)lineColor;


// 和指定的view剧中
- (void)setMyCenter:(Direction_HorVer)direction destinationView:(UIView *)destinationView parentRelation:(BOOL)parentRelation;

//  设置位置约束，上下左右，是否父类view
- (void)setMyDirectionDistance:(Direction_Four)direction destinationView:(UIView *)destinationView parentRelation:(BOOL)parentRelation distance:(CGFloat)distance center:(BOOL)center;


//  设置宽
- (void)setMyWidth:(CGFloat)width;

//  设置高
- (void)setMyHeight:(CGFloat)height;

//  设置x
- (void)setMyX:(CGFloat)x;

//  设置y
- (void)setMyY:(CGFloat)y;

//  设置centerX
- (void)setMyCenterX:(CGFloat)x;

//  设置centerY
- (void)setmyCenterY:(CGFloat)y;

@end

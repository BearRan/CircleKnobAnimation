//
//  UIView+MySet.h
//
//  Created by bear on 15/5/25.
//  Copyright (c) 2015年 Bear. All rights reserved.
//

#import <UIKit/UIKit.h>

#define SCREEN_WIDTH    [[UIScreen mainScreen] bounds].size.width
#define SCREEN_HEIGHT   [[UIScreen mainScreen] bounds].size.height
#define RGB(r,g,b) [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:1.0f]

#define        fullAngleValue  360.0
#define        fanCount        10                           //扇页总数
#define        fanShowCount    8                            //显示的扇页个数
#define        angleForFan     fullAngleValue / fanCount    //每个扇页夹脚
#define        startAngleValue (90 - (fullAngleValue - fanShowCount*angleForFan)/2)
#define        endAngleValue   startAngleValue

//  绘制辅助线
static BOOL drawAssistLine  = YES;

//  角度转弧度
#define degreesToRadian(x) (M_PI * x / 180.0)

//  弧度转角度
#define radiansToDegrees(x) (180.0 * x / M_PI)

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

//
//  FanView.h
//  circleDemo
//
//  Created by apple on 15/12/1.
//  Copyright © 2015年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FanView : UIView

@property (nonatomic, assign) CGFloat   knobValue;
@property (nonatomic, assign) CGPoint   lightSource_InWindow;

//  小方格view的数组
@property (nonatomic, strong) NSMutableArray  *blockViewArray;

@end

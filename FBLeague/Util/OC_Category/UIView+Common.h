//
//  UIView+Common.h
//  HotMate
//
//  Created by JinXin on 15/1/4.
//  Copyright (c) 2015年 iwoapp. All rights reserved.
//

#import <UIKit/UIKit.h>
#import<QuartzCore/QuartzCore.h>
#import "NSString+Common.h"
#import "UIColor+Expanded.h"


@interface UIView (Common)
- (void)setY:(CGFloat)y;
- (void)setX:(CGFloat)x;
- (void)setHeight:(CGFloat)height;
- (void)setWidth:(CGFloat)width;
- (void)setSize:(CGSize)size;
- (void)addGradientLayerWithColors:(NSArray *)cgColorArray;
- (void)addGradientLayerWithColors:(NSArray *)cgColorArray locations:(NSArray *)floatNumArray startPoint:(CGPoint )aPoint endPoint:(CGPoint)endPoint;
- (void)addLineUp:(BOOL)hasUp andDown:(BOOL)hasDown;
- (void)addLineUp:(BOOL)hasUp andDown:(BOOL)hasDown andColor:(UIColor *)color;
- (void)removeViewWithTag:(NSInteger)tag;


+ (CGRect)frameWithOutNavTab;
+ (CGRect)frameWithOutNav;
+ (UIViewAnimationOptions)animationOptionsForCurve:(UIViewAnimationCurve)curve;
+ (UIView *)lineViewWithPointYY:(CGFloat)pointY;
+ (UIView *)lineViewWithPointYY:(CGFloat)pointY andColor:(UIColor *)color;
@end

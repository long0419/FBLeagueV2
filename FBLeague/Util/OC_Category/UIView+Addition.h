//
//  UIView+Addition.h
//  Communication
//
//  Created by andy on 14-8-20.
//  Copyright (c) 2014年 liujun. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (Addition)
@property (nonatomic, assign) CGSize size;
@property (nonatomic, assign) CGPoint origin;

@property (nonatomic, assign) CGFloat left;
@property (nonatomic, assign) CGFloat right;
@property (nonatomic, assign) CGFloat top;
@property (nonatomic, assign) CGFloat bottom;

//外部中心
@property (nonatomic, assign) CGFloat centerX;
@property (nonatomic, assign) CGFloat centerY;

//内部中心
@property (nonatomic, assign) CGFloat centerx;
@property (nonatomic, assign) CGFloat centery;

@property (nonatomic, assign) CGFloat width;
@property (nonatomic, assign) CGFloat height;
@end

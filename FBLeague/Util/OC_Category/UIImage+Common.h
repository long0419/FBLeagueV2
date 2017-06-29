//
//  UIImage+Common.h
//
//  Created by JinXin on 15/1/4.
//  Copyright (c) 2015年 sme. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (Common)

+(UIImage *)imageWithColor:(UIColor *)aColor;
+(UIImage *)imageWithColor:(UIColor *)aColor withFrame:(CGRect)aFrame;

- (UIImage*)transformWidth:(CGFloat)width height:(CGFloat)height ;

@end

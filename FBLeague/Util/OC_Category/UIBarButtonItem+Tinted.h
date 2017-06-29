//
//  UIBarButtonItem+Tinted.h
//  Invest
//
//  Created by JinXin on 15/4/20.
//  Copyright (c) 2015年 droidgle. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIBarButtonItem (Tinted)

+ (UIBarButtonItem *)newBarButtonItemWithTint:(UIColor*)color andTitle:(NSString*)itemTitle andTarget:(id)theTarget andSelector:(SEL)selector;

@end

//
//  UIBarButtonItem+Tinted.m
//  Invest
//
//  Created by JinXin on 15/4/20.
//  Copyright (c) 2015年 droidgle. All rights reserved.
//

#import "UIBarButtonItem+Tinted.h"

@implementation UIBarButtonItem (Tinted)

+ (UIBarButtonItem *)newBarButtonItemWithTint:(UIColor*)color andTitle:(NSString*)itemTitle andTarget:(id)theTarget andSelector:(SEL)selector
{
    UIButton *button = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 60, 30)];
    [button setTitle:itemTitle forState:UIControlStateNormal];
    [button setTitleColor:color forState:UIControlStateNormal];
    button.contentEdgeInsets = UIEdgeInsetsMake(0, 10, 0, 10);
    [button addTarget:theTarget action:selector forControlEvents:UIControlEventTouchUpInside];
    return [[UIBarButtonItem alloc] initWithCustomView:button];
}


@end

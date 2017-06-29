//
//  UIButton+Block.h
//  SME
//
//  Created by JinXin on 15/5/29.
//  Copyright (c) 2015年 droidgle. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^ButtonBlock)(UIButton* btn);

@interface UIButton (Block)

- (void)addAction:(ButtonBlock)block;
- (void)addAction:(ButtonBlock)block forControlEvents:(UIControlEvents)controlEvents;

@end

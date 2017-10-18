//
//  BaseViewController.h
//  CarManager
//
//  Created by JinXin on 15/12/9.
//  Copyright © 2015年 droidgle. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "APIUrl.h"
#import "UIView+Common.h"
#import "NSObject+Common.h"
#import "UIImage+Common.h"
#import "Masonry.h"
#import "NSString+Common.h"
#import "UINavigationController+FDFullscreenPopGesture.h"

@interface BaseViewController : UIViewController<UIGestureRecognizerDelegate>

- (void)showProgressViewWithTitle:(NSString *)msg;
- (void)showProgressView;

- (void)tabBarItemClicked;

- (void)setBackBottmAndTitle;
- (void)setBackBottmAndTitle2;

- (void)setBackTitle : (NSString *) title andWithSize : (CGFloat) size andWithColor :(NSString *) color ;

- (void)setRightBottom ;

- (void) showTabBottom ;

- (void) hideTabBottom ;

- (void) forbiddenGesture ;
- (void) goGesture ;

@end

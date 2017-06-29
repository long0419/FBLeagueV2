//
//  NSObject+Common.h
//  Invest
//
//  Created by droidgle on 14-7-31.
//  Copyright (c) 2014年 Coding. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NSObject (Common)

#pragma mark Tip M
- (NSString *)tipFromError:(NSError *)error;
- (void)showError:(NSError *)error;
- (void)showHudTipStr:(NSString *)tipStr;


/**
 *  更新 status bar 的颜色
 */
- (void)refreshStatusBar;

@end

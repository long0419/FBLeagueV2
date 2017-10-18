//
//  BaseTableViewController.h
//  FBLeague
//
//  Created by long-laptop on 2017/1/20.
//  Copyright © 2017年 long-laptop. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIView+Common.h"
//#import "UIViewController+Swizzle.h"
#import "NSObject+Common.h"
#import "UIImage+Common.h"
#import "MBProgressHUD.h"
#import "Masonry.h"
#import "NSString+Common.h"
//#import "RDVTabBarController.h"
#import "UINavigationController+FDFullscreenPopGesture.h"

@interface BaseTableViewController : UITableViewController<MBProgressHUDDelegate ,UIGestureRecognizerDelegate>

@property (nonatomic, retain) MBProgressHUD     *HUD;

- (void)showProgressViewWithTitle:(NSString *)msg;
- (void)showProgressView;

- (void)tabBarItemClicked;

- (void)setBackBottmAndTitle;

- (void)setBackTitle : (NSString *) title andWithSize : (CGFloat) size andWithColor :(NSString *) color ;

- (void)setRightBottom ;

- (void) showTabBottom ;

- (void) hideTabBottom ;

- (void) forbiddenGesture ;
- (void) goGesture ;

-(void)configureClearNavBar ;

@end

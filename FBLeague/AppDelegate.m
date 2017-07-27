//
//  AppDelegate.m
//  FBLeague
//
//  Created by long-laptop on 2016/11/9.
//  Copyright © 2016年 long-laptop. All rights reserved.
//

#import "AppDelegate.h"
#import <QMUIKit/QMUIKit.h>
#import "QMUIConfigurationTemplate.h"
#import "LianSaiViewController.h"
#import "LianmengViewController.h"
#import "JulebuViewController.h"
#import "MeViewController.h"
#import "QDUIHelper.h"
#import "QDTabBarViewController.h"
#import "QDNavigationController.h"
#import "FirstLoginViewController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {

    [[UIApplication sharedApplication] setApplicationIconBadgeNumber:1];
    [[UIApplication sharedApplication] setApplicationIconBadgeNumber:0];
    
    // 启动QMUI的配置模板
    [QMUIConfigurationTemplate setupConfigurationTemplate];
        
    // 将状态栏设置为希望的样式
    [QMUIHelper renderStatusBarStyleLight];
    
    //注册 登录
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(createTabBarController) name:@"verifyLoginStatus" object:nil];
        
    // 界面
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    [self showMsg];
    
    // 启动动画
    [self startLaunchingAnimation];
    
    
    return YES;
}

- (void) showMsg{
    FirstLoginViewController *vc = [[FirstLoginViewController alloc] init];
    RTRootNavigationController *nv = [[RTRootNavigationController alloc] initWithRootViewController:vc];
    [self.window setRootViewController:nv];
}


- (void)createTabBarController {
    QDTabBarViewController *tabBarViewController = [[QDTabBarViewController alloc] init];
    
    LianmengViewController *uikitViewController = [[LianmengViewController alloc] init];
    uikitViewController.hidesBottomBarWhenPushed = NO;
    RTRootNavigationController *uikitNavController = [[RTRootNavigationController alloc] initWithRootViewController:uikitViewController];
    uikitNavController.tabBarItem = [QDUIHelper tabBarItemWithTitle:@"动态" image:[UIImageMake(@"首页") imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] selectedImage:UIImageMake(@"首页-副本") tag:0];
    
    LianSaiViewController *componentViewController = [[LianSaiViewController alloc] init];
    componentViewController.hidesBottomBarWhenPushed = NO;
    RTRootNavigationController *componentNavController = [[RTRootNavigationController alloc] initWithRootViewController:componentViewController];
    componentNavController.tabBarItem = [QDUIHelper tabBarItemWithTitle:@"联赛" image:[UIImageMake(@"联赛") imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] selectedImage:UIImageMake(@"联赛") tag:1];
    
    JulebuViewController *labViewController = [[JulebuViewController alloc] init];
    labViewController.hidesBottomBarWhenPushed = NO;
    RTRootNavigationController *labNavController = [[RTRootNavigationController alloc] initWithRootViewController:labViewController];
    labNavController.tabBarItem = [QDUIHelper tabBarItemWithTitle:@"俱乐部" image:[UIImageMake(@"俱乐部") imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] selectedImage:UIImageMake(@"俱乐部") tag:2];
    
    MeViewController *uikitViewController2 = [[MeViewController alloc] init];
    uikitViewController2.hidesBottomBarWhenPushed = NO;
    RTRootNavigationController *uikitNavController2 = [[RTRootNavigationController alloc] initWithRootViewController:uikitViewController2];
    uikitNavController2.tabBarItem = [QDUIHelper tabBarItemWithTitle:@"我" image:[UIImageMake(@"我的") imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] selectedImage:UIImageMake(@"我的") tag:3];
    
    // window root controller
    tabBarViewController.viewControllers = @[uikitNavController, componentNavController, labNavController,uikitNavController2];
    self.window.rootViewController = tabBarViewController;
    [self.window makeKeyAndVisible];
}

- (void)startLaunchingAnimation {
    UIWindow *window = [[[UIApplication sharedApplication] delegate] window];
    UIView *launchScreenView = [[NSBundle mainBundle] loadNibNamed:@"LaunchScreen" owner:self options:nil].firstObject;
    launchScreenView.frame = window.bounds;
    [window addSubview:launchScreenView];
    
    UIImageView *backgroundImageView = launchScreenView.subviews[0];
    backgroundImageView.clipsToBounds = YES;
    
    UIImageView *logoImageView = launchScreenView.subviews[1];
    UILabel *copyrightLabel = launchScreenView.subviews.lastObject;
    
    UIView *maskView = [[UIView alloc] initWithFrame:launchScreenView.bounds];
    maskView.backgroundColor = UIColorWhite;
    [launchScreenView insertSubview:maskView belowSubview:backgroundImageView];
    
    [launchScreenView layoutIfNeeded];
    
    
    [launchScreenView.constraints enumerateObjectsUsingBlock:^(__kindof NSLayoutConstraint * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if ([obj.identifier isEqualToString:@"bottomAlign"]) {
            obj.active = NO;
            [NSLayoutConstraint constraintWithItem:backgroundImageView attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:launchScreenView attribute:NSLayoutAttributeTop multiplier:1 constant:NavigationContentTop].active = YES;
            *stop = YES;
        }
    }];
    
    [UIView animateWithDuration:.15 delay:0.9 options:QMUIViewAnimationOptionsCurveOut animations:^{
        [launchScreenView layoutIfNeeded];
        logoImageView.alpha = 0.0;
        copyrightLabel.alpha = 0;
    } completion:nil];
    [UIView animateWithDuration:1.2 delay:0.9 options:UIViewAnimationOptionCurveEaseOut animations:^{
        maskView.alpha = 0;
        backgroundImageView.alpha = 0;
    } completion:^(BOOL finished) {
        [launchScreenView removeFromSuperview];
    }];
}

@end

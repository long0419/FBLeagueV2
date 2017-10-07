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
#import <AlipaySDK/AlipaySDK.h>

@interface AppDelegate (){
}

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
    
    //红点
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(showsRedSpot:) name:@"showspot" object:nil];
    //去掉红点
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(removespot) name:@"removespot" object:nil];

    // 界面
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    [self showMsg];
    
    [WXApi registerApp:@"wxa8c4fb497943e690"];

    // 启动动画
    [self startLaunchingAnimation];
    
    return YES;
}

- (void) showMsg{
    FirstLoginViewController *vc = [[FirstLoginViewController alloc] init];
    RTRootNavigationController *nv = [[RTRootNavigationController alloc] initWithRootViewController:vc];
    [self.window setRootViewController:nv];
}

-(void)showsRedSpot:(NSNotification *)notification{
    [_uikitNavController2.tabBarItem showBadgeWithStyle:WBadgeStyleNumber value:notification.userInfo[@"textOne"] animationType:WBadgeAnimTypeShake];
}

-(void)removespot{
    [_uikitNavController2.tabBarItem clearBadge];
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
    _uikitNavController2 = [[RTRootNavigationController alloc] initWithRootViewController:uikitViewController2];
    _uikitNavController2.tabBarItem = [QDUIHelper tabBarItemWithTitle:@"我" image:[UIImageMake(@"我的") imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] selectedImage:UIImageMake(@"我的") tag:3];
    
    tabBarViewController.viewControllers = @[componentNavController, uikitNavController, labNavController , _uikitNavController2];
    self.window.rootViewController = tabBarViewController;
    [self.window makeKeyAndVisible];

}

- (void)startLaunchingAnimation {
    
    NSString *adImageJPGUrl = @"http://p5.image.hiapk.com/uploads/allimg/150112/7730-150112143S3.jpg";
    NSString *adimageGIFUrl = @"http://img.ui.cn/data/file/3/4/6/210643.gif";
    NSString *adImageJPGPath = [[NSBundle mainBundle] pathForResource:@"adImage2" ofType:@"jpg"];
    NSString *adImageGifPath = [[NSBundle mainBundle] pathForResource:@"adImage3" ofType:@"gif"];
    
    DHLaunchAdPageHUD *launchAd = [[DHLaunchAdPageHUD alloc] initWithFrame:CGRectMake(0, 0, DDScreenW, DDScreenH-100) aDduration:4.0 aDImageUrl:adImageGifPath hideSkipButton:NO launchAdClickBlock:^{
        NSLog(@"[AppDelegate]:点了广告图片");
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"https://www.baidu.com"]];
    }];

}

-(BOOL)application:(UIApplication *)app openURL:(NSURL *)url options:(NSDictionary<NSString *,id> *)options{
    
    if ([url.host isEqualToString:@"safepay"]) {
        // 支付跳转支付宝钱包进行支付，处理支付结果
        [[AlipaySDK defaultService] processOrderWithPaymentResult:url standbyCallback:^(NSDictionary *resultDic) {
            NSLog(@"result = %@",resultDic);
        }];
        
        // 授权跳转支付宝钱包进行支付，处理支付结果
        [[AlipaySDK defaultService] processAuth_V2Result:url standbyCallback:^(NSDictionary *resultDic) {
            NSLog(@"result = %@",resultDic);
            // 解析 auth code
            NSString *result = resultDic[@"result"];
            NSString *authCode = nil;
            if (result.length>0) {
                NSArray *resultArr = [result componentsSeparatedByString:@"&"];
                for (NSString *subResult in resultArr) {
                    if (subResult.length > 10 && [subResult hasPrefix:@"auth_code="]) {
                        authCode = [subResult substringFromIndex:10];
                        break;
                    }
                }
            }
            NSLog(@"授权结果 authCode = %@", authCode?:@"");
        }];
    }else{
        return [TencentOAuth HandleOpenURL:url] || [WXApi handleOpenURL:url delegate:[WXApiManager sharedManager]] || [QQApiInterface handleOpenURL:url delegate:self] ;
    }
    return YES;
}

- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation
{
    if ([url.host isEqualToString:@"safepay"]) {
        // 支付跳转支付宝钱包进行支付，处理支付结果
        [[AlipaySDK defaultService] processOrderWithPaymentResult:url standbyCallback:^(NSDictionary *resultDic) {
            NSLog(@"result = %@",resultDic);
        }];
        
        // 授权跳转支付宝钱包进行支付，处理支付结果
        [[AlipaySDK defaultService] processAuth_V2Result:url standbyCallback:^(NSDictionary *resultDic) {
            NSLog(@"result = %@",resultDic);
            // 解析 auth code
            NSString *result = resultDic[@"result"];
            NSString *authCode = nil;
            if (result.length>0) {
                NSArray *resultArr = [result componentsSeparatedByString:@"&"];
                for (NSString *subResult in resultArr) {
                    if (subResult.length > 10 && [subResult hasPrefix:@"auth_code="]) {
                        authCode = [subResult substringFromIndex:10];
                        break;
                    }
                }
            }
            NSLog(@"授权结果 authCode = %@", authCode?:@"");
        }];
    }else{
        return [WXApi handleOpenURL:url delegate:[WXApiManager sharedManager]] ;
    }
    return YES;
    
}

- (BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url
{
    return [WXApi handleOpenURL:url delegate:[WXApiManager sharedManager]] ;
}

- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken {
    
    // Required
    //    [JPUSHService registerDeviceToken:deviceToken];
}


- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo {
    
    // Required,For systems with less than or equal to iOS6
    //    [JPUSHService handleRemoteNotification:userInfo];
}

- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo fetchCompletionHandler:(void (^)(UIBackgroundFetchResult))completionHandler {
    
    // IOS 7 Support Required
    //    [JPUSHService handleRemoteNotification:userInfo];
    completionHandler(UIBackgroundFetchResultNewData);
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex

{
    if (alertView.tag==10000) {
        if (buttonIndex==1) {
            NSURL *url = [NSURL URLWithString:@"https://itunes.apple.com/us/app/ka-che-guan-jia/id1091500013?mt=8&uo=4"];
            [[UIApplication sharedApplication]openURL:url];
        }
    }
}

//微信原生SDK 回调
-(void) onResp:(BaseResp*)resp{
    SendAuthResp * resp1 = (SendAuthResp *)resp;
    if (resp1.errCode ==WXSuccess) {
        NSString * grantStr =@"grant_type=authorization_code";
        
        NSString * tokenUrl =@"https://api.weixin.qq.com/sns/oauth2/access_token?";
        
        NSString * tokenUrl1 = [tokenUrl stringByAppendingString:[NSString stringWithFormat:@"appid=%@&",MXWechatAPPID]];
        
        NSString * tokenUrl2 = [tokenUrl1 stringByAppendingString:[NSString stringWithFormat:@"secret=%@&",AppSecret]];
        
        NSString * tokenUrl3 = [tokenUrl2 stringByAppendingString:[NSString stringWithFormat:@"code=%@&",resp1.code]];
        NSString * tokenUrlend = [tokenUrl3 stringByAppendingString:grantStr];
        
        [PPNetworkHelper POST:tokenUrlend parameters:nil success:^(id data) {
            NSString * userfulStr = [NSString stringWithFormat:@"https://api.weixin.qq.com/sns/userinfo?access_token=%@&openid=%@" , data[@"access_token"] , data[@"openid"]];
            [PPNetworkHelper POST:userfulStr parameters:nil success:^(id data) {
                 [[NSNotificationCenter defaultCenter] postNotificationName:@"showRegisterView" object:data];
                
            } failure:^(NSError *error) {
            }];

        } failure:^(NSError *error) {
        }];

        
    }
}

@end

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
#import "UMMobClick/MobClick.h"
#import "AddSaiViewController.h"

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
    [[TencentOAuth alloc] initWithAppId:@"1105889047" andDelegate:nil]; //注册

    // 启动动画
    [self startLaunchingAnimation];
    
    UMConfigInstance.appKey = @"58c637f75312dd6ca8000c75";
    UMConfigInstance.channelId = @"App Store";
    UMConfigInstance.bCrashReportEnabled = YES ;
    [MobClick startWithConfigure:UMConfigInstance];//配置以上参数后调用此方法初始化SDK
    
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
    componentViewController.type = @"1";
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
    
//    NSString *adImageJPGUrl = @"http://p5.image.hiapk.com/uploads/allimg/150112/7730-150112143S3.jpg";
//    NSString *adimageGIFUrl = @"http://img.ui.cn/data/file/3/4/6/210643.gif";
    NSString *adImageJPGPath = [[NSBundle mainBundle] pathForResource:@"ad" ofType:@"jpg"];
//    NSString *adImageGifPath = [[NSBundle mainBundle] pathForResource:@"adImage3" ofType:@"gif"];
    
    DHLaunchAdPageHUD *launchAd = [[DHLaunchAdPageHUD alloc] initWithFrame:CGRectMake(0, 0, DDScreenW, DDScreenH-100) aDduration:4.0 aDImageUrl:adImageJPGPath hideSkipButton:NO launchAdClickBlock:^{
//        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"https://www.baidu.com"]];
    }];

}

-(BOOL)application:(UIApplication *)app openURL:(NSURL *)url options:(NSDictionary<NSString *,id> *)options{
    
    if ([url.host isEqualToString:@"safepay"]) {
        // 支付跳转支付宝钱包进行支付，处理支付结果
        [[AlipaySDK defaultService] processOrderWithPaymentResult:url standbyCallback:^(NSDictionary *resultDic) {
            NSLog(@"支付成功1 = %@",resultDic);
            
            if ([resultDic[@"resultStatus"] isEqualToString:@"9000"]) {
                [[NSNotificationCenter defaultCenter] postNotificationName:@"baoming" object:nil];
            }else{
                [SVProgressHUD showSuccessWithStatus:resultDic[@"memo"]];
                [SVProgressHUD setDefaultStyle:SVProgressHUDStyleDark];

            }

        }];
        
        // 授权跳转支付宝钱包进行支付，处理支付结果
        [[AlipaySDK defaultService] processAuth_V2Result:url standbyCallback:^(NSDictionary *resultDic) {
            NSLog(@"支付成功2 = %@",resultDic);
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

- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo fetchCompletionHandler:(void (^)(UIBackgroundFetchResult))completionHandler {
    
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
    if([resp isKindOfClass:[SendMessageToWXResp class]] || [resp isKindOfClass:[SendMessageToQQResp class]]){
        if (resp1.errCode == -2) {
            [SVProgressHUD showErrorWithStatus:@"分享失败"];
            [SVProgressHUD setDefaultStyle:SVProgressHUDStyleDark];
        }else{
            [SVProgressHUD showSuccessWithStatus:@"分享成功"];
            [SVProgressHUD setDefaultStyle:SVProgressHUDStyleDark];
        }
        
    }else{
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
    
    
}

-(void)share :(NSString *)_cupType {
    
    NSString *share = @"share" ;
    if ([_cupType isEqualToString:@"2"]) {
        share = @"杯赛分享" ;
    }

    [BHBPopView showToView:self.window
                 andImages:@[@"wechat.png",
                             @"qq.png",
                             @"friend.png"]
                 andTitles:
     @[@"微信",@"QQ",@"朋友圈"]
            andSelectBlock:^(BHBItem *item) {
                if ([item.title isEqualToString:@"微信"]) {
                    WXMediaMessage *message = [WXMediaMessage message];
                    [message setThumbImage:[UIImage imageNamed:@"QR"]];
                    WXImageObject *imageObject = [WXImageObject object];
                    
                    NSString *filePath = [[NSBundle mainBundle] pathForResource:share ofType:@"jpg"];
                    imageObject.imageData = [NSData dataWithContentsOfFile:filePath];
                    message.mediaObject = imageObject ;
                    
                    SendMessageToWXReq *req = [[SendMessageToWXReq alloc] init];
                    req.bText = NO ;
                    req.message = message ;
                    req.scene = WXSceneSession ;
                    [WXApi sendReq :req];
                    
                    
                }else if([item.title isEqualToString:@"QQ"]){
                    NSString *filePath = [[NSBundle mainBundle] pathForResource:share ofType:@"jpg"];
                    NSData *imgData = [NSData dataWithContentsOfFile:filePath];
                    QQApiImageObject *imgObj = [QQApiImageObject
                                                objectWithData:
                                                imgData
                                                previewImageData:
                                                UIImagePNGRepresentation(                                                [UIImage imageNamed:@"QR"])
                                                title:@"报名成功"
                                                description:@"咖盟报名成功"];
                    SendMessageToQQReq *req = [SendMessageToQQReq reqWithContent:imgObj];
                    [QQApiInterface sendReq:req];
                    
                }else if([item.title isEqualToString:@"朋友圈"]){
                    WXMediaMessage *message = [WXMediaMessage message];
                    [message setThumbImage:[UIImage imageNamed:@"150876415"]];
                    WXImageObject *imageObject = [WXImageObject object];
                    
                    NSString *filePath = [[NSBundle mainBundle] pathForResource:share ofType:@"jpg"];
                    imageObject.imageData = [NSData dataWithContentsOfFile:filePath];
                    message.mediaObject = imageObject ;
                    
                    SendMessageToWXReq *req = [[SendMessageToWXReq alloc] init];
                    req.bText = NO ;
                    req.message = message ;
                    req.scene = WXSceneTimeline ;
                    [WXApi sendReq :req];
                    
                }
            }
     ];
    
}


@end

//
//  AppDelegate.h
//  FBLeague
//
//  Created by long-laptop on 2016/11/9.
//  Copyright © 2016年 long-laptop. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DHLaunchAdPageHUD.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate, QQApiInterfaceDelegate ,WXApiDelegate>


@property (strong, nonatomic) UIWindow *window;
@property (strong, nonatomic) RTRootNavigationController *uikitNavController2 ;

-(void)showMsg ;
-(void)share :(NSString *) type ;

@end


//
//  LoginViewController.h
//  FBLeague
//
//  Created by long-laptop on 2017/7/2.
//  Copyright © 2017年 long-laptop. All rights reserved.
//

#import <QMUIKit/QMUIKit.h>
#import "WPAutoSpringTextViewController.h"
#import "WXApi.h"
#import <TencentOpenAPI/TencentOAuth.h>

@interface LoginViewController : WPAutoSpringTextViewController<UITextFieldDelegate,TencentSessionDelegate>
@end

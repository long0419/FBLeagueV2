//
//  LoginViewController.h
//  kinvest
//
//  Created by long-laptop on 16/4/11.
//  Copyright © 2016年 long-laptop. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RegisterViewController.h"
#import "BaseViewController.h"
#import "WPAutoSpringTextViewController.h"
#import "WXApi.h"
#import <TencentOpenAPI/TencentOAuth.h>
//#import <TencentOpenAPI/TencentApiInterface.h>

@interface LoginViewController : WPAutoSpringTextViewController<UITextFieldDelegate ,TencentSessionDelegate>

@property (nonatomic , strong) UIView *account ;
@property (nonatomic , strong) UIView *psw ;

@end

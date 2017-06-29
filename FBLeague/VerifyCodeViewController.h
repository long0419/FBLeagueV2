//
//  VerifyCodeViewController.h
//  kinvest
//
//  Created by long-laptop on 16/4/11.
//  Copyright © 2016年 long-laptop. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseViewController.h"
#import "RegisterViewController.h"
#import "APIClient.h"
#import "WPAutoSpringTextViewController.h"
#import "FindPswViewController.h"

@interface VerifyCodeViewController : WPAutoSpringTextViewController
    <UIImagePickerControllerDelegate , UITextFieldDelegate , UIActionSheetDelegate>

@property (nonatomic , strong) UIView *regis ;
@property (nonatomic , strong) NSString *from ;
@property (nonatomic , strong) NSString *nickName ;
@property (nonatomic , strong) NSString *openId ;

@property (nonatomic , strong) UIView *account ;
@property (nonatomic , strong) UIView *psw ;

@property (nonatomic , strong) NSString *imageUrl ;

@end

//
//  VerifyCodeView2ViewController.h
//  FBLeague
//
//  Created by long-laptop on 2016/11/21.
//  Copyright © 2016年 long-laptop. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseViewController.h"
#import "ChooseRoleViewController.h"
#import "ChooseAreaViewController.h"
#import "WPAutoSpringTextViewController.h"

@interface VerifyCodeView2ViewController : WPAutoSpringTextViewController <UITextFieldDelegate , UIImagePickerControllerDelegate , UIActionSheetDelegate>

@property (nonatomic , strong) UIView *regis ;
@property (nonatomic , strong) NSString *nickName ;
@property (nonatomic , strong) NSString *openId ;

@property (nonatomic , strong) UIView *account ;
@property (nonatomic , strong) UIView *psw ;
@property (nonatomic , strong) UIView *role ;
@property (nonatomic , strong) UIView *area ;

@property (nonatomic , strong) NSString *phone ;
@property (nonatomic , strong) NSString *imageUrl ;

@property (nonatomic , strong) NSString *roleStr ;
@property (nonatomic , strong) NSString *areaStr ;
@property (nonatomic , strong) NSString *areaCodeStr ;


@end

//
//  RegisterViewController.m
//  kinvest
//
//  Created by long-laptop on 16/4/11.
//  Copyright © 2016年 long-laptop. All rights reserved.
//

#import "RegisterViewController.h"
#import "UIView+Common.h"
#import "RegisterTxtView.h"
#import "VerifyCodeViewController.h"
#import "RegisterViewController.h"
#import "UserDataVo.h"
#import "MWLocalDataTool.h"
#import "MainViewController.h"
//#import "JPUSHService.h"
#import "CommonFunc.h"

@interface RegisterViewController (){
    UITextField *nickName ;
    UITextField *phoneNum ;
    UITextField *password  ;
}

@end

@implementation RegisterViewController

-(void)loadView{
    [super loadView];
    CGRect frame = [UIView frameWithOutNavTab];
    self.view = [[UIView alloc] initWithFrame:frame];
    self.view.backgroundColor = [UIColor colorWithHexString:@"f2f7f7"];
    self.title = @"注册" ;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [super setBackBottmAndTitle];

    CGRect nickframe = CGRectMake(0, 30, kScreen_Width , 45) ;
    UIView *nick = [RegisterTxtView registerView:@"昵称" andWithDefaultText:@"请输入昵称" andWithRect:nickframe];
    nickName = [nick viewWithTag:21];
    nickName.delegate = self ;
    if (nil != _nickname) {
        nickName.text = _nickname ;
    }
    [self.view addSubview:nick];

    CGRect pswframe = CGRectMake(0, nick.bottom - 2, kScreen_Width , 45) ;
    UIView *psw = [RegisterTxtView registerView:@"密码" andWithDefaultText:@"请输入密码(不少于6位)" andWithRect:pswframe];
    password = [psw viewWithTag:21];
    password.delegate = self ;
    [self.view addSubview:psw];
    
    UIButton *regi = [UIButton buttonWithType: UIButtonTypeCustom];
    regi.frame = CGRectMake(18, psw.bottom + 30 , kScreen_Width - 36 , 42) ;
    regi.backgroundColor = [UIColor colorWithHexString:@"0ec481"];
    [regi setTitle:@"注册" forState:UIControlStateNormal];
    [regi.layer setCornerRadius:3]; //设置矩形四个圆角半径
    [regi addTarget:self action:@selector(regi) forControlEvents:UIControlEventTouchUpInside];//button 点击回调方法
    [self.view addSubview:regi];
    
    CGSize size = [NSString getStringContentSizeWithFontSize:12 andContent:@"注册即同意《用户注册协议》"];
    UILabel *msg = [[UILabel alloc] initWithFrame:CGRectMake((kScreen_Width - size.width)/2, regi.bottom + 18, size.width, size.height)];
    msg.textColor = [UIColor colorWithHexString:@"9c9c9c"];
    msg.text = @"注册即同意《用户注册协议》";
    msg.font = [UIFont systemFontOfSize:12];
    [self.view addSubview:msg];
}

-(void)regi{
    [password resignFirstResponder];
}

-(void)back{
    [self.navigationController popViewControllerAnimated:YES];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder] ;
    return true;
}

-(BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    
    if ([text isEqualToString:@"\n"]) {
        
        [textView resignFirstResponder];
        
        return NO;
        
    }
    return YES;
}

@end

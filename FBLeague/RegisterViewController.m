//
//  RegisterViewController.m
//  kinvest
//
//  Created by long-laptop on 16/4/11.
//  Copyright © 2016年 long-laptop. All rights reserved.
//

#import "RegisterViewController.h"
#import "UIView+Common.h"
#import "RegisterViewController.h"
#import "UserDataVo.h"
#import "MWLocalDataTool.h"
#import "CommonFunc.h"
#import "DSLLoginTextField.h"
#import "ZLVerifyCodeButton.h"
#import "VerifyPswViewController.h"

@interface RegisterViewController (){
    UITextField *nickName ;
    UITextField *phoneNum ;
    UITextField *password  ;
    ZLVerifyCodeButton *codeBtn ;
    DSLLoginTextField *tf ;
    DSLLoginTextField *psw ;
    QMUIButton *button ;
    NSString *valiCode ;
}

@end

@implementation RegisterViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor colorWithHexString:@"ffffff"];
    if ([self.from isEqualToString:@"1"]) {
        self.title = @"注册" ;
    }else{
        self.title = @"忘记密码" ;
    }
    
    self.navigationController.navigationBar.titleTextAttributes = [NSDictionary dictionaryWithObjectsAndKeys:[UIColor blackColor], UITextAttributeTextColor,nil];
    self.navigationController.navigationBar.barTintColor = [UIColor whiteColor];
    [self setBackBottmAndTitle];
    
    tf=[[DSLLoginTextField alloc]init];
    tf.clearButtonMode=UITextFieldViewModeWhileEditing;
    tf.placeholderColor=[UIColor colorWithHexString:@"cdcdcd"];
    tf.font=[UIFont systemFontOfSize:14];
    tf.placeholder=@"输入注册手机号";
    tf.delegate = self ;
    tf.maxTextLength= 11;
    tf.textAlignment = NSTextAlignmentCenter ;
    [self.view addSubview:tf];
    [tf mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo((198+168+90)/2);
        make.centerX.mas_equalTo(self.view);
        make.left.mas_equalTo(SYRealValue(30)) ;
        make.height.mas_equalTo(SYRealValue(40));
        make.width.mas_equalTo(self.view.width - 60);
    }];

    psw=[[DSLLoginTextField alloc]init];
    psw.clearButtonMode=UITextFieldViewModeWhileEditing;
    psw.placeholderColor=[UIColor colorWithHexString:@"cdcdcd"];
    psw.font=[UIFont systemFontOfSize:14];
    psw.placeholder=@"输入验证码";
    psw.maxTextLength= 11;
    psw.delegate = self ;
    psw.keyboardType = UIKeyboardTypeNumberPad ;
    psw.textAlignment = NSTextAlignmentLeft ;
    [self.view addSubview:psw];
    [psw mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(tf.mas_bottom).with.offset(20) ;
        make.centerX.mas_equalTo(self.view);
        make.left.mas_equalTo(SYRealValue(30)) ;
        make.height.mas_equalTo(SYRealValue(40));
        make.width.mas_equalTo(self.view.width - 60);
    }];
    
    codeBtn = [ZLVerifyCodeButton new];
    [codeBtn addTarget:self action:@selector(codeBtnVerification) forControlEvents:UIControlEventTouchUpInside];
    [psw addSubview:codeBtn];
    [codeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(psw.mas_top) ;
        make.right.mas_equalTo(psw.mas_right);
        make.width.mas_equalTo(kScreen_Width/3);
        make.height.equalTo(psw);
    }];

    button = [[QMUIButton alloc] init];
    button.adjustsButtonWhenHighlighted = YES;
    button.titleLabel.font = UIFontBoldMake(37/2);
    [button setTitleColor:UIColorWhite forState:UIControlStateNormal];
    button.backgroundColor = [UIColor blackColor];
    button.highlightedBackgroundColor = [UIColor colorWithHexString:@"5a70d6"];    button.layer.cornerRadius = 4;
    [button setUserInteractionEnabled:NO];
    [button setTitle:@"下一步" forState:UIControlStateNormal];
    [button addTarget:self action:@selector(verifycode) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
    [button mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(psw.mas_bottom).with.offset(35);
        make.centerX.mas_equalTo(self.view);
        make.left.mas_equalTo(SYRealValue(30)) ;
        make.height.mas_equalTo(SYRealValue(40));
        make.width.mas_equalTo((self.view.width - 60));
    }];

}

-(void) verifycode{
    
    if (![valiCode isEqualToString:psw.text]) {
        [SVProgressHUD showErrorWithStatus:@"验证码输入不正确"];
        [SVProgressHUD setDefaultStyle:SVProgressHUDStyleDark];
        
        return ;
    }

    VerifyPswViewController *verify = [VerifyPswViewController new];
    verify.phoneNum = tf.text ;
    verify.from = _from ;
    verify.img = _imageUrl ;
    verify.nikeName = _nickname ;
    [self.navigationController pushViewController:verify animated:YES];
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

-(void)codeBtnVerification{
    
    if ([@"" isEqualToString:tf.text]|| nil == tf.text) {
        [SVProgressHUD showErrorWithStatus:@"请输入手机号"];
        [SVProgressHUD setDefaultStyle:SVProgressHUDStyleDark];
        
        return ;
    }
    
    [codeBtn timeFailBeginFrom:60];  // 倒计时60s
    valiCode = [NSString getAuthcode];
    NSLog(@"valiCode : %@" , valiCode) ;
    NSDictionary *params = [NSDictionary dictionaryWithObjectsAndKeys:tf.text , @"phone" , valiCode , @"valiCode" , nil];
    
    [PPNetworkHelper POST:sms parameters:params success:^(id data) {
        if([data[@"code"] isEqualToString:@"0000"]){
            [button setUserInteractionEnabled:YES];
        }else if ([data[@"code"] isEqualToString:@"1"]) {
            [codeBtn timeFailBeginFrom:1];
        }

    } failure:^(NSError *error) {
        
    }];
    
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    [tf resignFirstResponder];
    [psw resignFirstResponder];
}

@end

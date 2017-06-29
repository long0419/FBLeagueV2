//
//  ForgetPswViewController.m
//  kinvest
//
//  Created by long-laptop on 16/4/14.
//  Copyright © 2016年 long-laptop. All rights reserved.
//

#import "ForgetPswViewController.h"
#import "RegisterTxtView.h"
#import "UserDataVo.h"
#import "MWLocalDataTool.h"
#import "MainViewController.h"

@interface ForgetPswViewController (){
    UITextField *pswView1 ;
    UITextField *pswView2 ;
}

@end

@implementation ForgetPswViewController

-(void)loadView{
    [super loadView];
    CGRect frame = [UIView frameWithOutNavTab];
    self.view = [[UIView alloc] initWithFrame:frame];
    self.view.backgroundColor = [UIColor colorWithHexString:@"f2f7f7"];
    self.title = @"找回密码" ;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [super setBackBottmAndTitle];

    CGRect nickframe = CGRectMake(0, 30, kScreen_Width , 45) ;
    UIView *psw1 = [RegisterTxtView registerView:@"请输入密码" andWithDefaultText:@"请输入密码(不少于6位)" andWithRect:nickframe];
    pswView1 = [psw1 viewWithTag:21];
    pswView1.delegate =  self ;
    [self.view addSubview:psw1];
    
    CGRect pswframe = CGRectMake(0, psw1.bottom - 2, kScreen_Width , 45) ;
    UIView *psw2 = [RegisterTxtView registerView:@"请再次输入密码" andWithDefaultText:@"请再次输入密码(不少于6位)" andWithRect:pswframe];
    pswView2 = [psw1 viewWithTag:21];
    pswView2.delegate = self ;
    [self.view addSubview:psw2];
    
    UIButton *regi = [UIButton buttonWithType: UIButtonTypeCustom];
    regi.frame = CGRectMake(18, psw2.bottom + 30 , kScreen_Width - 36 , 42) ;
    regi.backgroundColor = [UIColor colorWithHexString:@"0ec481"];
    [regi setTitle:@"确定" forState:UIControlStateNormal];
    [regi.layer setCornerRadius:3]; //设置矩形四个圆角半径
    [regi addTarget:self action:@selector(regi) forControlEvents:UIControlEventTouchUpInside];//button 点击回调方法
    [self.view addSubview:regi];
}

-(void)regi{
    
    self.HUD = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    
    if(![pswView1.text isEqualToString:pswView2.text]){
        self.HUD.mode = MBProgressHUDModeText;
        self.HUD.removeFromSuperViewOnHide = YES;
        self.HUD.labelText = @"两次密码不一致";
        [self.HUD hide:YES afterDelay:3];
        return ;
    }
    
    APIClient *client = [APIClient sharedJsonClient];
    NSDictionary *params = [NSDictionary dictionaryWithObjectsAndKeys:_phoneNum , @"phoneNum" ,pswView1.text, @"newpassword" , nil];
    [client requestJsonDataWithPath:changePassword withParams:params withMethodType:Post andBlock:^(id data, NSError *error) {
        if([data[@"code"] isEqualToString:@"0000"]){
            UserDataVo *user = [UserDataVo new];
            user.phone = _phoneNum ;
            user.pwd = pswView1.text ;
            NSData *data = [NSKeyedArchiver archivedDataWithRootObject:user];
            [[MWLocalDataTool shareInstance] saveNSUserDefaultsWithKey:@"userData" AndObject:data];
            //跳转列表
            [[NSNotificationCenter defaultCenter] postNotificationName:@"verifyLoginStatus" object:self];
        }else {
            self.HUD.mode = MBProgressHUDModeText;
            self.HUD.removeFromSuperViewOnHide = YES;
            self.HUD.labelText = data[@"message"];
            [self.HUD hide:YES afterDelay:3];
        }
        [self closeProgressView];
    }];
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

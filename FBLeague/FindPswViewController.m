//
//  FindPswViewController.m
//  FBLeague
//
//  Created by long-laptop on 2017/3/11.
//  Copyright © 2017年 long-laptop. All rights reserved.
//

#import "FindPswViewController.h"
#import "AccountView.h"

@interface FindPswViewController (){
    UITextField *phoneText ;
    UITextField *phoneText2 ;

}

@end

@implementation FindPswViewController

- (void)viewDidLoad {
    [super viewDidLoad];
//    self.view.backgroundColor = [UIColor colorWithHexString:@"f6f6f6"];
    
    
    self.title = @"找回密码" ;
    [self setBackBottmAndTitle];

    CGSize tempSize = [NSString getStringContentSizeWithFontSize:14 andContent:@"请输入手机号"] ;
    CGRect accountFrame = CGRectMake(30 , 44 , kScreen_Width , tempSize.height + 14 + .5) ;
    _account = [AccountView accountView:@"" andWithDefaultText:@"请输入密码" andWithCGRect:accountFrame];
    _account.frame = accountFrame ;
    phoneText = [_account viewWithTag:11];
    phoneText.secureTextEntry = YES;
    phoneText.returnKeyType = UIReturnKeyGo ;
    phoneText.delegate = self ;
    [self.view addSubview:_account];
    
    CGSize tempSize2 = [NSString getStringContentSizeWithFontSize:14 andContent:@"请再次输入密码"] ;
    CGRect accountFrame2 = CGRectMake(30 , _account.bottom + 20, kScreen_Width , tempSize2.height + 14 + .5) ;
    _account2 = [AccountView accountView:@"" andWithDefaultText:@"请再次输入密码" andWithCGRect:accountFrame2];
    _account2.frame = accountFrame2 ;
    phoneText2 = [_account2 viewWithTag:11];
    phoneText2.secureTextEntry = YES;
    phoneText2.returnKeyType = UIReturnKeyGo ;
    phoneText2.delegate = self ;
    [self.view addSubview:_account2];
    
    UIButton *exit = [[UIButton alloc] initWithFrame:CGRectMake((kScreen_Width - kScreen_Width + 30)/2, _account2.bottom + 30 , kScreen_Width - 36 , 82/2)];
    [exit setTitle:@"修改密码" forState:UIControlStateNormal];
    exit.titleLabel.font = [UIFont systemFontOfSize: 34/2];
    [exit addTarget:self action:@selector(publish) forControlEvents:UIControlEventTouchUpInside];
    [exit.layer setCornerRadius:4]; //设置矩形四个圆角半径
    exit.backgroundColor = [UIColor colorWithHexString:@"2eb66as"];
    [self.view addSubview:exit];

}


-(void)publish{
    self.HUD = [MBProgressHUD showHUDAddedTo:self.view animated:YES];

    if ([phoneText.text isEqualToString:@""]
        || [phoneText2.text isEqualToString:@""]) {
        self.HUD.mode = MBProgressHUDModeText;
        self.HUD.removeFromSuperViewOnHide = YES;
        self.HUD.labelText = @"请输入密码";
        [self.HUD hide:YES afterDelay:5];
    }
    
    APIClient *client = [APIClient sharedJsonClient];
    NSDictionary *params = [NSDictionary dictionaryWithObjectsAndKeys:_phone , @"phoneNum" ,phoneText.text , @"newpassword" , nil];
    [client requestJsonDataWithPath:changePassword withParams:params withMethodType:Post andBlock:^(id data, NSError *error) {
        if([data[@"code"] isEqualToString:@"0000"]){
            self.HUD.mode = MBProgressHUDModeText;
            self.HUD.removeFromSuperViewOnHide = YES;
            self.HUD.labelText = @"修改密码成功";
            [self.HUD hide:YES afterDelay:7];
            [self.navigationController popToRootViewControllerAnimated:YES];
        }else{
            self.HUD.mode = MBProgressHUDModeText;
            self.HUD.removeFromSuperViewOnHide = YES;
            self.HUD.labelText = @"系统错误";
            [self.HUD hide:YES afterDelay:5];
        }
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

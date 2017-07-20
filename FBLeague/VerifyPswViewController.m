//
//  VerifyPswViewController.m
//  FBLeague
//
//  Created by long-laptop on 2017/7/4.
//  Copyright © 2017年 long-laptop. All rights reserved.
//

#import "VerifyPswViewController.h"
#import "DSLLoginTextField.h"
#import "PersonInfoViewController.h"
#import "UserDataVo.h"

@interface VerifyPswViewController (){
    DSLLoginTextField *tf ;
    DSLLoginTextField *psw ;
    
}

@end

@implementation VerifyPswViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor colorWithHexString:@"ffffff"];
    self.title = @"设置密码" ;
    self.navigationController.navigationBar.titleTextAttributes = [NSDictionary dictionaryWithObjectsAndKeys:[UIColor blackColor], UITextAttributeTextColor,nil];
    self.navigationController.navigationBar.barTintColor = [UIColor whiteColor];
    [self setBackBottmAndTitle];
    
    tf=[[DSLLoginTextField alloc]init];
    tf.clearButtonMode=UITextFieldViewModeWhileEditing;
    tf.placeholderColor=[UIColor colorWithHexString:@"cdcdcd"];
    tf.font=[UIFont systemFontOfSize:14];
    tf.placeholder=@"输入密码";
    tf.delegate = self ;
    tf.secureTextEntry = YES;
    tf.returnKeyType = UIReturnKeyGo ;
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
    psw.placeholder=@"确认密码";
    psw.maxTextLength= 11;
    psw.delegate = self ;
    psw.secureTextEntry = YES;
    psw.returnKeyType = UIReturnKeyGo ;
    psw.textAlignment = NSTextAlignmentCenter ;
    [self.view addSubview:psw];
    [psw mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(tf.mas_bottom).with.offset(20) ;
        make.centerX.mas_equalTo(self.view);
        make.left.mas_equalTo(SYRealValue(30)) ;
        make.height.mas_equalTo(SYRealValue(40));
        make.width.mas_equalTo(self.view.width - 60);
    }];
    
    QMUIButton *button = [[QMUIButton alloc] init];
    button.adjustsButtonWhenHighlighted = YES;
    button.titleLabel.font = UIFontBoldMake(37/2);
    [button setTitleColor:UIColorWhite forState:UIControlStateNormal];
    button.backgroundColor = [UIColor blackColor];
    button.highlightedBackgroundColor = [UIColor colorWithHexString:@"5a70d6"];    button.layer.cornerRadius = 4;
    [button setTitle:@"下一步" forState:UIControlStateNormal];
    [button addTarget:self action:@selector(goinfo) forControlEvents:UIControlEventTouchUpInside];

    [self.view addSubview:button];
    [button mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(psw.mas_bottom).with.offset(35);
        make.centerX.mas_equalTo(self.view);
        make.left.mas_equalTo(SYRealValue(30)) ;
        make.height.mas_equalTo(SYRealValue(40));
        make.width.mas_equalTo((self.view.width - 60));
    }];
}

-(void)goinfo{
    self.HUD = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    
    if([@"" isEqualToString:psw.text] ||[@"" isEqualToString:psw.text]){
        self.HUD.mode = MBProgressHUDModeText;
        self.HUD.removeFromSuperViewOnHide = YES;
        self.HUD.labelText = @"请输入相应密码";
        [self.HUD hide:YES afterDelay:3];
        return ;
    }
    
    if(![tf.text isEqualToString:psw.text]){
        self.HUD.mode = MBProgressHUDModeText;
        self.HUD.removeFromSuperViewOnHide = YES;
        self.HUD.labelText = @"两次密码不一致";
        [self.HUD hide:YES afterDelay:3];
        return ;
    }
    [self closeProgressView];

    if ([self.from isEqualToString:@"1"]) {
        PersonInfoViewController *person = [[PersonInfoViewController alloc] init];
        person.phoneNum = _phoneNum ;
        person.psw = psw.text ;
        [self.navigationController pushViewController:person animated:YES];
    }else{
        self.HUD = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        
        NSDictionary *params = [NSDictionary dictionaryWithObjectsAndKeys:_phoneNum , @"phone" , nil];
        
        
        [PPNetworkHelper POST:apiupdate parameters:params success:^(id data) {
            if([data[@"code"] isEqualToString:@"0000"]){
                UserDataVo *uvo = [UserDataVo new];
                uvo.nickname = tf.text ;
                uvo.phone = _phoneNum ;
//                uvo.pwd = _psw ;
                
                YYCache *cache = [YYCache cacheWithName:@"FB"];
                [cache setObject:uvo forKey:@"userData"];

                [[NSNotificationCenter defaultCenter] postNotificationName:@"verifyLoginStatus" object:self];
                
                [self closeProgressView];
                
            }else {
                self.HUD.mode = MBProgressHUDModeText;
                self.HUD.removeFromSuperViewOnHide = YES;
                self.HUD.labelText = @"系统错误";
                [self.HUD hide:YES afterDelay:3];
            }

            
        } failure:^(NSError *error) {
            
        }];
        
        [self closeProgressView];

    }
    
    
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

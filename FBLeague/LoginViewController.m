//
//  LoginViewController.m
//  FBLeague
//
//  Created by long-laptop on 2017/7/2.
//  Copyright © 2017年 long-laptop. All rights reserved.
//

#import "LoginViewController.h"
#import "DSLLoginTextField.h"
#import "UserDataVo.h"
#import "RegisterViewController.h"
#import "CommonFunc.h"

@interface LoginViewController (){
    DSLLoginTextField *tf ;
    DSLLoginTextField *psw ;
    TencentOAuth *_tencentOAuth;
    NSMutableArray *_permissionArray;

}

@end

@implementation LoginViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor colorWithHexString:@"ffffff"];
    
    UIImageView *back = [[UIImageView alloc]
                         initWithImage:[UIImage imageNamed:@"返回"]];
    back.userInteractionEnabled = YES;
    UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleSingleTap)];
    [back addGestureRecognizer:singleTap];
    [self.view addSubview:back];
    
    [back mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(30) ;
        make.top.mas_equalTo(35);
    }];
    
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(on:)   name:@"showRegisterView" object:nil];
    
    UIView *bgView = [[UIView alloc] initWithFrame:CGRectMake((self.view.width - 168/2)/2, 198/2 , 168/2 , 168/2)];
    bgView.layer.borderWidth = 1;
    bgView.layer.cornerRadius = 168/4 ;
    bgView.layer.borderColor = [[UIColor lightGrayColor] CGColor];
    [self.view addSubview:bgView];
    
    UIImageView *bgImg = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"head"]];
    bgImg.layer.cornerRadius= (156/4) ;
    bgImg.layer.masksToBounds=YES;
    [self.view addSubview:bgImg];    
    [bgImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(bgView);
    }];
    
    
    tf=[[DSLLoginTextField alloc]init];
    tf.clearButtonMode=UITextFieldViewModeWhileEditing;
    tf.placeholderColor=[UIColor colorWithHexString:@"cdcdcd"];
    tf.font=[UIFont systemFontOfSize:14];
    tf.placeholder=@"输入注册手机号";
    tf.delegate = self ;
    tf.maxTextLength= 11;
    tf.delegate = self ;

    tf.textAlignment = NSTextAlignmentCenter ;
    [self.view addSubview:tf];
    [tf mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(bgImg.mas_bottom).with.offset(45) ;
        make.centerX.mas_equalTo(self.view);
        make.left.mas_equalTo(SYRealValue(30)) ;
        make.height.mas_equalTo(SYRealValue(40));
        make.width.mas_equalTo(self.view.width - 60);
    }];
    
    psw=[[DSLLoginTextField alloc]init];
    psw.clearButtonMode=UITextFieldViewModeWhileEditing;
    psw.placeholderColor=[UIColor colorWithHexString:@"cdcdcd"];
    psw.font=[UIFont systemFontOfSize:14];
    psw.placeholder=@"输入密码";
    psw.maxTextLength= 11;
    psw.delegate = self ;
    psw.textAlignment = NSTextAlignmentCenter ;
    psw.secureTextEntry = YES;
    psw.returnKeyType = UIReturnKeyGo ;
    [self.view addSubview:psw];
    [psw mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(tf.mas_bottom).with.offset(20) ;
        make.centerX.mas_equalTo(self.view);
        make.left.mas_equalTo(SYRealValue(30)) ;
        make.height.mas_equalTo(SYRealValue(40));
        make.width.mas_equalTo(self.view.width - 60);
    }];
    
    CGSize forgetText = [NSString getStringContentSizeWithFontSize:11 andContent:@"忘记密码?"];
    UIButton *forgetBtn = [UIButton buttonWithType: UIButtonTypeCustom];
    forgetBtn.backgroundColor = [UIColor clearColor];
    [forgetBtn setTitle:@"忘记密码?" forState:UIControlStateNormal];
    forgetBtn.titleLabel.font = [UIFont systemFontOfSize:11];
    [forgetBtn setTitleColor:[UIColor colorWithHexString:@"000000"]forState:UIControlStateNormal];
    [forgetBtn addTarget:self action:@selector(forget) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:forgetBtn];
    [forgetBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(forgetText.width+2);
        make.height.mas_equalTo(forgetText.height);
        make.left.mas_equalTo(self.view.right - forgetText.width - 30);
        make.top.mas_equalTo(psw.mas_bottom).with.offset(3);
    }];
    
    QMUIButton *button = [[QMUIButton alloc] init];
    button.adjustsButtonWhenHighlighted = YES;
    button.titleLabel.font = UIFontBoldMake(37/2);
    [button setTitleColor:UIColorWhite forState:UIControlStateNormal];
    button.backgroundColor = [UIColor blackColor];
    button.highlightedBackgroundColor = [UIColor colorWithHexString:@"5a70d6"];    button.layer.cornerRadius = 4;
    [button addTarget:self action:@selector(loginAction) forControlEvents:UIControlEventTouchUpInside];
    [button setTitle:@"登录" forState:UIControlStateNormal];
    [self.view addSubview:button];
    [button mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(psw.mas_bottom).with.offset(35);
        make.centerX.mas_equalTo(self.view);
        make.left.mas_equalTo(SYRealValue(30)) ;
        make.height.mas_equalTo(SYRealValue(40));
        make.width.mas_equalTo((self.view.width - 60));
    }];
    
    CGSize useText = [NSString getStringContentSizeWithFontSize:12 andContent:@"使用第三方登录"];
    UIButton *useBtn = [UIButton buttonWithType: UIButtonTypeCustom];
    useBtn.backgroundColor = [UIColor clearColor];
    [useBtn setTitle:@"使用第三方登录" forState:UIControlStateNormal];
    useBtn.titleLabel.font = [UIFont systemFontOfSize:12];
    [useBtn setTitleColor:[UIColor colorWithHexString:@"000000"]forState:UIControlStateNormal];
    [useBtn addTarget:self action:@selector(forget) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:useBtn];
    [useBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(useText.width+2);
        make.height.mas_equalTo(useText.height);
        make.centerX.mas_equalTo(self.view) ;
        make.top.mas_equalTo(button.mas_bottom).with.offset(SYRealValue(170/2));
    }];
    
    UIView *line1 = [[UIView alloc] init] ;
    line1.backgroundColor = [UIColor blackColor];
    [self.view addSubview:line1];
    
    UIView *line2 = [[UIView alloc] init] ;
    line2.backgroundColor = [UIColor blackColor];
    [self.view addSubview:line2];
    
    [line1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(30);
        make.right.mas_equalTo(useBtn.mas_left).with.offset(-25) ;
        make.top.mas_equalTo(useBtn.mas_top).with.offset(6);
        make.width.mas_equalTo(SYRealValue(useBtn.left - 25 - 30));
        make.height.mas_equalTo(1);
    }];
    
    [line2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(useBtn.mas_right).with.offset(25);
        make.right.mas_equalTo(-30) ;
        make.top.mas_equalTo(useBtn.mas_top).with.offset(6);
        make.width.mas_equalTo(SYRealValue(useBtn.left - 25 - 30));
        make.height.mas_equalTo(1);
    }];

    
    UIView *qqView = [[UIView alloc] init];
    qqView.layer.borderWidth = 1;
    qqView.layer.cornerRadius = SYRealValue(128/4) ;
    qqView.layer.borderColor = [[UIColor blackColor] CGColor];
    UITapGestureRecognizer *tapGesturRecognizer=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(qq)];
    [qqView addGestureRecognizer:tapGesturRecognizer];
    [self.view addSubview:qqView];
    
    UIView *sinaView = [[UIView alloc] init];
    sinaView.layer.borderWidth = 1;
    sinaView.layer.cornerRadius = SYRealValue(128/4) ;
    sinaView.layer.borderColor = [[UIColor blackColor] CGColor];
//    [self.view addSubview:sinaView];  
    
    UIView *wxView = [[UIView alloc] init];
    wxView.layer.borderWidth = 1;
    wxView.layer.cornerRadius = SYRealValue(128/4) ;
    wxView.layer.borderColor = [[UIColor blackColor] CGColor];
    UITapGestureRecognizer *tapGesturRecognizer2=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(weixin)];
    [wxView addGestureRecognizer:tapGesturRecognizer2];
    [self.view addSubview:wxView];
    
    [qqView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(60);
        make.width.mas_equalTo(SYRealValue(128/2));
        make.height.mas_equalTo(SYRealValue(128/2));
        make.bottom.mas_equalTo(-88/2);
    }];
    
//    [sinaView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.width.mas_equalTo(SYRealValue(128/2));
//        make.height.mas_equalTo(SYRealValue(128/2));
//        make.centerX.mas_equalTo(self.view);
//        make.bottom.mas_equalTo(-88/2);
//    }];
    
    [wxView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(-60);
        make.width.mas_equalTo(SYRealValue(128/2));
        make.height.mas_equalTo(SYRealValue(128/2));
        make.bottom.mas_equalTo(-88/2);
    }];
    
    UIImageView *socialbtn = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"qq"]] ;
    [qqView addSubview:socialbtn];
    
    UIImageView *socialbtn2 = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"sina"]] ;
    [sinaView addSubview:socialbtn2];

    UIImageView *socialbtn3 = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"weixin"]] ;
    [wxView addSubview:socialbtn3];

    [socialbtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.mas_equalTo(qqView);
    }];
    
    [socialbtn2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.mas_equalTo(sinaView);
    }];
    
    [socialbtn3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.mas_equalTo(wxView);
    }];

}

-(void)qq{
    _tencentOAuth=[[TencentOAuth alloc]initWithAppId:tencentAPPID andDelegate:self];
    
    _permissionArray = [NSMutableArray arrayWithObjects: kOPEN_PERMISSION_GET_SIMPLE_USER_INFO,nil];
    
    //登录操作
    [_tencentOAuth authorize:_permissionArray inSafari:NO];
}

-(void)weixin{
    if ([WXApi isWXAppInstalled]) {
        SendAuthReq *req = [[SendAuthReq alloc] init];
        req.scope = @"snsapi_userinfo";
        req.state = @"App";
        [WXApi sendReq:req];
    }
}

-(void)on:(NSNotification *) notification{
    RegisterViewController *registerController = [[RegisterViewController alloc] init];
    //    registerController.from = @"1" ;
    NSDictionary *userInfoDic = [notification object];
    registerController.nickname = [userInfoDic objectForKey:@"nickname"];
    if ([userInfoDic objectForKey:@"headimgurl"]) {
        registerController.imageUrl = [userInfoDic objectForKey:@"headimgurl"];
    }else{
        registerController.imageUrl = [userInfoDic objectForKey:@"figureurl_2"];
    }
    
    if ([userInfoDic objectForKey:@"openid"]) {
        registerController.openId = [userInfoDic objectForKey:@"openid"];
    }else{
        registerController.openId = [NSString stringWithFormat:@"tencentID %@" ,tencentAPPID] ; //QQ登录没有返回 则写死appid
    }
    registerController.from = @"1" ;
    [self.navigationController pushViewController:registerController animated:YES];
}

-(void)handleSingleTap{
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)forget{
    RegisterViewController *reg = [RegisterViewController new];
    reg.from = @"2" ;
    [self.navigationController pushViewController:reg animated:YES];
}

-(void)loginAction{
    self.HUD = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    
    if ([@"" isEqualToString:tf.text]|| nil == tf.text) {
        self.HUD.mode = MBProgressHUDModeText;
        self.HUD.removeFromSuperViewOnHide = YES;
        self.HUD.labelText = @"请输入手机号";
        [self.HUD hide:YES afterDelay:3];
        return ;
    }
    
    if ([@"" isEqualToString:psw.text] || nil == psw.text) {
        self.HUD.mode = MBProgressHUDModeText;
        self.HUD.removeFromSuperViewOnHide = YES;
        self.HUD.labelText = @"请输入密码";
        [self.HUD hide:YES afterDelay:3];
        return ;
    }
    
    [self loginRequest:tf.text withPws:psw.text];

}

-(void)loginRequest :(NSString *)name withPws :(NSString *) password{

    NSDictionary *params = [NSDictionary dictionaryWithObjectsAndKeys:name , @"mobile" ,password, @"password" , nil];
    
    [PPNetworkHelper POST:login parameters:params success:^(id object) {
        if([object[@"code"] isEqualToString:@"0000"]){
            
            UserDataVo *user = [UserDataVo new];
            user.rongyun_token = object[@"rongyun_token"] ;
            user.token = object[@"token"] ;
            
            user.registrationid = object[@"user"][@"registrationid"] ;
            user.areacode = object[@"user"][@"areacode"];
            user.cityName = object[@"user"][@"cityname"];
            user.position = object[@"user"][@"realname"];
            user.regtime = object[@"user"][@"regtime"];
            user.team = object[@"user"][@"team"];
            user.areaname = object[@"user"][@"areaname"];
            user.sex = object[@"user"][@"sex"] ;
            user.fansCount = object[@"user"][@"fansCount"] ;
            user.nickname = [CommonFunc textFromBase64String:object[@"user"][@"nickname"]] ;
            user.realname = object[@"user"][@"realname"] ;
            user.openidbyqq = object[@"user"][@"openidbyqq"] ;
            user.openidbywx = object[@"user"][@"openidbywx"] ;
            user.firstletter = object[@"user"][@"firstletter"] ;
            user.level = object[@"user"][@"level"] ;
            user.pwd = object[@"user"][@"pwd"] ;
            user.phone = object[@"user"][@"phone"] ;
            user.headpicurl = object[@"user"][@"headpicurl"] ;
            user.provincecode = object[@"user"][@"provincecode"] ;
            user.role = object[@"user"][@"role"] ;
            user.citycode = object[@"user"][@"citycode"] ;
            user.club = object[@"user"][@"club"] ;            
            user.brithday = object[@"user"][@"brithday"] ;
            user.certification = object[@"user"][@"certification"] ;
            user.desc = object[@"user"][@"description"] ;

            YYCache *cache = [YYCache cacheWithName:@"FB"];
            [cache setObject:user forKey:@"userData"];

            [[NSNotificationCenter defaultCenter] postNotificationName:@"verifyLoginStatus" object:self];
            
        }else{
            [SVProgressHUD showErrorWithStatus:object[@"msg"]];
            [SVProgressHUD setDefaultStyle:SVProgressHUDStyleDark];
       }
        
        [self closeProgressView];
    } failure:^(NSError *error) {
        
    }];
    
}


- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:animated];
}

-(void)viewWillDisappear:(BOOL)animated{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
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

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    [tf resignFirstResponder];
    [psw resignFirstResponder];
}

#pragma tencentQQ
/**
 * 登录成功后的回调
 */
- (void)tencentDidLogin{
    /** Access Token凭证，用于后续访问各开放接口 */
    if (_tencentOAuth.accessToken) {
        [_tencentOAuth getUserInfo];
    }else{
        NSLog(@"accessToken 没有获取成功");
    }
}

- (void)tencentDidNotLogin:(BOOL)cancelled{
    if (cancelled) {
        NSLog(@" 用户点击取消按键,主动退出登录");
    }else{
        NSLog(@"其他原因， 导致登录失败");
    }
}

- (void)tencentDidNotNetWork{
    NSLog(@"没有网络了， 怎么登录成功呢");
}


- (BOOL)tencentNeedPerformIncrAuth:(TencentOAuth *)tencentOAuth withPermissions:(NSArray *)permissions{
    
    // incrAuthWithPermissions是增量授权时需要调用的登录接口
    // permissions是需要增量授权的权限列表
    [tencentOAuth incrAuthWithPermissions:permissions];
    return NO; // 返回NO表明不需要再回传未授权API接口的原始请求结果；
    // 否则可以返回YES
}

- (BOOL)tencentNeedPerformReAuth:(TencentOAuth *)tencentOAuth{
    return YES;
}

- (void)tencentDidUpdate:(TencentOAuth *)tencentOAuth{
    NSLog(@"增量授权完成");
    if (tencentOAuth.accessToken
        && 0 != [tencentOAuth.accessToken length])
    { // 在这里第三方应用需要更新自己维护的token及有效期限等信息
        // **务必在这里检查用户的openid是否有变更，变更需重新拉取用户的资料等信息** _labelAccessToken.text = tencentOAuth.accessToken;
    }
    else
    {
        NSLog(@"增量授权不成功，没有获取accesstoken");
    }
    
}

- (void)tencentFailedUpdate:(UpdateFailType)reason{
    
    switch (reason)
    {
        case kUpdateFailNetwork:
        {
            //            _labelTitle.text=@"增量授权失败，无网络连接，请设置网络";
            NSLog(@"增量授权失败，无网络连接，请设置网络");
            break;
        }
        case kUpdateFailUserCancel:
        {
            //            _labelTitle.text=@"增量授权失败，用户取消授权";
            NSLog(@"增量授权失败，用户取消授权");
            break;
        }
        case kUpdateFailUnknown:
        default:
        {
            NSLog(@"增量授权失败，未知错误");
            break;
        }
    }
    
    
}

- (void)getUserInfoResponse:(APIResponse*) response{
    [[NSNotificationCenter defaultCenter] postNotificationName:@"showRegisterView" object:response.jsonResponse];
}


@end

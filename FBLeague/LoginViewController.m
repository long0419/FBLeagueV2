
//
//  LoginViewController.m
//  kinvest
//
//  Created by long-laptop on 16/4/11.
//  Copyright © 2016年 long-laptop. All rights reserved.
//

#import "LoginViewController.h"
#import "UIView+Common.h"
#import "UIColor+Expanded.h"
#import "AccountView.h"
#import "UserDataVo.h"
#import "MWLocalDataTool.h"
#import "VerifyCodeViewController.h"
#import "MainViewController.h"
#import "VerifyCodeView2ViewController.h"
#import "HcdGuideView.h"
#import <TencentOpenAPI/TencentOAuth.h>

@interface LoginViewController (){
    TencentOAuth *_tencentOAuth;
    NSMutableArray *_permissionArray;   //权限列表
    PicButton *left ;
    PicButton *right ;
}

@end

@implementation LoginViewController

-(void)loadView{
    [super loadView];
    CGRect frame = [UIView frameWithOutNavTab];
    self.view = [[UIView alloc] initWithFrame:frame];
    self.view.backgroundColor = [UIColor colorWithHexString:@"feffff"];
}

-(void)viewWillAppear:(BOOL)animated{
    [self.navigationController setNavigationBarHidden:YES animated:animated];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(on:)   name:@"showRegisterView" object:nil];
    
    UserDataVo *vo = [[MWLocalDataTool shareInstance] readNSUserDefaultsWithKey:@"userData"];
    
    if (vo) {
        [[NSNotificationCenter defaultCenter] postNotificationName:@"verifyLoginStatus" object:self];
    }
    
    NSMutableArray *images = [NSMutableArray new];
    
    [images addObject:[UIImage imageNamed:@"引导页1.png"]];
    [images addObject:[UIImage imageNamed:@"引导页2.png"]];
    [images addObject:[UIImage imageNamed:@"引导页3.png"]];
    [images addObject:[UIImage imageNamed:@"引导页4.png"]];
    
    HcdGuideView *guideView = [HcdGuideView sharedInstance];
    guideView.window = [UIApplication sharedApplication].keyWindow;
    [guideView showGuideViewWithImages:images
                        andButtonTitle:@"立即体验"
                   andButtonTitleColor:[UIColor whiteColor]
                      andButtonBGColor:[UIColor colorWithHexString:@"2eb66a"]
                  andButtonBorderColor:[UIColor whiteColor]];

    if (![WXApi isWXAppInstalled]) {
        left.hidden = YES ;
        right.centerX = self.view.centerX;

    }
}

-(void)viewWillDisappear:(BOOL)animated{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)viewDidLoad {
    [super viewDidLoad];

    CGFloat y = SYRealValue(188/2) ;
    if (DEVICE_IS_IPHONE5) {
        y = SYRealValue(188/4) ;
    }

    CGFloat size = 100;
    if (kScreen_Height == 480.000000) {
        size = 80 ;
    }
    UIImageView *bgImg = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"logo"]];
    bgImg.frame = CGRectMake((kScreen_Width - SYRealValue(100))/2 , y , SYRealValue(size) , SYRealValue(size)) ;
    bgImg.layer.cornerRadius= SYRealValue(size/2) ;
    bgImg.layer.masksToBounds=YES;
    [self.view addSubview:bgImg];
    
    CGFloat y2 = SYRealValue(80) ;    
    CGSize textNameSize = [NSString getStringContentSizeWithFontSize:11 andContent:@"账号"] ;
    UILabel *name = [[UILabel alloc] initWithFrame:CGRectMake(30 , bgImg.bottom + y2 , textNameSize.width, textNameSize.height)] ;
    name.text = @"账号" ;
    name.font = [UIFont systemFontOfSize:11] ;
    name.textColor = [UIColor colorWithHexString:@"333333"] ;
    [self.view addSubview:name];

    CGSize tempSize = [NSString getStringContentSizeWithFontSize:14 andContent:@"手机号"] ;
    CGRect accountFrame = CGRectMake(30 , name.bottom + SYRealValue(14), kScreen_Width - 60 , tempSize.height + 14 + .5) ;
    _account = [AccountView accountView:@"" andWithDefaultText:@"手机号" andWithCGRect:accountFrame];
    _account.frame = accountFrame ;
    UITextField *accountView = [_account viewWithTag:11];
    accountView.delegate = self ;
    [self.view addSubview:_account];
    
    CGSize psdSize = [NSString getStringContentSizeWithFontSize:11 andContent:@"密码"] ;
    UILabel *psdname = [[UILabel alloc] initWithFrame:CGRectMake(30 , _account.bottom + SYRealValue(40) , psdSize.width, psdSize.height)] ;
    psdname.text = @"密码" ;
    psdname.font = [UIFont systemFontOfSize:11] ;
    psdname.textColor = [UIColor colorWithHexString:@"333333"] ;
    [self.view addSubview:psdname];

    _psw = [AccountView accountView:@"" andWithDefaultText:@"登录密码" andWithCGRect:CGRectMake(30 , psdname.bottom + SYRealValue(14) , kScreen_Width - 60 , 45)];
    UITextField *psdView = [_psw viewWithTag:11];
    psdView.delegate = self ;
    [self.view addSubview:_psw];
    
    
    UIButton *loginBtn = [UIButton buttonWithType: UIButtonTypeCustom];
    loginBtn.frame = CGRectMake(30 , _psw.bottom + SYRealValue(45) , kScreen_Width - 60 , SYRealValue(110/2)) ;
    loginBtn.backgroundColor = [UIColor colorWithHexString:@"2eb66a"];
    [loginBtn setTitle:@"登录" forState:UIControlStateNormal];
    loginBtn.titleLabel.font = [UIFont systemFontOfSize: 15];
    loginBtn.titleLabel.textColor = [UIColor colorWithHexString:@"ffffff"];
    loginBtn.layer.cornerRadius= SYRealValue(110/2/2) ;
    loginBtn.layer.masksToBounds=YES;
    loginBtn.tag = 3 ;
    [loginBtn addTarget:self action:@selector(loginAction:) forControlEvents:UIControlEventTouchUpInside];//button 点击回调方法
    [self.view addSubview:loginBtn];
    
    CGSize forgetText = [NSString getStringContentSizeWithFontSize:12 andContent:@"忘记密码"];
    UIButton *forgetBtn = [UIButton buttonWithType: UIButtonTypeCustom];
    forgetBtn.frame = CGRectMake(loginBtn.left + 110/4 , loginBtn.bottom + 6 , forgetText.width , forgetText.height) ;
    forgetBtn.backgroundColor = [UIColor clearColor];
    [forgetBtn setTitle:@"忘记密码" forState:UIControlStateNormal];
    forgetBtn.titleLabel.font = [UIFont systemFontOfSize:12];
    [forgetBtn setTitleColor:[UIColor colorWithHexString:@"9c9c9c"]forState:UIControlStateNormal];
    [forgetBtn addTarget:self action:@selector(forget) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:forgetBtn];

    
    CGSize registerText = [NSString getStringContentSizeWithFontSize:12 andContent:@"用户注册"];
    UIButton *regiBtn = [UIButton buttonWithType: UIButtonTypeCustom];
    regiBtn.frame = CGRectMake(loginBtn.right - registerText.width - 110/4, loginBtn.bottom + 6 , registerText.width , registerText.height) ;
    regiBtn.backgroundColor = [UIColor clearColor];
    [regiBtn setTitle:@"用户注册" forState:UIControlStateNormal];
    regiBtn.titleLabel.font = [UIFont systemFontOfSize:12];
    [regiBtn setTitleColor:[UIColor colorWithHexString:@"9c9c9c"]forState:UIControlStateNormal];
    [regiBtn addTarget:self action:@selector(regi) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:regiBtn];
    
    left = [[PicButton alloc] init] ;
    CGSize leftSize = [NSString getStringContentSizeWithFontSize:13
                                                      andContent:@"微信登录"];
    CGRect leftRect = CGRectMake(0, 0 , 25, 21) ;
    left.frame = CGRectMake((kScreen_Width/2 - (leftSize.width + 7 + 25))/2, kScreen_Height - 22 - 21 , 25 + 12 + leftSize.width , 21) ;
    left.backgroundColor = [UIColor clearColor];
    [left getPicButtonWithText:@"weixin" andWithTint:@"微信登录" andWithTintColor:@"5ad95e" andCGRectImage:leftRect andWithTintSpace:12];
    left.tag = 1;
//    left.centerX = self.view.centerX ;
    [left addTarget:self action:@selector(loginAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:left];
    
    right = [[PicButton alloc] init] ;
    CGSize rightSize = [NSString getStringContentSizeWithFontSize:13 andContent:@"QQ登录"];
    CGRect rightRect = CGRectMake(0 , 0 , 18, 22) ;
    right.frame = CGRectMake((kScreen_Width/2 - (rightSize.width + 5 + 18))/2 + kScreen_Width/2 , kScreen_Height - 22 - 21 , 18 + 60 , 21) ;
    [right getPicButtonWithText:@"qq" andWithTint:@"QQ登录" andWithTintColor:@"39a3ec" andCGRectImage:rightRect andWithTintSpace:5];
    right.tag = 2;
    right.backgroundColor = [UIColor clearColor];
    [right addTarget:self action:@selector(loginAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:right];
    
}

-(void)regi{
    VerifyCodeViewController *registerController = [[VerifyCodeViewController alloc] init];
    registerController.from = @"1" ;
    [self.navigationController pushViewController:registerController animated:YES];
}

-(void)forget{
    VerifyCodeViewController *registerController = [[VerifyCodeViewController alloc] init];
    registerController.from = @"2" ;
    [self.navigationController pushViewController:registerController animated:YES];
}

-(void)on:(NSNotification *) notification{
    VerifyCodeViewController *registerController = [[VerifyCodeViewController alloc] init];
//    registerController.from = @"1" ;
    NSDictionary *userInfoDic = [notification object];
    registerController.nickName = [userInfoDic objectForKey:@"nickname"];
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
    
    [self.navigationController pushViewController:registerController animated:YES];
}

-(void)loginAction :(UIButton *) sender {
    [_account resignFirstResponder];
    [_psw resignFirstResponder];
    
    NSInteger tag = sender.tag ;
    if(tag == 1){ //微信登录
        if ([WXApi isWXAppInstalled]) {
            SendAuthReq *req = [[SendAuthReq alloc] init];
            req.scope = @"snsapi_userinfo";
            req.state = @"App";
            [WXApi sendReq:req];
        }
        else {
//            [self setupAlertController];
            left.hidden = YES ;
            right.centerX = self.view.centerX;
        }
    }else if(tag == 2){ //qq
        _tencentOAuth=[[TencentOAuth alloc]initWithAppId:tencentAPPID andDelegate:self];
        
        _permissionArray = [NSMutableArray arrayWithObjects: kOPEN_PERMISSION_GET_SIMPLE_USER_INFO,nil];
        
        //登录操作
        [_tencentOAuth authorize:_permissionArray inSafari:NO];
    }else if(tag == 3){
        self.HUD = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        
        UITextField * phoneTxt = [_account viewWithTag:11];
        if ([@"" isEqualToString:phoneTxt.text]|| nil == phoneTxt.text) {
            self.HUD.mode = MBProgressHUDModeText;
            self.HUD.removeFromSuperViewOnHide = YES;
            self.HUD.labelText = @"请输入手机号";
            [self.HUD hide:YES afterDelay:3];
            return ;
        }
        
        UITextField * pswTxt = [_psw viewWithTag:11];
        if ([@"" isEqualToString:pswTxt.text] || nil == pswTxt.text) {
            self.HUD.mode = MBProgressHUDModeText;
            self.HUD.removeFromSuperViewOnHide = YES;
            self.HUD.labelText = @"请输入密码";
            [self.HUD hide:YES afterDelay:3];
            return ;
        }
        
        [self loginRequest:phoneTxt.text withPws:pswTxt.text];
    }
}

#pragma mark - 设置弹出提示语
- (void)setupAlertController {
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"温馨提示" message:@"请先安装微信客户端" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *actionConfirm = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:nil];
    [alert addAction:actionConfirm];
    [self presentViewController:alert animated:YES completion:nil];
}

-(void)loginRequest :(NSString *)name withPws :(NSString *) password{
    APIClient *client = [APIClient sharedJsonClient];
    NSDictionary *params = [NSDictionary dictionaryWithObjectsAndKeys:name , @"phone" ,password, @"password" , nil];
    [client requestJsonDataWithPath:login withParams:params withMethodType:Post andBlock:^(id data, NSError *error) {
        if([data[@"code"] isEqualToString:@"0000"]){
            
            UserDataVo *user = [UserDataVo new];
            user.pwd = data[@"user"][@"pwd"] ;
            user.phone = data[@"user"][@"phone"];
            user.role = data[@"user"][@"role"];
            user.realname = data[@"user"][@"realname"];
            user.level = data[@"user"][@"level"];
            user.club = data[@"user"][@"club"];
            user.headpicurl = data[@"user"][@"headpicurl"];
            user.hasAuth = data[@"hasAuth"] ;
            NSData *data = [NSKeyedArchiver archivedDataWithRootObject:user];

            UserDefaultSet(@"userData" , data);
            [[NSNotificationCenter defaultCenter] postNotificationName:@"verifyLoginStatus" object:self];
            
        }else if([data[@"code"] isEqualToString:@"0003"]){
            self.HUD.mode = MBProgressHUDModeText;
            self.HUD.removeFromSuperViewOnHide = YES;
            self.HUD.labelText = data[@"message"];
            [self.HUD hide:YES afterDelay:3];
        }else if([data[@"code"] isEqualToString:@"0002"]){
            self.HUD.mode = MBProgressHUDModeText;
            self.HUD.removeFromSuperViewOnHide = YES;
            self.HUD.labelText = data[@"message"];
            [self.HUD hide:YES afterDelay:3];
        }else{
            self.HUD.mode = MBProgressHUDModeText;
            self.HUD.removeFromSuperViewOnHide = YES;
            self.HUD.labelText = @"系统错误";
            [self.HUD hide:YES afterDelay:3];
        }
//        [self closeProgressView];
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

/**
 * 登录失败后的回调
 * \param cancelled 代表用户是否主动退出登录
 */
- (void)tencentDidNotLogin:(BOOL)cancelled{
    if (cancelled) {
        NSLog(@" 用户点击取消按键,主动退出登录");
    }else{
        NSLog(@"其他原因， 导致登录失败");
    }
}

/**
 * 登录时网络有问题的回调
 */
- (void)tencentDidNotNetWork{
    NSLog(@"没有网络了， 怎么登录成功呢");
}


/**
 * 因用户未授予相应权限而需要执行增量授权。在用户调用某个api接口时，如果服务器返回操作未被授权，则触发该回调协议接口，由第三方决定是否跳转到增量授权页面，让用户重新授权。
 * \param tencentOAuth 登录授权对象。
 * \param permissions 需增量授权的权限列表。
 * \return 是否仍然回调返回原始的api请求结果。
 * \note 不实现该协议接口则默认为不开启增量授权流程。若需要增量授权请调用\ref TencentOAuth#incrAuthWithPermissions: \n注意：增量授权时用户可能会修改登录的帐号
 */
- (BOOL)tencentNeedPerformIncrAuth:(TencentOAuth *)tencentOAuth withPermissions:(NSArray *)permissions{
    
    // incrAuthWithPermissions是增量授权时需要调用的登录接口
    // permissions是需要增量授权的权限列表
    [tencentOAuth incrAuthWithPermissions:permissions];
    return NO; // 返回NO表明不需要再回传未授权API接口的原始请求结果；
    // 否则可以返回YES
}

/**
 * [该逻辑未实现]因token失效而需要执行重新登录授权。在用户调用某个api接口时，如果服务器返回token失效，则触发该回调协议接口，由第三方决定是否跳转到登录授权页面，让用户重新授权。
 * \param tencentOAuth 登录授权对象。
 * \return 是否仍然回调返回原始的api请求结果。
 * \note 不实现该协议接口则默认为不开启重新登录授权流程。若需要重新登录授权请调用\ref TencentOAuth#reauthorizeWithPermissions: \n注意：重新登录授权时用户可能会修改登录的帐号
 */
- (BOOL)tencentNeedPerformReAuth:(TencentOAuth *)tencentOAuth{
    return YES;
}

/**
 * 用户通过增量授权流程重新授权登录，token及有效期限等信息已被更新。
 * \param tencentOAuth token及有效期限等信息更新后的授权实例对象
 * \note 第三方应用需更新已保存的token及有效期限等信息。
 */
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

/**
 * 用户增量授权过程中因取消或网络问题导致授权失败
 * \param reason 授权失败原因，具体失败原因参见sdkdef.h文件中\ref UpdateFailType
 */
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

/**
 * 获取用户个人信息回调
 * \param response API返回结果，具体定义参见sdkdef.h文件中\ref APIResponse
*          错误返回示例: \snippet example/getUserInfoResponse.exp fail
 */
- (void)getUserInfoResponse:(APIResponse*) response{
    [[NSNotificationCenter defaultCenter] postNotificationName:@"showRegisterView" object:response.jsonResponse];
}

@end

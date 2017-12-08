//
//  AddSaiViewController.m
//  FBLeague
//
//  Created by long-laptop on 2017/9/6.
//  Copyright © 2017年 long-laptop. All rights reserved.
//

#import "AppDelegate.h"
#import "AddSaiViewController.h"
#import "DSLLoginTextField.h"
#import "ChooseAreaViewController.h"
#import "RadioButton.h"
#import "MXWechatPayHandler.h"
#import "Order.h"
#import "APAuthV2Info.h"
#import "RSADataSigner.h"

@interface AddSaiViewController (){
    DSLLoginTextField *psw ;
    NSString *type ;
    NSString *groupType ;
    NSString *formatType ;
    NSString *baomingTitle;
}

@end

@implementation AddSaiViewController

-(void)viewDidAppear:(BOOL)animated{
    if (_areaStr != nil && ![@"" isEqualToString:_areaStr] && psw != nil) {
        ((UITextField *)psw).text = _areaStr ;
    }
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(getBaoming) name:@"baoming" object:nil];
}

-(void)viewWillDisappear:(BOOL)animated{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"baoming" object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"baoming" object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)viewDidLoad {
    [super viewDidLoad];

    [self setBackBottmAndTitle];
    
    [self setRightBottom];
    
    psw=[[DSLLoginTextField alloc]init];
    psw.frame = CGRectMake(30 , 20 + 44 + 52/2 , kScreen_Width - 60 , 40);
    psw.clearButtonMode=UITextFieldViewModeWhileEditing;
    psw.placeholderColor=[UIColor colorWithHexString:@"000000"];
    psw.textColor = [UIColor blackColor] ;
    psw.font=[UIFont systemFontOfSize:14];
    psw.placeholder=@"选择地区";
    psw.maxTextLength= 11;
    psw.delegate = self ;
    psw.tag = 10 ;
    psw.textAlignment = NSTextAlignmentCenter ;
    [self.view addSubview:psw];
    
    QMUILabel *label3 = [[QMUILabel alloc] init];
    label3.text = @"选择组别";
    label3.font = UIFontMake(12);
    label3.textColor = UIColorBlack ;
    [label3 sizeToFit];
    [self.view addSubview:label3];
    [label3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(psw);
        make.top.mas_equalTo(psw.mas_bottom).with.offset(20);
    }];

    
    NSMutableArray* buttons = [NSMutableArray arrayWithCapacity:2];
    RadioButton* btn = [[RadioButton alloc] init];
    [btn addTarget:self action:@selector(onRadioButtonValueChanged:) forControlEvents:UIControlEventValueChanged];
    [btn setTitle:@"青少年组" forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    btn.titleLabel.font = [UIFont systemFontOfSize:12];
    [btn setImage:[UIImage imageNamed:@"unchecked.png"] forState:UIControlStateNormal];
    [btn setImage:[UIImage imageNamed:@"checked.png"] forState:UIControlStateSelected];
    btn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    btn.titleEdgeInsets = UIEdgeInsetsMake(0, 6, 0, 0);
    [self.view addSubview:btn];
    
    groupType = @"2" ;
    
    RadioButton* btn2 = [[RadioButton alloc] init];
    [btn2 addTarget:self action:@selector(onRadioButtonValueChanged:) forControlEvents:UIControlEventValueChanged];
    [btn2 setTitle:@"成年组" forState:UIControlStateNormal];
    [btn2 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    btn2.titleLabel.font = [UIFont systemFontOfSize:12];
    [btn2 setImage:[UIImage imageNamed:@"unchecked.png"] forState:UIControlStateNormal];
    [btn2 setImage:[UIImage imageNamed:@"checked.png"] forState:UIControlStateSelected];
    btn2.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    btn2.titleEdgeInsets = UIEdgeInsetsMake(0, 6, 0, 0);
    [self.view addSubview:btn2];
    
    [buttons addObject:btn];
    
    [btn2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(psw);
        make.top.mas_equalTo(label3.mas_bottom).with.offset(15);
        make.width.mas_equalTo(60);
    }];
    
    [btn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(psw);
        make.top.mas_equalTo(label3.mas_bottom).with.offset(15);
        make.width.mas_equalTo(100);
    }];
    [buttons addObject:btn2];
    
    [buttons[1] setGroupButtons:buttons];
    [buttons[1] setSelected:YES];

    QMUILabel *label13 = [[QMUILabel alloc] init];
    label13.text = @"选择赛制";
    label13.font = UIFontMake(12);
    label13.textColor = UIColorBlack ;
    [label13 sizeToFit];
    [self.view addSubview:label13];
    [label13 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(psw);
        make.top.mas_equalTo(btn2.mas_bottom).with.offset(20);
    }];

    
    NSMutableArray* buttons2 = [NSMutableArray arrayWithCapacity:3];
    RadioButton* btnx = [[RadioButton alloc] init];
    [btnx addTarget:self action:@selector(onRadioButtonValueChanged:) forControlEvents:UIControlEventValueChanged];
    [btnx setTitle:@"5人制" forState:UIControlStateNormal];
    [btnx setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    btnx.titleLabel.font = [UIFont systemFontOfSize:12];
    [btnx setImage:[UIImage imageNamed:@"unchecked.png"] forState:UIControlStateNormal];
    [btnx setImage:[UIImage imageNamed:@"checked.png"] forState:UIControlStateSelected];
    btnx.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    btnx.titleEdgeInsets = UIEdgeInsetsMake(0, 6, 0, 0);
    [self.view addSubview:btnx];
    [buttons2 addObject:btnx];
    
    RadioButton* btnx2 = [[RadioButton alloc] init];
    [btnx2 addTarget:self action:@selector(onRadioButtonValueChanged:) forControlEvents:UIControlEventValueChanged];
    [btnx2 setTitle:@"8人制" forState:UIControlStateNormal];
    [btnx2 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    btnx2.titleLabel.font = [UIFont systemFontOfSize:12];
    [btnx2 setImage:[UIImage imageNamed:@"unchecked.png"] forState:UIControlStateNormal];
    [btnx2 setImage:[UIImage imageNamed:@"checked.png"] forState:UIControlStateSelected];
    btnx2.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    btnx2.titleEdgeInsets = UIEdgeInsetsMake(0, 6, 0, 0);
    [self.view addSubview:btnx2];
    [buttons2 addObject:btnx2];
    
    RadioButton* btnx3 = [[RadioButton alloc] init];
    [btnx3 addTarget:self action:@selector(onRadioButtonValueChanged:) forControlEvents:UIControlEventValueChanged];
    [btnx3 setTitle:@"11人制" forState:UIControlStateNormal];
    [btnx3 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    btnx3.titleLabel.font = [UIFont systemFontOfSize:12];
    [btnx3 setImage:[UIImage imageNamed:@"unchecked.png"] forState:UIControlStateNormal];
    [btnx3 setImage:[UIImage imageNamed:@"checked.png"] forState:UIControlStateSelected];
    btnx3.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    btnx3.titleEdgeInsets = UIEdgeInsetsMake(0, 6, 0, 0);
    [self.view addSubview:btnx3];
    [buttons2 addObject:btnx3];
    
    [btnx2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(psw);
        make.top.mas_equalTo(label13.mas_bottom).with.offset(10);
        make.width.mas_equalTo(60);
    }];
    
    [btnx mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view);
        make.top.mas_equalTo(label13.mas_bottom).with.offset(10);
        make.width.mas_equalTo(100);
    }];
    
    [btnx3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(psw);
        make.top.mas_equalTo(label13.mas_bottom).with.offset(10);
        make.width.mas_equalTo(60);
    }];
    [buttons2[1] setGroupButtons:buttons2];
    [buttons2[1] setSelected:YES];
    
    NSString *money = @"1000元" ;
    NSString *moneyTxt = @"500元" ;
    if ([_cupType isEqualToString:@"2"]) {
        btnx.hidden = YES ;
        btn.hidden = YES ;
        btnx3.hidden = YES ;
        self.title = @"杯赛报名";
        money = @"500元" ;
        moneyTxt = @"200元" ;
    }else{
        self.title = @"联赛报名";
    }
    
    formatType = @"8" ;
    
    QMUILabel *label14 = [[QMUILabel alloc] init];
    label14.text = @"报名费";
    label14.font = UIFontMake(12);
    label14.textColor = UIColorBlack ;
    [label14 sizeToFit];
    [self.view addSubview:label14];
    [label14 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(psw);
        make.top.mas_equalTo(btnx3.mas_bottom).with.offset(20);
    }];
    
    DSLLoginTextField *money1=[[DSLLoginTextField alloc]init];
//    money1.frame = CGRectMake(30 , 20 + label14.bottom , kScreen_Width - 60 , 40);
    money1.clearButtonMode=UITextFieldViewModeWhileEditing;
    money1.placeholderColor=[UIColor colorWithHexString:@"000000"];
    money1.textColor = [UIColor blackColor] ;
    money1.font=[UIFont systemFontOfSize:14];
    money1.placeholder= moneyTxt;
    money1.enabled = NO ;
    money1.maxTextLength= 11;
    money1.textAlignment = NSTextAlignmentCenter ;
    [self.view addSubview:money1];
    [money1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(label14.mas_bottom).with.offset(20);
        make.width.mas_equalTo(kScreen_Width - 60) ;
        make.height.mas_equalTo(40);
        make.left.mas_equalTo(30) ;
    }];

    QMUILabel *label15 = [[QMUILabel alloc] init];
    label15.text = @"比赛押金";
    label15.font = UIFontMake(12);
    label15.textColor = UIColorBlack ;
    [label15 sizeToFit];
    [self.view addSubview:label15];
    [label15 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(psw);
        make.top.mas_equalTo(money1.mas_bottom).with.offset(20);
    }];

    DSLLoginTextField *money12=[[DSLLoginTextField alloc]init];
    money12.frame = CGRectMake(30 , 20 + label15.bottom , kScreen_Width - 60 , 40);
    money12.clearButtonMode=UITextFieldViewModeWhileEditing;
    money12.placeholderColor=[UIColor colorWithHexString:@"000000"];
    money12.textColor = [UIColor blackColor] ;
    money12.font=[UIFont systemFontOfSize:14];
    money12.placeholder= money ;
    money12.enabled = NO ;
    money12.maxTextLength= 11;
    money12.textAlignment = NSTextAlignmentCenter ;
    [self.view addSubview:money12];
    [money12 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(label15.mas_bottom).with.offset(20);
        make.width.mas_equalTo(kScreen_Width - 60) ;
        make.height.mas_equalTo(40);
        make.left.mas_equalTo(30) ;
    }];
    
    QMUILabel *label16 = [[QMUILabel alloc] init];
    label16.text = @"请选择支付方式";
    label16.font = UIFontMake(12);
    label16.textColor = UIColorBlack ;
    [label16 sizeToFit];
    [self.view addSubview:label16];
    [label16 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(psw);
        make.top.mas_equalTo(money12.mas_bottom).with.offset(20);
    }];
    
    NSMutableArray* buttonsx = [NSMutableArray arrayWithCapacity:2];
    RadioButton* btnx31 = [[RadioButton alloc] init];
    [btnx31 addTarget:self action:@selector(onRadioButtonValueChanged:) forControlEvents:UIControlEventValueChanged];
    [btnx31 setTitle:@"支付宝" forState:UIControlStateNormal];
    [btnx31 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    btnx31.titleLabel.font = [UIFont systemFontOfSize:12];
    [btnx31 setImage:[UIImage imageNamed:@"unchecked.png"] forState:UIControlStateNormal];
    [btnx31 setImage:[UIImage imageNamed:@"checked.png"] forState:UIControlStateSelected];
    btnx31.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    btnx31.titleEdgeInsets = UIEdgeInsetsMake(0, 6, 0, 0);
    [self.view addSubview:btnx31];
    
    RadioButton* btn2x = [[RadioButton alloc] init];
    [btn2x addTarget:self action:@selector(onRadioButtonValueChanged:) forControlEvents:UIControlEventValueChanged];
    [btn2x setTitle:@"微信" forState:UIControlStateNormal];
    [btn2x setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    btn2x.titleLabel.font = [UIFont systemFontOfSize:12];
    [btn2x setImage:[UIImage imageNamed:@"unchecked.png"] forState:UIControlStateNormal];
    [btn2x setImage:[UIImage imageNamed:@"checked.png"] forState:UIControlStateSelected];
    btn2x.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    btn2x.titleEdgeInsets = UIEdgeInsetsMake(0, 6, 0, 0);
    [self.view addSubview:btn2x];
    [buttonsx addObject:btnx31];

    [btnx31 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(psw);
        make.top.mas_equalTo(label16.mas_bottom).with.offset(15);
        make.width.mas_equalTo(100);
    }];
    [btn2x mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(psw);
        make.top.mas_equalTo(label16.mas_bottom).with.offset(15);
        make.width.mas_equalTo(45);
    }];
    [buttonsx addObject:btn2x];
    [buttonsx[0] setGroupButtons:buttonsx];
    [buttonsx[0] setSelected:YES];

    QMUIButton *button = [[QMUIButton alloc] init];
    button.adjustsButtonWhenHighlighted = YES;
    button.titleLabel.font = UIFontBoldMake(37/2);
    [button setTitleColor:UIColorWhite forState:UIControlStateNormal];
    button.backgroundColor = [UIColor blackColor];
    button.highlightedBackgroundColor = [UIColor colorWithHexString:@"5a70d6"];    button.layer.cornerRadius = 4;
    [button addTarget:self action:@selector(baoming) forControlEvents:UIControlEventTouchUpInside];
    [button setTitle:@"报名" forState:UIControlStateNormal];
    [self.view addSubview:button];
    [button mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(btn2x.mas_bottom).with.offset(20);
        make.left.mas_equalTo(SYRealValue(30)) ;
        make.height.mas_equalTo(SYRealValue(40));
        make.width.mas_equalTo((self.view.width - 60));
    }];

    
}

-(void) onRadioButtonValueChanged:(RadioButton*)sender
{
    NSString *text = sender.titleLabel.text ;
    if(sender.selected) {
        if ([text isEqualToString:@"支付宝"]) {
            type = @"支付宝" ;
        }else if([text isEqualToString:@"微信"]){
            type = @"微信" ;
        }
        
        if ([text isEqualToString:@"青年组"]) {
            groupType = @"1" ;
        }else if([text isEqualToString:@"成年组"]){
            groupType = @"2" ;
        }
        
        if ([text isEqualToString:@"5人制"]) {
            formatType = @"5" ;
        }else if([text isEqualToString:@"8人制"]){
            formatType = @"8" ;
        }else if([text isEqualToString:@"11人制"]){
            formatType = @"11" ;
        }
    }
}

-(void)baoming{
    YYCache *cache = [YYCache cacheWithName:@"FB"];
    UserDataVo *uvo = [cache objectForKey:@"userData"];
    NSString *type_ = @"1" ;
    if ([type isEqualToString:@"微信"]){
        type_ = @"2" ;
    }

    if ([_areaStr isEqualToString:@""] || nil == _areaStr) {
        [SVProgressHUD showWithStatus:@"请选择地区"] ;
        [SVProgressHUD setDefaultStyle:SVProgressHUDStyleDark];
        [SVProgressHUD dismissWithDelay:.5] ;
        return ;
    }
    
    baomingTitle = @"联赛报名" ;
    if ([_cupType isEqualToString:@"2"]) {
        baomingTitle = @"EFES 2018贺岁杯虎狼争霸赛" ;
    }
    
    if ([type_ isEqualToString:@"2"]) { //微信
        NSString *money = @"150000" ;
        if ([_cupType isEqualToString:@"2"]) {
            money = @"70000" ;
        }
        [MXWechatPayHandler jumpToWxPay:
                            money
//                            @"1"
                           andWithTitle:baomingTitle];
    }else{
        [self doAlipayPay];
    }
//    [self getBaoming];
}

-(void)getBaoming{
    YYCache *cache = [YYCache cacheWithName:@"FB"];
    UserDataVo *uvo = [cache objectForKey:@"userData"];
    NSString *type_ = @"1" ;
    if ([type isEqualToString:@"微信"]){
        type_ = @"2" ;
    }
    NSArray *area = [_areaCodeStr componentsSeparatedByString:@" "];
    
    //联赛
    NSDictionary *params = [NSDictionary dictionaryWithObjectsAndKeys:uvo.phone , @"phone"  , uvo.club , @"clubId" , _leagueId , @"leagueId" , area[2] , @"areaCode" , groupType , @"groupType" , formatType , @"format" , type_ , @"paymentType" , [NSString stringWithFormat:@"%d",arc4random()] , @"paymentOrder" ,uvo.phone ,  @"token", nil];
    NSString *url = joinLeague ;
    
    //杯赛
    if ([_cupType isEqualToString:@"2"]) {
        url = joinincup ;
        params = [NSDictionary dictionaryWithObjectsAndKeys: uvo.phone , @"contactphone"  , uvo.club , @"clubid" , _leagueId , @"leagueid"
                , _camp , @"camp" , area[2] , @"areacode" , type_ , @"paymenttype" ,  [NSString stringWithFormat:@"%d",arc4random()] , @"paymentorder" ,uvo.phone ,  @"token", nil];
    }
    [PPNetworkHelper POST:url parameters:params success:^(id object) {
        if([object[@"code"] isEqualToString:@"0000"]){
            [self.navigationController popViewControllerAnimated:YES];
            
            [SVProgressHUD showSuccessWithStatus:@"报名成功"] ;
            [SVProgressHUD setDefaultStyle:SVProgressHUDStyleDark];
            [SVProgressHUD dismissWithDelay:1];
            
            AppDelegate * appDelegate = (AppDelegate*)[UIApplication sharedApplication].delegate;

            [appDelegate share:_cupType];
            
        }else{
            [SVProgressHUD dismiss];
        }
    } failure:^(NSError *error) {
        
    }];
}


- (void)setRightBottom {
    CGSize size = [NSString getStringContentSizeWithFontSize:15 andContent:@"分享"] ;
    UIButton *sender = [UIButton buttonWithType:UIButtonTypeCustom];
    sender.frame = CGRectMake(0, 0, size.width , size.height);
    [sender setTitle:@"分享" forState:UIControlStateNormal];
    sender.titleLabel.font = [UIFont systemFontOfSize: 15];
    [sender setTitleColor:[UIColor colorWithHexString:@"ffffff"]forState:UIControlStateNormal];
    [sender addTarget:self action: @selector(share)
     forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *backItem = [[UIBarButtonItem alloc] initWithCustomView:sender];
    self.navigationItem.rightBarButtonItem = backItem ;
}

- (void)doAlipayPay
{
    [self generateTradeNO];
}

- (void)generateTradeNO
{
    YYCache *cache = [YYCache cacheWithName:@"FB"];
    UserDataVo *uvo = [cache objectForKey:@"userData"];
    
    NSDictionary *params = [NSDictionary dictionaryWithObjectsAndKeys:uvo.phone ,  @"token", nil];
    [PPNetworkHelper POST:getRandomId parameters:params success:^(id data) {
        NSString *rsa2PrivateKey = RSA_PRIVATE;
        NSString *rsaPrivateKey =  @"" ;
        
        //将商品信息赋予AlixPayOrder的成员变量
        Order* order = [Order new];
        
        // NOTE: app_id设置
        order.app_id = PARTNER;
        
        // NOTE: 支付接口名称
        order.method = @"alipay.trade.app.pay";
        
        // NOTE: 参数编码格式
        order.charset = @"utf-8";
        
        // NOTE: 当前时间点
        NSDateFormatter* formatter = [NSDateFormatter new];
        [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
        order.timestamp = [formatter stringFromDate:[NSDate date]];
        
        // NOTE: 支付版本
        order.version = @"1.0";
        
        // NOTE: sign_type 根据商户设置的私钥来决定
        order.sign_type = (rsa2PrivateKey.length > 1)?@"RSA2":@"RSA";
        
        // NOTE: 商品数据
        
        double money = 1500.00 ;
        if ([_cupType isEqualToString:@"2"]) {
            money = 700.00 ;
        }

        
        order.biz_content = [BizContent new];
        order.biz_content.body = baomingTitle;
        order.biz_content.subject = baomingTitle;
        order.biz_content.out_trade_no = data[@"randomId"] ;
        order.biz_content.timeout_express = @"30m"; //超时时间设置
        order.biz_content.total_amount =
//        [NSString stringWithFormat:@"%.2f", 0.10];
        [NSString stringWithFormat:@"%.2f", money];
        
        
        YYCache *cache = [YYCache cacheWithName:@"FB"];
        UserDataVo *vo = [cache objectForKey:@"userData"];
        
        order.passback_params = [NSString stringWithFormat:@"%@-1" , vo.phone] ;
        order.notify_url = zfbPayNotify ;
        
        //将商品信息拼接成字符串
        NSString *orderInfo = [order orderInfoEncoded:NO];
        NSString *orderInfoEncoded = [order orderInfoEncoded:YES];
        
        // NOTE: 获取私钥并将商户信息签名，外部商户的加签过程请务必放在服务端，防止公私钥数据泄露；
        //       需要遵循RSA签名规范，并将签名字符串base64编码和UrlEncode
        NSString *signedString = nil;
        RSADataSigner* signer = [[RSADataSigner alloc] initWithPrivateKey:((rsa2PrivateKey.length > 1)?rsa2PrivateKey:rsaPrivateKey)];
        if ((rsa2PrivateKey.length > 1)) {
            signedString = [signer signString:orderInfo withRSA2:YES];
        } else {
            signedString = [signer signString:orderInfo withRSA2:NO];
        }
        
        // NOTE: 如果加签成功，则继续执行支付
        if (signedString != nil) {
            NSString *appScheme = @"com.mileworks.FLeague";
            
            NSString *orderString = [NSString stringWithFormat:@"%@&sign=%@",
                                     orderInfoEncoded, signedString];
            
            [[AlipaySDK defaultService] payOrder:orderString fromScheme:appScheme callback:^(NSDictionary *resultDic) {

            }];
        }
    } failure:^(NSError *error) {
        
    }];
    
}


-(void)setBackBottmAndTitle{
    UIButton *backViewBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    backViewBtn.frame = CGRectMake(0, 0, 17, 17);
    [backViewBtn setImage:[UIImage imageNamed:@"back2"] forState:UIControlStateNormal];
    [backViewBtn addTarget:self action: @selector(back)
          forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *backItem = [[UIBarButtonItem alloc] initWithCustomView:backViewBtn];
    self.navigationItem.leftBarButtonItem = backItem ;
}

-(void)share{
   
    NSString *share = @"share" ;
    if ([_cupType isEqualToString:@"2"]) {
        share = @"杯赛分享" ;
    }
    
    [BHBPopView showToView:self.view
                 andImages:@[@"wechat.png",
                             @"qq.png",
                             @"friend.png"]
                 andTitles:
                    @[@"微信",@"QQ",@"朋友圈"]
            andSelectBlock:^(BHBItem *item) {
                if ([item.title isEqualToString:@"微信"]) {
                    WXMediaMessage *message = [WXMediaMessage message];
                    [message setThumbImage:[UIImage imageNamed:@"QR"]];
                    WXImageObject *imageObject = [WXImageObject object];

                    NSString *filePath = [[NSBundle mainBundle] pathForResource:share ofType:@"jpg"];
                    imageObject.imageData = [NSData dataWithContentsOfFile:filePath];
                    message.mediaObject = imageObject ;

                    SendMessageToWXReq *req = [[SendMessageToWXReq alloc] init];
                    req.bText = NO ;
                    req.message = message ;
                    req.scene = WXSceneSession ;
                    [WXApi sendReq :req];

                }else if([item.title isEqualToString:@"QQ"]){
                    NSString *filePath = [[NSBundle mainBundle] pathForResource:share ofType:@"jpg"];
                    NSData *imgData = [NSData dataWithContentsOfFile:filePath];
                    QQApiImageObject *imgObj = [QQApiImageObject
                                                    objectWithData:
                                                    imgData
                                                    previewImageData:
                                                    UIImagePNGRepresentation(                                                [UIImage imageNamed:@"QR"])
                                                    title:@"报名成功"
                                                    description:@"咖盟报名成功"];
                    SendMessageToQQReq *req = [SendMessageToQQReq reqWithContent:imgObj];
                    [QQApiInterface sendReq:req];
                }else if([item.title isEqualToString:@"朋友圈"]){
                    WXMediaMessage *message = [WXMediaMessage message];
                    [message setThumbImage:[UIImage imageNamed:@"150876415"]];
                    WXImageObject *imageObject = [WXImageObject object];

                    NSString *filePath = [[NSBundle mainBundle] pathForResource:share ofType:@"jpg"];
                    imageObject.imageData = [NSData dataWithContentsOfFile:filePath];
                    message.mediaObject = imageObject ;

                    SendMessageToWXReq *req = [[SendMessageToWXReq alloc] init];
                    req.bText = NO ;
                    req.message = message ;
                    req.scene = WXSceneTimeline ;
                    [WXApi sendReq :req];

                }
            }
     ];
    
}

-(void)back{
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)textFieldDidBeginEditing:(UITextField*)textField

{
    [textField resignFirstResponder];
    
    if(textField.tag == 10){
        self.hidesBottomBarWhenPushed = YES ;
        ChooseAreaViewController *area = [[ChooseAreaViewController alloc] init];
        area.isfrom = @"2" ;
        [self.navigationController pushViewController:area animated:YES];
    }
}


@end

//
//  VerifyCodeViewController.m
//  kinvest
//
//  Created by long-laptop on 16/4/11.
//  Copyright © 2016年 long-laptop. All rights reserved.
//

#import "VerifyCodeViewController.h"
#import "UIView+Common.h"
#import "RegisterTxtView.h"
#import "ForgetPswViewController.h"
#import "AccountView.h"
#import "VerifyCodeView2ViewController.h"

@interface VerifyCodeViewController (){
    UIButton *verifyCode ;
    UITextField *phoneText ;
    UITextField *valicodeText ;
    NSString *authCode ;
    UIButton *regi ;
    UIActionSheet *myActionSheet;
    NSString *url ;
}

@end

@implementation VerifyCodeViewController


-(void)viewWillAppear:(BOOL)animated{
    self.navigationController.navigationBar.hidden = true ;

}

-(void)viewWillDisappear:(BOOL)animated{
    self.navigationController.navigationBar.hidden = false ;
}

-(void)loadView{
    [super loadView];
    CGRect frame = [UIView frameWithOutNavTab];
    self.view = [[UIView alloc] initWithFrame:frame];
 }

- (void)viewDidLoad {
    [super viewDidLoad];

//    [super setBackBottmAndTitle];
    UIView *bg = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreen_Width, kScreen_Height)];
    bg.backgroundColor = [UIColor colorWithHexString:@"feffff"];
    [self.view addSubview:bg];
    
    UIImageView *back = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"close"]];
    back.frame = CGRectMake(15, 37, 15, 15);
    back.userInteractionEnabled = YES;
    UITapGestureRecognizer *singleTap1 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(back)];
    [back addGestureRecognizer:singleTap1];
    [bg addSubview:back];
    
    if ([_from isEqualToString:@"2"]) {
        CGSize titleSize = [NSString getStringContentSizeWithFontSize:38/2 andContent:@"忘记密码"];
        UILabel *title = [[UILabel alloc] initWithFrame:CGRectMake((kScreen_Width - titleSize.width)/2 , 33 , titleSize.width, titleSize.height)] ;
        title.text = @"忘记密码" ;
        title.font = [UIFont systemFontOfSize:38/2] ;
        title.textColor = [UIColor colorWithHexString:@"333333"] ;
        [self.view addSubview:title];

    }else{
        CGSize titleSize = [NSString getStringContentSizeWithFontSize:38/2 andContent:@"注册"];
        UILabel *title = [[UILabel alloc] initWithFrame:CGRectMake((kScreen_Width - titleSize.width)/2 , 33 , titleSize.width, titleSize.height)] ;
        title.text = @"注册" ;
        title.font = [UIFont systemFontOfSize:38/2] ;
        title.textColor = [UIColor colorWithHexString:@"333333"] ;
        [self.view addSubview:title];

    }
    

    CGFloat size = 100;
    if (kScreen_Height == 480.000000) {
        size = 80 ;
    }
    UIImageView *bgImg = nil ;
    if (nil != _imageUrl) {
        bgImg = [[UIImageView alloc] initWithFrame:CGRectMake((kScreen_Width - SYRealValue(size))/2 , SYRealValue(188/2) , SYRealValue(size) , SYRealValue(size))];
        [bgImg setImageWithURL:[NSURL URLWithString:_imageUrl] placeholderImage:nil];
        bgImg.layer.cornerRadius= SYRealValue(size/2) ;
        bgImg.layer.masksToBounds=YES;
        bgImg.tag = 31 ;
        [self.view addSubview:bgImg];
        
    }else{
        bgImg = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"logo"]];
        bgImg.frame = CGRectMake((kScreen_Width - SYRealValue(size))/2 , SYRealValue(188/2) , SYRealValue(size) , SYRealValue(size)) ;
        bgImg.layer.cornerRadius= SYRealValue(size/2) ;
        bgImg.layer.masksToBounds=YES;
        [self.view addSubview:bgImg];
        
        UIImageView *addImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"addpic"]];
        addImage.frame =
        CGRectMake(kScreen_Width - bgImg.left - SYRealValue(30) , SYRealValue(188/2) , SYRealValue(30) , SYRealValue(30)) ;
        addImage.layer.cornerRadius= SYRealValue(15) ;
        addImage.layer.masksToBounds=YES;
        addImage.userInteractionEnabled = YES;
        addImage.tag = 32 ;
        UITapGestureRecognizer *singleTap3 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(addPic)];
        [addImage addGestureRecognizer:singleTap3];
        [self.view addSubview:addImage];
        
    }

    
    CGSize textNameSize = [NSString getStringContentSizeWithFontSize:11 andContent:@"手机号"] ;
    UILabel *name = [[UILabel alloc] initWithFrame:CGRectMake(30 , bgImg.bottom + SYRealValue(80) , textNameSize.width, textNameSize.height)] ;
    name.text = @"手机号" ;
    name.font = [UIFont systemFontOfSize:11] ;
    name.textColor = [UIColor colorWithHexString:@"333333"] ;
    [self.view addSubview:name];
    
    
    CGSize tempSize = [NSString getStringContentSizeWithFontSize:14 andContent:@"请输入手机号"] ;
    CGRect accountFrame = CGRectMake(30 , name.bottom + 14, kScreen_Width - 60 , tempSize.height + 14 + .5) ;
    _account = [AccountView accountView:@"" andWithDefaultText:@"请输入手机号" andWithCGRect:accountFrame];
    _account.frame = accountFrame ;
    phoneText = [_account viewWithTag:11];
    phoneText.delegate = self ;
    [self.view addSubview:_account];
    
    
    CGSize psdSize = [NSString getStringContentSizeWithFontSize:11 andContent:@"验证码"] ;
    UILabel *psdname = [[UILabel alloc] initWithFrame:CGRectMake(30 , _account.bottom + SYRealValue(40) , psdSize.width, psdSize.height)] ;
    psdname.text = @"验证码" ;
    psdname.font = [UIFont systemFontOfSize:11] ;
    psdname.textColor = [UIColor colorWithHexString:@"333333"] ;
    [self.view addSubview:psdname];
    
    
    CGRect regiframe = CGRectMake(0, psdname.bottom + 7, kScreen_Width , 45) ;
    _regis = [[[RegisterTxtView alloc] init] validateCodeView:@"获取验证码" andWithDefaultText:@"请输入验证码" andWithRect:regiframe];
//    _regis.backgroundColor = [UIColor blueColor];
    valicodeText = [_regis viewWithTag:21];
    valicodeText.delegate = self ;
    verifyCode = [_regis viewWithTag:22];
    verifyCode.backgroundColor = [UIColor clearColor];
    [verifyCode addTarget:self action:@selector(registerAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_regis];
        
    UIButton *loginBtn = [UIButton buttonWithType: UIButtonTypeCustom];
    loginBtn.frame = CGRectMake(30 , _regis.bottom + SYRealValue(45) , kScreen_Width - 60 , SYRealValue(110/2)) ;
    loginBtn.backgroundColor = [UIColor colorWithHexString:@"2eb66a"];
    [loginBtn setTitle:@"下一步" forState:UIControlStateNormal];
    loginBtn.titleLabel.font = [UIFont systemFontOfSize: 15];
    loginBtn.titleLabel.textColor = [UIColor colorWithHexString:@"ffffff"];
    loginBtn.layer.cornerRadius= SYRealValue(110/2/2) ;
    loginBtn.layer.masksToBounds=YES;
    loginBtn.tag = 3 ;
    [loginBtn addTarget:self action:@selector(next) forControlEvents:UIControlEventTouchUpInside];//button 点击回调方法
    [self.view addSubview:loginBtn];
    
}


-(void)addPic{
    myActionSheet = [[UIActionSheet alloc]
                     initWithTitle:nil
                     delegate:self
                     cancelButtonTitle:@"取消"
                     destructiveButtonTitle:nil
                     otherButtonTitles: @"打开照相机", @"从手机相册获取",nil];
    
    [myActionSheet showInView:self.view];
}

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == myActionSheet.cancelButtonIndex)
    {
        NSLog(@"取消");
    }
    
    switch (buttonIndex)
    {
        case 0:  //打开照相机拍照
            [self takePicture];
            break;
            
        case 1:  //打开本地相册
            [self LocalPhoto];
            break;
    }
}

- (void)takePicture{
    
    UIImagePickerControllerSourceType sourceType = UIImagePickerControllerSourceTypeCamera;
    //判断是否有摄像头
    if(![UIImagePickerController isSourceTypeAvailable:sourceType])
    {
        sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    }
    
    UIImagePickerController *imagePickerController = [[UIImagePickerController alloc] init];
    imagePickerController.delegate = self;   // 设置委托
    imagePickerController.sourceType = sourceType;
    imagePickerController.allowsEditing = NO;
    [self presentViewController:imagePickerController animated:YES completion:nil];
    
}

-(void) imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info{
    [picker dismissViewControllerAnimated:YES completion:^{}];
    
    
    UIImage *image = [info objectForKey:UIImagePickerControllerOriginalImage];
    NSData *datas = UIImageJPEGRepresentation(image, 0.4);
    NSString *_encodedImageStr = [datas base64Encoding];
    
    APIClient *client = [APIClient sharedJsonClient];
    NSDictionary *params = [NSDictionary dictionaryWithObjectsAndKeys:_encodedImageStr , @"base64file" , nil];
    [client requestJsonDataWithPath:uploadPic withParams:params withMethodType:Post andBlock:^(id data, NSError *error) {
        if([data[@"code"] isEqualToString:@"0000"]){
            url = data[@"URL"] ;
            
            [self.view removeViewWithTag:31];
            [self.view removeViewWithTag:32];

            UIImageView *bgImg = [[UIImageView alloc] initWithFrame:CGRectMake((kScreen_Width - 100)/2 , 188/2 , 100 , 100)];
            [bgImg setImageWithURL:[NSURL URLWithString:url] placeholderImage:nil];            bgImg.layer.cornerRadius= 50 ;
            bgImg.layer.masksToBounds=YES;
            bgImg.tag = 31 ;
            [self.view addSubview:bgImg];
            
            UIImageView *addImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"addpic"]];
            addImage.frame =
            CGRectMake(kScreen_Width - bgImg.left - 30 , 188/2 , 30 , 30) ;
            addImage.layer.cornerRadius= 15 ;
            addImage.layer.masksToBounds=YES;
            addImage.userInteractionEnabled = YES;
            addImage.tag = 32 ;
            UITapGestureRecognizer *singleTap3 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(addPic)];
            [addImage addGestureRecognizer:singleTap3];
            [self.view addSubview:addImage];
            
        }
        [self closeProgressView];
    }];
    
    
}


-(void)back{
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)next{
    self.HUD = [MBProgressHUD showHUDAddedTo:self.view animated:YES];

    if (![authCode isEqualToString:valicodeText.text]) {
        self.HUD.mode = MBProgressHUDModeText;
        self.HUD.removeFromSuperViewOnHide = YES;
        self.HUD.labelText = @"输入验证码不正确";
        [self.HUD hide:YES afterDelay:3];
        return ;
    }
    
    
    if (![_from isEqualToString:@"2"]) {
        VerifyCodeView2ViewController *forget = [[VerifyCodeView2ViewController alloc] init];
        forget.phone = phoneText.text ;
        if (_imageUrl) {
            forget.imageUrl = _imageUrl ;
        }else{
            if (nil != url && ![@"" isEqualToString:url]) {
                forget.imageUrl = url ;
            }
            
        }
        forget.nickName = _nickName ;
        [self.navigationController pushViewController:forget animated:YES];

    }else{
        FindPswViewController *find = [FindPswViewController new];
        find.phone = phoneText.text ;
        [self.navigationController pushViewController:find animated:YES];
    }
    
    
    [self closeProgressView];

}

-(void)registerAction{
    self.HUD = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    APIClient *client = [APIClient sharedJsonClient];

    if ([@"" isEqualToString:phoneText.text]|| nil == phoneText.text) {
        self.HUD.mode = MBProgressHUDModeText;
        self.HUD.removeFromSuperViewOnHide = YES;
        self.HUD.labelText = @"请输入手机号";
        [self.HUD hide:YES afterDelay:3];
        return ;
    }
    
    if ([_from isEqualToString:@"2"]) {
        __block int timeout=60; //倒计时时间
        dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
        dispatch_source_t _timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0,queue);
        dispatch_source_set_timer(_timer,dispatch_walltime(NULL, 0),1.0*NSEC_PER_SEC, 0); //每秒执行
        dispatch_source_set_event_handler(_timer, ^{
            if(timeout<=0){ //倒计时结束，关闭
                dispatch_source_cancel(_timer);
                dispatch_async(dispatch_get_main_queue(), ^{
                    //设置界面的按钮显示 根据自己需求设置
                    [verifyCode setTitle:@"发送验证码" forState:UIControlStateNormal];
                    verifyCode.userInteractionEnabled = YES;
                });
            }else{
                int seconds = timeout % 120;
                NSString *strTime = [NSString stringWithFormat:@"%.2d", seconds];
                dispatch_async(dispatch_get_main_queue(), ^{
                    //设置界面的按钮显示 根据自己需求设置
                    [UIView beginAnimations:nil context:nil];
                    [UIView setAnimationDuration:1];
                    [verifyCode setTitle:[NSString stringWithFormat:@"%@秒后再发送",strTime] forState:UIControlStateNormal];
                    [UIView commitAnimations];
                    verifyCode.userInteractionEnabled = NO;
                    
                });
                timeout--;
            }
        });
        dispatch_resume(_timer);
        
        //    [self showProgressView];
        
        authCode = [NSString getAuthcode];
        NSString *url = [NSString stringWithFormat:@"%@?phone=%@&valiCode=%@" , sms , phoneText.text , authCode];
        [client requestJsonDataWithPath:url withParams:nil withMethodType:Get andBlock:^(id data, NSError *error) {
            if([data[@"code"] isEqualToString:@"0000"]){
                [regi setUserInteractionEnabled:YES];
                regi.backgroundColor = [UIColor colorWithHexString:@"0ec481"];
                
                [self closeProgressView];
                
            }else if ([data[@"code"] isEqualToString:@"1"]) {
                
            }
        }];

    }else{
        NSDictionary *params = [NSDictionary dictionaryWithObjectsAndKeys:phoneText.text , @"phone" , nil];
        [client requestJsonDataWithPath:isExisting withParams:params withMethodType:Post andBlock:^(id data, NSError *error) {
            if([data[@"code"] isEqualToString:@"0000"]){
                if ([data[@"exist"] isEqualToString:@"y"]) {
                    self.HUD.mode = MBProgressHUDModeText;
                    self.HUD.removeFromSuperViewOnHide = YES;
                    self.HUD.labelText = @"当前手机号已注册";
                    [self.HUD hide:YES afterDelay:3];
                    return ;
                }else{
                    
                    __block int timeout=60; //倒计时时间
                    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
                    dispatch_source_t _timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0,queue);
                    dispatch_source_set_timer(_timer,dispatch_walltime(NULL, 0),1.0*NSEC_PER_SEC, 0); //每秒执行
                    dispatch_source_set_event_handler(_timer, ^{
                        if(timeout<=0){ //倒计时结束，关闭
                            dispatch_source_cancel(_timer);
                            dispatch_async(dispatch_get_main_queue(), ^{
                                //设置界面的按钮显示 根据自己需求设置
                                [verifyCode setTitle:@"发送验证码" forState:UIControlStateNormal];
                                verifyCode.userInteractionEnabled = YES;
                            });
                        }else{
                            int seconds = timeout % 120;
                            NSString *strTime = [NSString stringWithFormat:@"%.2d", seconds];
                            dispatch_async(dispatch_get_main_queue(), ^{
                                //设置界面的按钮显示 根据自己需求设置
                                [UIView beginAnimations:nil context:nil];
                                [UIView setAnimationDuration:1];
                                [verifyCode setTitle:[NSString stringWithFormat:@"%@秒后再发送",strTime] forState:UIControlStateNormal];
                                [UIView commitAnimations];
                                verifyCode.userInteractionEnabled = NO;
                                
                            });
                            timeout--;
                        }
                    });
                    dispatch_resume(_timer);
                    
                    //    [self showProgressView];
                    
                    authCode = [NSString getAuthcode];
                    NSString *url = [NSString stringWithFormat:@"%@?phone=%@&valiCode=%@" , sms , phoneText.text , authCode];
                    [client requestJsonDataWithPath:url withParams:nil withMethodType:Get andBlock:^(id data, NSError *error) {
                        if([data[@"code"] isEqualToString:@"0000"]){
                            [regi setUserInteractionEnabled:YES];
                            regi.backgroundColor = [UIColor colorWithHexString:@"0ec481"];
                            
                            [self closeProgressView];
                            
                        }else if ([data[@"code"] isEqualToString:@"1"]) {
                            
                        }
                    }];
                }
            }
        }];

    }
    
    
    
}

//打开本地相册
-(void)LocalPhoto
{
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    
    picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    picker.delegate = self;
    //设置选择后的图片可被编辑
    picker.allowsEditing = NO;
    [self presentViewController:picker animated:YES completion:nil];
}


//当用户选取完成后调用
-(void) imagePickerControllerDidCancel:(UIImagePickerController *)picker{
    [picker dismissViewControllerAnimated:YES completion:^{}];
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

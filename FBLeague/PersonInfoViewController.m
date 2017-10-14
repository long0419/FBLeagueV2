//
//  PersonInfoViewController.m
//  FBLeague
//
//  Created by long-laptop on 2017/7/4.
//  Copyright © 2017年 long-laptop. All rights reserved.
//

#import "PersonInfoViewController.h"
#import "DSLLoginTextField.h"
#import "RadioButton.h"
#import "UserDataVo.h"
#import "CommonFunc.h"
#import "SVProgressHUD.h"

@interface PersonInfoViewController (){
    UIImageView *bgImg ;
    UIActionSheet *myActionSheet;
    NSString *url ;
    DSLLoginTextField *tf ;
    DSLLoginTextField *psw ;
    NSString *sex ;
    NSString *role ;
}

@end

@implementation PersonInfoViewController

-(void)viewDidAppear:(BOOL)animated{
    if (_areaStr != nil && ![@"" isEqualToString:_areaStr] && psw != nil) {
        ((UITextField *)psw).text = _areaStr ;
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"个人信息" ;
    
    sex = @"female" ;
    role = @"1" ;
    
    self.navigationController.navigationBar.titleTextAttributes = [NSDictionary dictionaryWithObjectsAndKeys:[UIColor blackColor], UITextAttributeTextColor,nil];
    self.navigationController.navigationBar.barTintColor = [UIColor whiteColor];
    [self setBackBottmAndTitle];

    UIView *bgView = [[UIView alloc] initWithFrame:CGRectMake((self.view.width - 168/2)/2, 198/2 , 168/2 , 168/2)];
    bgView.layer.borderWidth = 1;
    bgView.layer.cornerRadius = 168/4 ;
    bgView.layer.borderColor = [[UIColor lightGrayColor] CGColor];
    [self.view addSubview:bgView];
    
    bgImg = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"head"]];
    if (_imageUrl != nil || ![_imageUrl isEqualToString:@""]) {
        [bgImg sd_setImageWithURL:[NSURL URLWithString:_imageUrl] placeholderImage:[UIImage imageNamed:@"head"]];
    }
    
    bgImg.layer.cornerRadius= (156/4) ;
    bgImg.layer.masksToBounds=YES;
    bgImg.userInteractionEnabled = YES;
    bgImg.tag = 11 ;
    UITapGestureRecognizer *singleTap3 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(addPic)];
    [bgImg addGestureRecognizer:singleTap3];
    [self.view addSubview:bgImg];
    [bgImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(bgView);
        make.width.mas_equalTo(156/2);
        make.height.mas_equalTo(156/2);
    }];

    QMUILabel *label1 = [[QMUILabel alloc] init];
    label1.text = @"选择头像";
    label1.font = UIFontMake(12);
    label1.textColor = UIColorBlack ;
    [label1 sizeToFit];
    [self.view addSubview:label1];
    [label1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view);
        make.top.mas_equalTo(bgView.mas_bottom).with.offset(8);
    }];

    tf=[[DSLLoginTextField alloc]init];
    tf.clearButtonMode=UITextFieldViewModeWhileEditing;
    tf.placeholderColor=[UIColor colorWithHexString:@"cdcdcd"];
    tf.font=[UIFont systemFontOfSize:14];
    tf.placeholder=@"昵称";
    tf.maxTextLength= 11;
    tf.returnKeyType = UIReturnKeyGo ;
    tf.textAlignment = NSTextAlignmentCenter ;
    if (_nickname != nil || ![_nickname isEqualToString:@""]) {
        tf.text = _nickname ;
    }
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
    psw.placeholder=@"选择地区";
    psw.maxTextLength= 11;
    psw.delegate = self ;
    psw.tag = 10 ;
    psw.textAlignment = NSTextAlignmentCenter ;
    [self.view addSubview:psw];
    [psw mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(tf.mas_bottom).with.offset(20) ;
        make.centerX.mas_equalTo(self.view);
        make.left.mas_equalTo(SYRealValue(30)) ;
        make.height.mas_equalTo(SYRealValue(40));
        make.width.mas_equalTo(self.view.width - 60);
    }];
    
    QMUILabel *label2 = [[QMUILabel alloc] init];
    label2.text = @"选择性别";
    label2.font = UIFontMake(12);
    label2.textColor = UIColorBlack ;
    [label2 sizeToFit];
    [self.view addSubview:label2];
    [label2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(psw);
        make.top.mas_equalTo(psw.mas_bottom).with.offset(10);
    }];
    
    NSMutableArray* buttons = [NSMutableArray arrayWithCapacity:2];
    RadioButton* btn = [[RadioButton alloc] init];
    [btn addTarget:self action:@selector(onRadioButtonValueChanged:) forControlEvents:UIControlEventValueChanged];
    [btn setTitle:@"女" forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    btn.titleLabel.font = [UIFont systemFontOfSize:12];
    [btn setImage:[UIImage imageNamed:@"unchecked.png"] forState:UIControlStateNormal];
    [btn setImage:[UIImage imageNamed:@"checked.png"] forState:UIControlStateSelected];
    btn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    btn.titleEdgeInsets = UIEdgeInsetsMake(0, 6, 0, 0);
    [self.view addSubview:btn];
    
    RadioButton* btn2 = [[RadioButton alloc] init];
    [btn2 addTarget:self action:@selector(onRadioButtonValueChanged:) forControlEvents:UIControlEventValueChanged];
    [btn2 setTitle:@"男" forState:UIControlStateNormal];
    [btn2 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    btn2.titleLabel.font = [UIFont systemFontOfSize:12];
    [btn2 setImage:[UIImage imageNamed:@"unchecked.png"] forState:UIControlStateNormal];
    [btn2 setImage:[UIImage imageNamed:@"checked.png"] forState:UIControlStateSelected];
    btn2.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    btn2.titleEdgeInsets = UIEdgeInsetsMake(0, 6, 0, 0);
    [self.view addSubview:btn2];
    
    [buttons addObject:btn];

    [btn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(psw);
        make.top.mas_equalTo(label2.mas_bottom).with.offset(10);
        make.width.mas_equalTo(100);
    }];
    
    [btn2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(psw);
        make.top.mas_equalTo(label2.mas_bottom).with.offset(10);
        make.width.mas_equalTo(30);
    }];
    [buttons addObject:btn2];

    [buttons[0] setGroupButtons:buttons];
    [buttons[0] setSelected:YES];
    
    
    QMUILabel *label3 = [[QMUILabel alloc] init];
    label3.text = @"选择角色";
    label3.font = UIFontMake(12);
    label3.textColor = UIColorBlack ;
    [label3 sizeToFit];
    [self.view addSubview:label3];
    [label3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(psw);
        make.top.mas_equalTo(btn2.mas_bottom).with.offset(10);
    }];
    
    NSMutableArray* buttons2 = [NSMutableArray arrayWithCapacity:3];
    RadioButton* btnx = [[RadioButton alloc] init];
    [btnx addTarget:self action:@selector(onRadioButtonValueChanged:) forControlEvents:UIControlEventValueChanged];
    [btnx setTitle:@"教练" forState:UIControlStateNormal];
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
    [btnx2 setTitle:@"球员" forState:UIControlStateNormal];
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
    [btnx3 setTitle:@"球迷" forState:UIControlStateNormal];
    [btnx3 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    btnx3.titleLabel.font = [UIFont systemFontOfSize:12];
    [btnx3 setImage:[UIImage imageNamed:@"unchecked.png"] forState:UIControlStateNormal];
    [btnx3 setImage:[UIImage imageNamed:@"checked.png"] forState:UIControlStateSelected];
    btnx3.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    btnx3.titleEdgeInsets = UIEdgeInsetsMake(0, 6, 0, 0);
    [self.view addSubview:btnx3];
    [buttons2 addObject:btnx3];

    [btnx mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(psw);
        make.top.mas_equalTo(label3.mas_bottom).with.offset(10);
        make.width.mas_equalTo(100);
    }];
    
    [btnx2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view);
        make.top.mas_equalTo(label3.mas_bottom).with.offset(10);
        make.width.mas_equalTo(44);
    }];
    
    [btnx3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(psw);
        make.top.mas_equalTo(label3.mas_bottom).with.offset(10);
        make.width.mas_equalTo(44);
    }];
    [buttons2[0] setGroupButtons:buttons2];
    [buttons2[0] setSelected:YES];

    QMUIButton *button = [[QMUIButton alloc] init];
    button.adjustsButtonWhenHighlighted = YES;
    button.titleLabel.font = UIFontBoldMake(37/2);
    [button setTitleColor:UIColorWhite forState:UIControlStateNormal];
    button.backgroundColor = [UIColor blackColor];
    button.highlightedBackgroundColor = [UIColor colorWithHexString:@"5a70d6"];
    button.layer.cornerRadius = 4;
    [button setTitle:@"完成注册" forState:UIControlStateNormal];
    [button addTarget:self action:@selector(finish) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
    [button mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(btnx3.mas_bottom).with.offset(30);
        make.centerX.mas_equalTo(self.view);
        make.left.mas_equalTo(SYRealValue(30)) ;
        make.height.mas_equalTo(SYRealValue(40));
        make.width.mas_equalTo((self.view.width - 60));
    }];

}

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField;{
    
    [tf resignFirstResponder];
    [psw resignFirstResponder];
    
    return YES ;

}


-(void)textFieldDidBeginEditing:(UITextField*)textField

{

    [textField resignFirstResponder];
    
    if(textField.tag == 10){
        [tf resignFirstResponder];
        [psw resignFirstResponder];
        ChooseAreaViewController *area = [[ChooseAreaViewController alloc] init];
        area.isfrom = @"0" ;
        [self.navigationController pushViewController:area animated:YES];
    }
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    [tf resignFirstResponder];
    [psw resignFirstResponder];
}

-(void)finish{
    MBProgressHUD *HUD = [MBProgressHUD showHUDAddedTo:self.view animated:YES];

    if([tf.text isEqualToString:@""]){
        HUD.mode = MBProgressHUDModeText;
        HUD.removeFromSuperViewOnHide = YES;
        HUD.labelText = @"请输入昵称";
        [HUD hide:YES afterDelay:3];
        return ;
    }

    if([psw.text isEqualToString:@""]){
        HUD.mode = MBProgressHUDModeText;
        HUD.removeFromSuperViewOnHide = YES;
        HUD.labelText = @"请输入地区";
        [HUD hide:YES afterDelay:3];
        return ;
    }
    
    NSString *nickname = [CommonFunc base64StringFromText:tf.text];
    
    NSArray *areas = [_areaCodeStr componentsSeparatedByString:@" "];
    
    NSDictionary *params = [NSDictionary dictionaryWithObjectsAndKeys:
                            _phoneNum , @"phone" ,
                            _psw , @"pwd",
                            nickname , @"nickname",
                            role , @"role" ,
                            sex , @"sex" ,
                            [areas objectAtIndex:1] , @"provincecode" ,
                            [areas objectAtIndex:0] , @"citycode" ,
                            [areas objectAtIndex:2] , @"areacode" ,
                            url , @"headpicurl" , nil];
    
    [PPNetworkHelper POST:registerUser parameters:params success:^(id object) {
        if([object[@"code"] isEqualToString:@"0000"]){
            UserDataVo *user = [UserDataVo new];
            user.nickname = tf.text ;
            user.phone = _phoneNum ;
            user.pwd = _psw ;
            
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

            [self closeProgressView];

        }else if([object[@"code"] isEqualToString:@"0002"]){
            [SVProgressHUD showInfoWithStatus: @"当前用户已经注册,返回登录界面登录"];
            [SVProgressHUD setDefaultStyle:SVProgressHUDStyleLight];
            [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeNone];

            [self.navigationController popToRootViewControllerAnimated:YES];
        }else{
            [self closeProgressView];
        }
        
    } failure:^(NSError *error) {
        NSLog(@"%@" , error) ;
    }];
        
}

-(void) onRadioButtonValueChanged:(RadioButton*)sender
{
    NSString *text = sender.titleLabel.text ;
    if(sender.selected) {
        NSLog(@"Selected color: %@", sender.titleLabel.text);
        if ([text isEqualToString:@"女"]) {
            sex = @"female" ;
        }else if ([text isEqualToString:@"男"]) {
            sex = @"male" ;
        }else if ([text isEqualToString:@"教练"]) {
            role = @"1" ;
        }else if ([text isEqualToString:@"球员"]) {
            role = @"2" ;
        }else if ([text isEqualToString:@"球迷"]) {
            role = @"3" ;
        }
    }
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


-(void) imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info{
    [picker dismissViewControllerAnimated:YES completion:^{}];
    
    
    UIImage *image = [info objectForKey:UIImagePickerControllerOriginalImage];
    NSData *datas = UIImageJPEGRepresentation(image, 0.4);
    NSString *_encodedImageStr = [datas base64Encoding];
    
    NSDictionary *params = [NSDictionary dictionaryWithObjectsAndKeys:_encodedImageStr , @"base64file" , nil];
    
    [PPNetworkHelper POST:uploadPic parameters:params success:^(id data) {
        if([data[@"code"] isEqualToString:@"0000"]){
            url = data[@"URL"] ;
            [bgImg  sd_setImageWithURL:[NSURL URLWithString:url] placeholderImage:nil];
        }
        [self closeProgressView];
    } failure:^(NSError *error) {
        
    }];
    
}


@end

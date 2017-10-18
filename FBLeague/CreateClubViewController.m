//
//  CreateClubViewController.m
//  FBLeague
//
//  Created by long-laptop on 2017/7/21.
//  Copyright © 2017年 long-laptop. All rights reserved.
//

#import "CreateClubViewController.h"
#import "DSLLoginTextField.h"
#import "HcdDateTimePickerView.h"
#import "SVProgressHUD.h"

@interface CreateClubViewController (){
    UIImageView *bgImg ;
    UIActionSheet *myActionSheet;
    NSString *url ;
    DSLLoginTextField *tf ;
    DSLLoginTextField *psw ;
    DSLLoginTextField *timeTxt ;
    DSLLoginTextField *moto ;
    YYCache *cache ;
    UserDataVo *uvo ;
    UIView *alertView ;
    NSString *time ;
}

@end

@implementation CreateClubViewController

-(void)viewWillAppear:(BOOL)animated{
    [self hideTabBottom] ;
    self.hidesBottomBarWhenPushed = NO ;
}

-(void)viewDidAppear:(BOOL)animated{
    if (_areaStr != nil && ![@"" isEqualToString:_areaStr] && psw != nil) {
        ((UITextField *)psw).text = _areaStr ;
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setBackBottmAndTitle];
    self.title = @"创建俱乐部" ;
    
    UIView *bgView = [[UIView alloc] initWithFrame:CGRectMake((self.view.width - 168/2)/2, 198/2 , 168/2 , 168/2)];
    bgView.layer.borderWidth = 1;
    bgView.layer.cornerRadius = 168/4 ;
    bgView.layer.borderColor = [[UIColor lightGrayColor] CGColor];
    [self.view addSubview:bgView];
    
    bgImg = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"head"]];
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
    label1.text = @"上传队徽";
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
    tf.placeholder=@"俱乐部名称";
    tf.maxTextLength= 11;
    tf.returnKeyType = UIReturnKeyGo ;
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
    
    timeTxt=[[DSLLoginTextField alloc]init];
    timeTxt.clearButtonMode=UITextFieldViewModeWhileEditing;
    timeTxt.placeholderColor=[UIColor colorWithHexString:@"cdcdcd"];
    timeTxt.font=[UIFont systemFontOfSize:14];
    timeTxt.placeholder=@"成立时间";
    timeTxt.maxTextLength= 11;
    timeTxt.delegate = self ;
    timeTxt.tag = 11 ;
    timeTxt.textAlignment = NSTextAlignmentCenter ;
    [self.view addSubview:timeTxt];
    [timeTxt mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(psw.mas_bottom).with.offset(20) ;
        make.centerX.mas_equalTo(self.view);
        make.left.mas_equalTo(SYRealValue(30)) ;
        make.height.mas_equalTo(SYRealValue(40));
        make.width.mas_equalTo(self.view.width - 60);
    }];
    
    moto=[[DSLLoginTextField alloc]init];
    moto.clearButtonMode=UITextFieldViewModeWhileEditing;
    moto.placeholderColor=[UIColor colorWithHexString:@"cdcdcd"];
    moto.font=[UIFont systemFontOfSize:14];
    moto.placeholder=@"俱乐部口号";
    moto.maxTextLength= 30 ;
    //    moto.delegate = self ;
    moto.textAlignment = NSTextAlignmentCenter ;
    [self.view addSubview:moto];
    [moto mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(timeTxt.mas_bottom).with.offset(20) ;
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
    button.highlightedBackgroundColor = [UIColor colorWithHexString:@"5a70d6"];
    button.layer.cornerRadius = 4;
    [button setTitle:@"完成创建" forState:UIControlStateNormal];
    [button addTarget:self action:@selector(ctx) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
    [button mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(moto.mas_bottom).with.offset(44);
        make.centerX.mas_equalTo(self.view);
        make.left.mas_equalTo(SYRealValue(30)) ;
        make.height.mas_equalTo(SYRealValue(40));
        make.width.mas_equalTo((self.view.width - 60));
    }];
    
    [self loadAlertView];
    
}

-(void)loadAlertView{
    alertView = [UIView new];
    alertView.frame = CGRectMake(0 , 0 , kScreen_Width , kScreen_Height);
    alertView.backgroundColor = [UIColor clearColor];
    alertView.hidden = YES ;
    [self.view addSubview:alertView];
    
    UIView *tmp = [UIView new];
    tmp.frame = CGRectMake(40 , (kScreen_Height - 300)/2 , kScreen_Width - 80, 260);
    tmp.backgroundColor = [UIColor whiteColor];
    tmp.layer.borderWidth = .1;
    tmp.layer.borderColor = [[UIColor blackColor] CGColor];
    tmp.layer.cornerRadius = 5;
    tmp.layer.masksToBounds = YES;
    [alertView addSubview:tmp];
    
    UIImageView *right = [[UIImageView alloc] initWithFrame:CGRectMake((300 - 40)/2, 36/2, 40, 40)];
    right.backgroundColor = [UIColor whiteColor];
    right.image = [UIImage imageNamed:@"完成"];
    [tmp addSubview:right];
    
    UILabel *titleLabel3 = [UILabel new];
    titleLabel3.font = [UIFont systemFontOfSize:12];
    titleLabel3.numberOfLines = 0;//多行显示，计算高度
    titleLabel3.textColor = [UIColor blackColor];
    NSString *desc3 = @"恭喜你，俱乐部已创建成功" ;
    CGSize titleSize3 = [NSString getMultiStringContentSizeWithFontSize:12 andContent:desc3];
    titleLabel3.size = titleSize3;
    titleLabel3.text = desc3 ;
    titleLabel3.x = (tmp.width - titleSize3.width)/2 ;
    titleLabel3.y = right.bottom + 10 ;
    [tmp addSubview:titleLabel3];
    
    UILabel *tl = [UILabel new];
    tl.font = [UIFont systemFontOfSize:14];
    tl.numberOfLines = 0;//多行显示，计算高度
    tl.textColor = [UIColor colorWithHexString:@"5c73d2"];
    NSString *desc = @"你可以报名参加咖盟秋季联赛啦！" ;
    CGSize tl3 = [NSString getMultiStringContentSizeWithFontSize:14 andContent:desc];
    tl.size = tl3;
    tl.text = desc ;
    tl.x = (tmp.width - tl3.width)/2 ;
    tl.y = titleLabel3.bottom + 74/2 ;
    [tmp addSubview:tl];
    
    UIView *line = [[UIView alloc] initWithFrame:CGRectMake(10, tl.bottom + 46/2 , kScreen_Width - 20 , .5)];
    line.backgroundColor = [UIColor colorWithHexString:@"e3e3e3"];
    [tmp addSubview:line];
    
    UILabel *tl2 = [UILabel new];
    tl2.font = [UIFont systemFontOfSize:14];
    tl2.numberOfLines = 0;//多行显示，计算高度
    tl2.textColor = [UIColor colorWithHexString:@"5c73d2"];
    NSString *des2c = @"去报名" ;
    CGSize tl23 = [NSString getMultiStringContentSizeWithFontSize:14 andContent:des2c];
    tl2.size = tl23;
    tl2.text = des2c ;
    tl2.x = (tmp.width - tl23.width)/2 ;
    tl2.y = line.bottom + 32/2 ;
    tl2.userInteractionEnabled=YES;
    UITapGestureRecognizer *labelTapGestureRecognizer = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(baoming)];
    [tl2 addGestureRecognizer:labelTapGestureRecognizer];
    [tmp addSubview:tl2];
    
    UIView *line2 = [[UIView alloc] initWithFrame:CGRectMake(10, tl2.bottom + 32/2 , kScreen_Width - 20 , .5)];
    line2.backgroundColor = [UIColor colorWithHexString:@"e3e3e3"];
    [tmp addSubview:line2];
    
    UILabel *tl4 = [UILabel new];
    tl4.font = [UIFont systemFontOfSize:14];
    tl4.numberOfLines = 0;//多行显示，计算高度
    tl4.textColor = [UIColor colorWithHexString:@"a7a7a7"];
    NSString *des2c1 = @"拒绝，并返回俱乐部页面" ;
    CGSize tl213 = [NSString getMultiStringContentSizeWithFontSize:14 andContent:des2c1];
    tl4.size = tl213;
    tl4.text = des2c1 ;
    tl4.userInteractionEnabled=YES;
    UITapGestureRecognizer *labelTapGestureRecognizer2 = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(back2)];
    [tl4 addGestureRecognizer:labelTapGestureRecognizer2];
    tl4.x = (tmp.width - tl213.width)/2 ;
    tl4.y = line2.bottom + 32/2 ;
    [tmp addSubview:tl4];
    
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

-(void)back{
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)ctx{
    cache = [YYCache cacheWithName:@"FB"];
    uvo = [cache objectForKey:@"userData"];
    
    NSArray *areas = [_areaCodeStr componentsSeparatedByString:@" "];
    NSDictionary *params = [NSDictionary
                            dictionaryWithObjectsAndKeys:
                            uvo.phone , @"creator"  ,
                            [CommonFunc base64StringFromText:tf.text] , @"name" ,
                            moto.text ,@"description" ,
                            uvo.phone ,  @"token",
                            time , @"createdate" ,
                            [areas objectAtIndex:0] , @"citycode" ,
                            [areas objectAtIndex:1] , @"provincecode" ,
                            [areas objectAtIndex:2] , @"areacode" ,
                            url , @"logourl" ,
                            nil];
    [PPNetworkHelper POST:crxClub parameters:params success:^(id object) {
        if([object[@"code"] isEqualToString:@"0000"]){
            //            alertView.hidden = NO ;
            uvo.club = object[@"club"][@"id"] ;
            [cache setObject:uvo forKey:@"userData"];

            [SVProgressHUD showSuccessWithStatus: @"恭喜你，俱乐部已创建成功"];
            [SVProgressHUD setDefaultStyle:SVProgressHUDStyleDark];
            [self.navigationController popToRootViewControllerAnimated:YES];
        }
        
    } failure:^(NSError *error) {
    }];
}

-(void)back2{
    alertView.hidden = NO ;
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)baoming{
    alertView.hidden = NO ;
    self.hidesBottomBarWhenPushed=YES;
    VerifyClubViewController *verify = [VerifyClubViewController new];
    [self.navigationController pushViewController:verify animated:YES];
    self.hidesBottomBarWhenPushed=NO;
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    [tf resignFirstResponder];
    [psw resignFirstResponder];
    [timeTxt resignFirstResponder];
    [moto resignFirstResponder];
    
}

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField;{
    
    [tf resignFirstResponder];
    [psw resignFirstResponder];
    [timeTxt resignFirstResponder];
    [moto resignFirstResponder];
    
    return YES ;
    
}


-(void)textFieldDidBeginEditing:(UITextField*)textField {
    
    [textField resignFirstResponder];
    
    if(textField.tag == 10){
        self.hidesBottomBarWhenPushed=YES;
        ChooseAreaViewController *area = [[ChooseAreaViewController alloc] init];
        area.isfrom = @"1" ;
        [self.navigationController pushViewController:area animated:YES];
        self.hidesBottomBarWhenPushed=NO;
    }else if(textField.tag == 11){
        HcdDateTimePickerView *dateTimePickerView = [[HcdDateTimePickerView alloc] initWithDatePickerMode:DatePickerDateMode defaultDateTime:[[NSDate alloc]initWithTimeIntervalSinceNow:0]];
        dateTimePickerView.clickedOkBtn = ^(NSString * datetimeStr){
            NSLog(@"%@", datetimeStr);
            timeTxt.text = datetimeStr ;
            time = datetimeStr ;
        };
        [self.view addSubview:dateTimePickerView];
        [dateTimePickerView showHcdDateTimePicker];
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
    } failure:^(NSError *error) {
        
    }];
    
}

@end


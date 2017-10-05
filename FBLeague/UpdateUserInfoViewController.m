//
//  UpdateUserInfoViewController.m
//  FBLeague
//
//  Created by long-laptop on 2017/3/10.
//  Copyright © 2017年 long-laptop. All rights reserved.
//

#import "UpdateUserInfoViewController.h"

@interface UpdateUserInfoViewController (){
    UIActionSheet *myActionSheet;
    UIView *julebu ;
    UIView *use ;
    UIView *use2 ;
    UIView *use3 ;
    UIView *use4 ;
    UIView *use5 ;
    UIDatePicker *datePicker ;
    UIButton *backViewBtn2 ;
    NSString *picUrl ;
    UIView *header ;
    UITextField *txtField  ;
    YYCache *cache ;
    UserDataVo *uvo ;
}

@end

@implementation UpdateUserInfoViewController

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.backgroundColor = UIColorBlack ;
    [self forbiddenGesture];
    [self hideTabBottom] ;
    [self judgeView];
}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [self showTabBottom];
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"更新用户信息" ;
    self.view.backgroundColor = [UIColor colorWithHexString:@"f5f6f7"];
    
    [self setBackBottmAndTitle];
    
    [self setRightBottom];
    
    [self contentView];
    
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


-(void)judgeView{
    if(_name !=nil && nil != use){
        [use removeFromSuperview];
        BeginTouView *beginView2 = [[BeginTouView alloc] init];
        UITapGestureRecognizer *singleTap2 = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(sendname)];
        use = [beginView2 getBeginTouView:@"创建人姓名" andWithTintTitle:_name andWithEndImage:@"extend" andWithImageSize:CGSizeMake(15/2, 14) andPoint:CGPointMake(0, julebu.bottom + 12) andWithTag:2];
        [use setUserInteractionEnabled:YES];
        [use addGestureRecognizer:singleTap2];
        //        [self.view addSubview:use];
        
    }
    
    if (_areaStr != nil && nil != use4) {
        [use2 removeFromSuperview];
        
        BeginTouView *beginView3 = [[BeginTouView alloc] init];
        use2 = [beginView3 getBeginTouView:@"注册省市" andWithTintTitle:_areaStr andWithEndImage:@"extend" andWithImageSize:CGSizeMake(15/2, 14) andPoint:CGPointMake(0, use.bottom) andWithTag:2];
        //        [self.view addSubview:use2];
    }
    
    
    if (_clubname != nil && nil !=use3 && nil != use2) {
        [use3 removeFromSuperview];
        BeginTouView *beginView4 = [[BeginTouView alloc] init];
        use3 = [beginView4 getBeginTouView:@"用户名称" andWithTintTitle:_clubname andWithEndImage:@"extend" andWithImageSize:CGSizeMake(15/2, 14) andPoint:CGPointMake(0, header.bottom + 12) andWithTag:2];
        [self.view addSubview:use3];
    }
    
    if (_jianjie != nil && nil != use3 && nil != use2 && nil != use4) {
        [use5 removeFromSuperview];
        BeginTouView *beginView6 = [[BeginTouView alloc] init];
        use5 = [beginView6 getBeginTouPic:@"简介" andWithContent: _jianjie andWithEndImage:@"extend" andWithImageSize:CGSizeMake(15/2, 14) andPoint:CGPointMake(0, use3.bottom)];
        [self.view addSubview:use5];
        
    }
    
}

- (void)setRightBottom {
    CGSize size = [NSString getStringContentSizeWithFontSize:15 andContent:@"修改"] ;
    UIButton *updatebtn = [UIButton buttonWithType:UIButtonTypeCustom];
    updatebtn.frame = CGRectMake(0, 0, size.width , size.height);
    [updatebtn setTitle:@"修改" forState:UIControlStateNormal];
    updatebtn.backgroundColor = [UIColor blueColor];
    updatebtn.titleLabel.font = [UIFont systemFontOfSize: 15];
    [updatebtn setTitleColor:[UIColor colorWithHexString:@"ffffff"]forState:UIControlStateNormal];
    [updatebtn addTarget:self action: @selector(goAction)
          forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *backItem2 = [[UIBarButtonItem alloc] initWithCustomView:updatebtn];
//    self.navigationItem.rightBarButtonItem = backItem2 ;
//    [self.view addSubview:updatebtn];
}

-(void)back{
    [self.navigationController popToRootViewControllerAnimated:YES];
}

-(void)contentView{
    header = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreen_Width, 20 + 44)];
    header.backgroundColor = [UIColor colorWithHexString:@"4cc07f"];
    [self.view addSubview:header];

    UIButton *backViewBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    backViewBtn.frame = CGRectMake(12, 22 + 12 , 17, 17);
    [backViewBtn setImage:[UIImage imageNamed:@"back2"] forState:UIControlStateNormal];
    [backViewBtn addTarget:self action: @selector(back)
          forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:backViewBtn];
    
    UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(sendlogo)];
    BeginTouView *beginView = [[BeginTouView alloc] init];
    julebu = [beginView getBeginTouPic:@"用户Logo" andWithPic:@"extend" andWithEndImage:@"extend" andWithImageSize:CGSizeMake(15/2, 14) andPoint:CGPointMake(0, header.bottom + 12)];
    [julebu setUserInteractionEnabled:YES];
    [julebu addGestureRecognizer:singleTap];
    [self.view addSubview:julebu];
    
    BeginTouView *beginView2 = [[BeginTouView alloc] init];
    UITapGestureRecognizer *singleTap2 = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(sendname)];
    use = [beginView2 getBeginTouView:@"创建人姓名" andWithTintTitle:@"" andWithEndImage:@"extend" andWithImageSize:CGSizeMake(15/2, 14) andPoint:CGPointMake(0, julebu.bottom + 12) andWithTag:2];
    [use setUserInteractionEnabled:YES];
    [use addGestureRecognizer:singleTap2];
    //    [self.view addSubview:use];
    
    UITapGestureRecognizer *singleTaps = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(area)];
    BeginTouView *beginView3 = [[BeginTouView alloc] init];
    use2 = [beginView3 getBeginTouView:@"注册省市" andWithTintTitle:@"" andWithEndImage:@"extend" andWithImageSize:CGSizeMake(15/2, 14) andPoint:CGPointMake(0, julebu.bottom + 12) andWithTag:2];
    [use2 setUserInteractionEnabled:YES];
    [use2 addGestureRecognizer:singleTaps];
    //    [self.view addSubview:use2];
    
    UITapGestureRecognizer *singleTap3 = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(julebuname)];
    BeginTouView *beginView4 = [[BeginTouView alloc] init];
    use3 = [beginView4 getBeginTouView:@"用户名称" andWithTintTitle:@"" andWithEndImage:@"extend" andWithImageSize:CGSizeMake(15/2, 14) andPoint:CGPointMake(0, julebu.bottom + 12) andWithTag:2];
    [use3 setUserInteractionEnabled:YES];
//    [use3 addGestureRecognizer:singleTap3];
    
    txtField = [[UITextField alloc] initWithFrame:CGRectMake(80  , 0 ,  kScreen_Width - 110 ,45)];
    txtField.tintColor = [UIColor colorWithHexString:@"cccccc"];
    txtField.userInteractionEnabled = YES ;
    txtField.font = SystemFontOfSize(14);
    txtField.tag = 31 ;
//    txtField.backgroundColor = [UIColor blueColor] ;
    txtField.tintColor = [UIColor colorWithHexString:@"3f3f3f"];
    txtField.textColor = [UIColor colorWithHexString:@"3f3f3f"];
    txtField.textAlignment = NSTextAlignmentRight ;
    [use3 addSubview:txtField];
    [self.view addSubview:use3];
    
    UITapGestureRecognizer *singleTap4 = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(time)];
    BeginTouView *beginView5 = [[BeginTouView alloc] init];
    use4 = [beginView5 getBeginTouView:@"成立时间" andWithTintTitle:@"" andWithEndImage:@"extend" andWithImageSize:CGSizeMake(15/2, 14) andPoint:CGPointMake(0, use3.bottom) andWithTag:2];
    [use4 setUserInteractionEnabled:YES];
    [use4 addGestureRecognizer:singleTap4];
    //    [self.view addSubview:use4];
    
    UITapGestureRecognizer *singleTap5 = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(jianj)];
    BeginTouView *beginView6 = [[BeginTouView alloc] init];
    use5 = [beginView6 getBeginTouPic:@"简介" andWithContent: @"" andWithEndImage:@"extend" andWithImageSize:CGSizeMake(15/2, 14) andPoint:CGPointMake(0, use3.bottom)];
    [use5 setUserInteractionEnabled:YES];
    [use5 addGestureRecognizer:singleTap5];
//    [self.view addSubview:use5];
    
    
    UIButton *exit = [[UIButton alloc] initWithFrame:CGRectMake((kScreen_Width - kScreen_Width + 24)/2, use3.bottom + 20 , kScreen_Width - 24 , 82/2)];
    [exit setTitle:@"确认修改" forState:UIControlStateNormal];
    exit.titleLabel.font = [UIFont systemFontOfSize: 34/2];
    [exit addTarget:self action:@selector(goAction) forControlEvents:UIControlEventTouchUpInside];
    [exit.layer setCornerRadius:4]; //设置矩形四个圆角半径
    exit.backgroundColor = [UIColor colorWithHexString:@"000000"];
    [self.view addSubview:exit];

    
}

-(void)goAction  {
    
    self.HUD = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    
    if (txtField.text == nil) {
        txtField.text = @"" ;
    }
    
    cache = [YYCache cacheWithName:@"FB"];
    uvo = [cache objectForKey:@"userData"];
    
    NSDictionary *params = [NSDictionary dictionaryWithObjectsAndKeys:[CommonFunc base64StringFromText:txtField.text] , @"nickname" , uvo.phone , @"phone" ,picUrl , @"headpicurl" , uvo.phone  , @"token" , nil];
    
    [PPNetworkHelper POST:changeNicknameHeadPic parameters:params success:^(id data) {
        if([data[@"code"] isEqualToString:@"0000"]){
            self.HUD.mode = MBProgressHUDModeText;
            self.HUD.removeFromSuperViewOnHide = YES;
            self.HUD.labelText = @"更新成功";
            [self.HUD hide:YES afterDelay:3];
            
            [self.navigationController popViewControllerAnimated:YES];
        }else {
            self.HUD.mode = MBProgressHUDModeText;
            self.HUD.removeFromSuperViewOnHide = YES;
            self.HUD.labelText = @"系统错误";
            [self.HUD hide:YES afterDelay:3];
        }

    }failure:^(NSError *error) {
        
    }];
    [self closeProgressView];

}


-(void)area{
    ChooseAreaViewController *area = [[ChooseAreaViewController alloc] init];
    area.isfrom = @"1" ;
    [self.navigationController pushViewController:area animated:YES];
}

-(void)jianj{
//    [self hideTabBottom];
//    CreateJianJieViewController *createName = [[CreateJianJieViewController alloc] init];
//    [self.navigationController pushViewController:createName animated:YES];
}

-(void)sendlogo{
    myActionSheet = [[UIActionSheet alloc]
                     initWithTitle:nil
                     delegate:self
                     cancelButtonTitle:@"取消"
                     destructiveButtonTitle:nil
                     otherButtonTitles: @"打开照相机", @"从手机相册获取",nil];
    
    [myActionSheet showInView:self.view];
    
}

-(void)time{
    
    UIView *chooseDate = [[UIView alloc] initWithFrame:CGRectMake(0, kScreen_Height - 250, kScreen_Width, 250)];
    chooseDate.backgroundColor = [UIColor whiteColor];
    chooseDate.hidden = YES ;
    //    [self.view addSubview:chooseDate];
    
    
    NSLocale *ch_zh_locale = [[NSLocale alloc] initWithLocaleIdentifier:@"zh_Hans_CN"] ;
    //创建datePicker实例变量并初始化
    datePicker = [[UIDatePicker alloc] initWithFrame:CGRectMake(0, kScreen_Height - 240  , kScreen_Width , 240)];//无法改变其高和宽，但是可以获取
    datePicker.backgroundColor = [UIColor whiteColor];
    datePicker.locale = ch_zh_locale; //设置中文显示
    datePicker.tag = 55 ;
    [NSDate date];  //此方法获取的时间是格林尼治时间中国的时间是东八区 + 8小时即可
    NSTimeInterval eigth_Z_CH = 8*60*60;
    NSDate *currentDate = [NSDate dateWithTimeIntervalSinceNow:eigth_Z_CH]; //中国的当前时间
    [datePicker setDatePickerMode:UIDatePickerModeDate];//设置显示模式
    [datePicker setTimeZone:[NSTimeZone timeZoneWithName:@"Asia/Shanghai"]];//设置时区，上海时区
    //    [datePicker setMinimumDate:[NSDate date]]; //设置控件的最小时间，超出最小时间还小则会弹回，此时时间为中国时间
    //    [datePicker setMaximumDate:[NSDate dateWithTimeIntervalSinceNow:30*24*60*60]];//设置最大时间，超出也会弹回
    datePicker.hidden = NO ;
    [self.view addSubview:datePicker];
    
    CGSize titleSize = [NSString getStringContentSizeWithFontSize:14 andContent:@"完成"];
    backViewBtn2 = [UIButton buttonWithType:UIButtonTypeCustom];
    backViewBtn2.frame = CGRectMake(kScreen_Width - titleSize.width - 8, datePicker.top + 5, titleSize.width, titleSize.height) ;
    [backViewBtn2 setTitle:@"完成" forState:UIControlStateNormal];
    [backViewBtn2 setTitleColor:[UIColor colorWithHexString:@"0ec481"]forState:UIControlStateNormal];
    backViewBtn2.titleLabel.font = [UIFont systemFontOfSize: 14];
    [backViewBtn2 addTarget:self action: @selector(open)
           forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:backViewBtn2];
}

- (void)open
{
    NSDate *pickerDate = [datePicker date];//格林尼治时间
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy年MM月dd日"];
    NSString *dateAndTime =  [dateFormatter stringFromDate:pickerDate];
    
    [use4 removeFromSuperview];
    BeginTouView *beginView5 = [[BeginTouView alloc] init];
    use4 = [beginView5 getBeginTouView:@"成立时间" andWithTintTitle:dateAndTime andWithEndImage:@"extend" andWithImageSize:CGSizeMake(15/2, 14) andPoint:CGPointMake(0, use3.bottom) andWithTag:2];
    [use4 setUserInteractionEnabled:YES];
    [self.view addSubview:use4];
    
    
    [datePicker removeFromSuperview];
    [backViewBtn2 removeFromSuperview];
}

-(void)julebuname{
//    [self hideTabBottom];
//    CreateClubNameViewController *club = [[CreateClubNameViewController alloc] init];
//    [self.navigationController pushViewController:club animated:YES];
}

-(void)sendname{
//    [self hideTabBottom];
//    CreateNameViewController *createName = [[CreateNameViewController alloc] init];
//    [self.navigationController pushViewController:createName animated:YES];
}

- (void)tapAction : (id) sender andWithTag :(NSString *)tag{
    
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
    
    NSDictionary *params = [NSDictionary dictionaryWithObjectsAndKeys:_encodedImageStr , @"base64file" , nil];
    
    [PPNetworkHelper POST:uploadPic parameters:params success:^(id data) {
        if([data[@"code"] isEqualToString:@"0000"]){
            picUrl = data[@"URL"] ;
            [self showImage:picUrl];
        }
        [self closeProgressView];
    } failure:^(NSError *error) {
        
    }];
    
}

-(void)showImage : (NSString *) url{
    UIImageView *logo = [julebu viewWithTag:12];
    [logo setImageWithURL:[NSURL URLWithString:url] placeholderImage:[UIImage imageNamed:@"defaulthead"]];
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

@end

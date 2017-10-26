//
//  UpdateUserInfoViewController.m
//  FBLeague
//
//  Created by long-laptop on 2017/3/10.
//  Copyright © 2017年 long-laptop. All rights reserved.
//

#import "UpdateUserInfoViewController.h"
#import "AppDelegate.h"

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
    
    
    UIButton *exit = [[UIButton alloc] initWithFrame:CGRectMake(0, use3.bottom + 20 , kScreen_Width , 82/2)];
    [exit setTitle:@"确认修改" forState:UIControlStateNormal];
    exit.titleLabel.font = [UIFont systemFontOfSize: 15];
    [exit setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [exit addTarget:self action:@selector(goAction) forControlEvents:UIControlEventTouchUpInside];
    [exit.layer setCornerRadius:4]; //设置矩形四个圆角半径
    exit.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:exit];
    
    
    UIButton *exit2 = [[UIButton alloc] initWithFrame:CGRectMake(0 , exit.bottom + 20 , kScreen_Width , 82/2)];
    [exit2 setTitle:@"退出咖盟" forState:UIControlStateNormal];
    exit2.titleLabel.font = [UIFont systemFontOfSize: 15];
    [exit2 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [exit2 addTarget:self action:@selector(exit) forControlEvents:UIControlEventTouchUpInside];
    exit2.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:exit2];

    
}

-(void)exit{
    UIAlertView* alert = [[UIAlertView alloc] initWithTitle:@"确定注销当前账号？" message:@"" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定",nil];
    [alert show];
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if(buttonIndex ==1){
        [self exitApplication];
    }
    
}

- (void)exitApplication {
    cache = [YYCache cacheWithName:@"FB"];
    [cache removeObjectForKey:@"userData"] ;
    [((AppDelegate *)[UIApplication sharedApplication].delegate) showMsg];
}



-(void)goAction  {
    
    if (txtField.text == nil) {
        txtField.text = @"" ;
    }
    
    cache = [YYCache cacheWithName:@"FB"];
    uvo = [cache objectForKey:@"userData"];
    
    NSDictionary *params = [NSDictionary dictionaryWithObjectsAndKeys:[CommonFunc base64StringFromText:txtField.text] , @"nickname" , uvo.phone , @"phone" ,picUrl , @"headpicurl" , uvo.phone  , @"token" , nil];
    
    [PPNetworkHelper POST:changeNicknameHeadPic parameters:params success:^(id data) {
        if([data[@"code"] isEqualToString:@"0000"]){
           
            [SVProgressHUD showSuccessWithStatus:@"更新成功"];
            [SVProgressHUD setDefaultStyle:SVProgressHUDStyleDark];
 
            [self.navigationController popViewControllerAnimated:YES];
        }else {
         
            [SVProgressHUD showErrorWithStatus:@"系统错误"];
            [SVProgressHUD setDefaultStyle:SVProgressHUDStyleDark];

        }

    }failure:^(NSError *error) {
        
    }];

}


-(void)area{
    ChooseAreaViewController *area = [[ChooseAreaViewController alloc] init];
    area.isfrom = @"1" ;
    [self.navigationController pushViewController:area animated:YES];
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

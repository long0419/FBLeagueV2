//
//  CreateClubViewController.m
//  FBLeague
//
//  Created by long-laptop on 2017/7/21.
//  Copyright © 2017年 long-laptop. All rights reserved.
//

#import "CreateClubViewController.h"
#import "DSLLoginTextField.h"
#import "SCLAlertView.h"

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

}

@end

@implementation CreateClubViewController

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
//    timeTxt.delegate = self ;
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
    moto.maxTextLength= 11;
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
    self.HUD = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    cache = [YYCache cacheWithName:@"FB"];
    uvo = [cache objectForKey:@"userData"];

    NSArray *areas = [_areaCodeStr componentsSeparatedByString:@" "];
    NSDictionary *params = [NSDictionary
                            dictionaryWithObjectsAndKeys:
                            uvo.phone , @"creator"  ,
                            [CommonFunc base64StringFromText:tf.text] , @"name" ,
                            moto.text ,@"description" ,
                            uvo.phone ,  @"token",
                            [areas objectAtIndex:0] , @"provincecode" ,
                            [areas objectAtIndex:1] , @"citycode" ,
                            [areas objectAtIndex:2] , @"areacode" ,
                            url , @"logourl" ,
                            nil];
    [PPNetworkHelper POST:crxClub parameters:params success:^(id object) {
        if([object[@"code"] isEqualToString:@"0000"]){
            SCLAlertView *alert = [[SCLAlertView alloc] init];
            [alert addButton:@"去报名" actionBlock:^(void) {
                self.hidesBottomBarWhenPushed=YES;
                VerifyClubViewController *verify = [VerifyClubViewController new];
                [self.navigationController pushViewController:verify animated:YES];
                self.hidesBottomBarWhenPushed=NO;
            }];
            [alert alertIsDismissed:^{
                [self.navigationController popViewControllerAnimated:YES];
                self.hidesBottomBarWhenPushed=NO;
            }];
            [alert showSuccess:self title:@"创建成功" subTitle:@"你可以报名参加咖盟联赛啦!" closeButtonTitle:@"拒绝，并返回俱乐部页面" duration:0.0f];
            [self closeProgressView] ;
        }
    } failure:^(NSError *error) {
    }];

}


-(void)textFieldDidBeginEditing:(UITextField*)textField

{
    [textField resignFirstResponder];
    if(textField.tag == 10){
        self.hidesBottomBarWhenPushed=YES;
        ChooseAreaViewController *area = [[ChooseAreaViewController alloc] init];
        area.isfrom = @"1" ;
        [self.navigationController pushViewController:area animated:YES];
        self.hidesBottomBarWhenPushed=NO;
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

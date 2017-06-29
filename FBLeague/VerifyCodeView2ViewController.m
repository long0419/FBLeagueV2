//
//  VerifyCodeView2ViewController.m
//  FBLeague
//
//  Created by long-laptop on 2016/11/21.
//  Copyright © 2016年 long-laptop. All rights reserved.
//

#import "VerifyCodeView2ViewController.h"
#import "AccountView.h"
#import "RegisterTxtView.h"
#import "UserDataVo.h"
#import "MWLocalDataTool.h"

@interface VerifyCodeView2ViewController (){
    UIButton *verifyCode ;
    UITextField *phoneText ;
    UITextField *valicodeText ;
    NSString *authCode ;
    UIButton *regi ;
    UIActionSheet *myActionSheet;

}

@end

@implementation VerifyCodeView2ViewController

-(void)viewWillAppear:(BOOL)animated{
    self.navigationController.navigationBar.hidden = true ;
    
}

-(void)viewWillDisappear:(BOOL)animated{
    self.navigationController.navigationBar.hidden = false ;
}

-(void)viewDidAppear:(BOOL)animated{
    if (_roleStr != nil && ![@"" isEqualToString:_roleStr]) {
        ((UITextField *)[_role viewWithTag:11]).text = _roleStr ;
    }
    
    if (_areaStr != nil && ![@"" isEqualToString:_areaStr]) {
        ((UITextField *)[_area viewWithTag:11]).text = _areaStr ;
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];

    UIView *bg = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreen_Width, kScreen_Height)];
    bg.backgroundColor = [UIColor colorWithHexString:@"feffff"];
    [self.view addSubview:bg];
    
    UIImageView *back = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"close"]];
    back.frame = CGRectMake(15, 37, 15, 15);
    back.userInteractionEnabled = YES;
    UITapGestureRecognizer *singleTap1 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(back)];
    [back addGestureRecognizer:singleTap1];
    [bg addSubview:back];
    
    CGSize titleSize = [NSString getStringContentSizeWithFontSize:38/2 andContent:@"注册"];
    UILabel *title = [[UILabel alloc] initWithFrame:CGRectMake((kScreen_Width - titleSize.width)/2 , 33 , titleSize.width, titleSize.height)] ;
    title.text = @"注册" ;
    title.font = [UIFont systemFontOfSize:38/2] ;
    title.textColor = [UIColor colorWithHexString:@"333333"] ;
    [self.view addSubview:title];
    
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
    
    CGSize textNameSize = [NSString getStringContentSizeWithFontSize:11 andContent:@"昵称"] ;
    UILabel *name = [[UILabel alloc] initWithFrame:CGRectMake(30 , bgImg.bottom + 20 , textNameSize.width, textNameSize.height)] ;
    name.text = @"昵称" ;
    name.font = [UIFont systemFontOfSize:11] ;
    name.textColor = [UIColor colorWithHexString:@"333333"] ;
    [self.view addSubview:name];
    
    
    CGSize tempSize = [NSString getStringContentSizeWithFontSize:14 andContent:@"请输入昵称"] ;
    CGRect accountFrame = CGRectMake(30 , name.bottom + SYRealValue(14), kScreen_Width - 60 , tempSize.height + 14 + .5) ;
    _account = [AccountView accountView:@"" andWithDefaultText:@"请输入昵称" andWithCGRect:accountFrame];
    _account.frame = accountFrame ;
    [self.view addSubview:_account];
    
    if (_nickName) {
        ((UITextField *)[_account viewWithTag:11]).text = _nickName ;
    }
    
    CGSize psdSize = [NSString getStringContentSizeWithFontSize:11 andContent:@"密码"] ;
    UILabel *psdname = [[UILabel alloc] initWithFrame:CGRectMake(30 , _account.bottom + SYRealValue(20) , psdSize.width, psdSize.height)] ;
    psdname.text = @"密码" ;
    psdname.font = [UIFont systemFontOfSize:11] ;
    psdname.textColor = [UIColor colorWithHexString:@"333333"] ;
    [self.view addSubview:psdname];
    
    CGRect tmpSize = CGRectMake(30 , psdname.bottom + SYRealValue(14), kScreen_Width - 60 , SYRealValue(tempSize.height + 14 + .5)) ;
    _psw = [AccountView accountView:@"" andWithDefaultText:@"请输入密码" andWithCGRect:tmpSize];
    _psw.frame = tmpSize ;
    UITextField *psd = [_psw viewWithTag:11];
    psd.delegate = self ;
    [self.view addSubview:_psw];
    
    CGSize chooseSize = [NSString getStringContentSizeWithFontSize:11 andContent:@"选择角色"] ;
    UILabel *choose = [[UILabel alloc] initWithFrame:CGRectMake(30 , _psw.bottom + SYRealValue(20) , chooseSize.width, chooseSize.height)] ;
    choose.text = @"选择角色" ;
    choose.font = [UIFont systemFontOfSize:11] ;
    choose.textColor = [UIColor colorWithHexString:@"333333"] ;
    [self.view addSubview:choose];
    
    CGRect tmp2Size = CGRectMake(30 , choose.bottom + SYRealValue(14), kScreen_Width - 60 , tempSize.height + 14 + .5) ;
    _role = [AccountView accountView:@"" andWithDefaultText:@"点击选择角色" andWithCGRect:tmp2Size];
    _role.frame = tmp2Size ;
    [[_role viewWithTag:11] setUserInteractionEnabled:NO];
    UITapGestureRecognizer *tapGesture=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(event1)];
    [_role addGestureRecognizer:tapGesture];
    [self.view addSubview:_role];
    
    CGSize areaSize = [NSString getStringContentSizeWithFontSize:11 andContent:@"选择地区"] ;
    UILabel *area = [[UILabel alloc] initWithFrame:CGRectMake(30 , _role.bottom + SYRealValue(20) , areaSize.width, areaSize.height)] ;
    area.text = @"选择地区" ;
    area.font = [UIFont systemFontOfSize:11] ;
    area.textColor = [UIColor colorWithHexString:@"333333"] ;
    [self.view addSubview:area];
    
    CGRect tmp3Size = CGRectMake(30 , area.bottom + SYRealValue(14), kScreen_Width - 60 , tempSize.height + 14 + .5) ;
    _area = [AccountView accountView:@"" andWithDefaultText:@"点击选择地区" andWithCGRect:tmp3Size];
    _area.frame = tmp3Size ;
    [[_area viewWithTag:11] setUserInteractionEnabled:NO];
    UITapGestureRecognizer *tapGesture2=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(event2)];
    [_area addGestureRecognizer:tapGesture2];
    [self.view addSubview:_area];

    CGFloat y = SYRealValue(45) ;
    NSLog(@"height %f" , [[UIScreen mainScreen] bounds].size.height) ;
    
    if (kScreen_Height == 480.000000) {
        y = SYRealValue(20) ;
    }
    
    UIButton *loginBtn = [UIButton buttonWithType: UIButtonTypeCustom];
    loginBtn.frame = CGRectMake(30 , _area.bottom + y , kScreen_Width - 60 , SYRealValue(110/2)) ;
    loginBtn.backgroundColor = [UIColor colorWithHexString:@"2eb66a"];
    [loginBtn setTitle:@"注册" forState:UIControlStateNormal];
    loginBtn.titleLabel.font = [UIFont systemFontOfSize: 15];
    loginBtn.titleLabel.textColor = [UIColor colorWithHexString:@"ffffff"];
    loginBtn.layer.cornerRadius= SYRealValue(110/2/2) ;
    loginBtn.layer.masksToBounds=YES;
    loginBtn.tag = 3 ;
    [loginBtn addTarget:self action:@selector(next) forControlEvents:UIControlEventTouchUpInside];//button 点击回调方法
    [self.view addSubview:loginBtn];
    
}

-(void)back{
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)next{
    self.HUD = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    
    if ([((UITextField *)[_account viewWithTag:11]).text isEqualToString:@""]) {
        self.HUD.mode = MBProgressHUDModeText;
        self.HUD.removeFromSuperViewOnHide = YES;
        self.HUD.labelText = @"请输入昵称";
        [self.HUD hide:YES afterDelay:3];
        return ;
    }
    
    if ([((UITextField *)[_psw viewWithTag:11]).text isEqualToString:@""]) {
        self.HUD.mode = MBProgressHUDModeText;
        self.HUD.removeFromSuperViewOnHide = YES;
        self.HUD.labelText = @"请输入密码";
        [self.HUD hide:YES afterDelay:3];
        return ;
    }
    
    if ([((UITextField *)[_role viewWithTag:11]).text isEqualToString:@"点击选择角色"]) {
        self.HUD.mode = MBProgressHUDModeText;
        self.HUD.removeFromSuperViewOnHide = YES;
        self.HUD.labelText = @"请选择角色";
        [self.HUD hide:YES afterDelay:3];
        return ;
    }

    if ([((UITextField *)[_role viewWithTag:11]).text isEqualToString:@"点击选择地区"]) {
        self.HUD.mode = MBProgressHUDModeText;
        self.HUD.removeFromSuperViewOnHide = YES;
        self.HUD.labelText = @"请选择地区";
        [self.HUD hide:YES afterDelay:3];
        return ;
    }
    
    
    APIClient *client = [APIClient sharedJsonClient];
    NSArray *areas = [_areaCodeStr componentsSeparatedByString:@" "];
    NSString *rolename = ((UITextField *)[_role viewWithTag:11]).text ;
    NSString *roletxt = nil ;
    if ([@"教练" isEqualToString:rolename]) {
        roletxt = @"1" ;
    }else if([@"球员" isEqualToString:rolename]){
        roletxt = @"2" ;
    }else{
        roletxt = @"3" ;
    }
    
    NSDictionary *params = [NSDictionary dictionaryWithObjectsAndKeys:
        _phone , @"phone" ,
        ((UITextField *)[_psw viewWithTag:11]).text, @"pwd",
        ((UITextField *)[_account viewWithTag:11]).text , @"realname",
        roletxt , @"role" ,
        [areas objectAtIndex:0] , @"provincecode" ,
        [areas objectAtIndex:1] , @"citycode" ,
        _imageUrl , @"headpicurl" , nil];
    
    [client requestJsonDataWithPath:registerUser withParams:params withMethodType:Post andBlock:^(id data, NSError *error) {
        if([data[@"code"] isEqualToString:@"0000"]){
            UserDataVo *user = [UserDataVo new];
            user.nickname = ((UITextField *)[_account viewWithTag:11]).text ;
            user.phone = _phone ;
            user.pwd = ((UITextField *)[_psw viewWithTag:11]).text ;
            NSData *data = [NSKeyedArchiver archivedDataWithRootObject:user];
//            [[MWLocalDataTool shareInstance] saveNSUserDefaultsWithKey:@"userData" AndObject:data];
            UserDefaultSet(@"userData" , data);
            [[NSNotificationCenter defaultCenter] postNotificationName:@"verifyLoginStatus" object:self];
            
            [self closeProgressView];
        }
    
        [self closeProgressView];
    }];

}

-(void)event1{
    ChooseRoleViewController *forget = [[ChooseRoleViewController alloc] init];
    [self.navigationController pushViewController:forget animated:YES];
}

-(void)event2{
    ChooseAreaViewController *area = [[ChooseAreaViewController alloc] init];
    [self.navigationController pushViewController:area animated:YES];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder] ;
    return true;
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
            NSString *url = data[@"URL"] ;
            
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

-(BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    
    if ([text isEqualToString:@"\n"]) {
        
        [textView resignFirstResponder];
        
        return NO;
        
    }
    return YES;
}
@end

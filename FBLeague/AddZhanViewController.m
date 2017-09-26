//
//  AddZhanViewController.m
//  FBLeague
//
//  Created by long-laptop on 2017/1/4.
//  Copyright © 2017年 long-laptop. All rights reserved.
//

#import "AddZhanViewController.h"

@interface AddZhanViewController (){
    UITextView *jianjie ;
    UITextField *name ;
    UITextField *bussiness ;
    UITextField *address ;
    UITextField *contact ;
    UserDataVo *uvo ;
    YYCache *cache ;
    UIView *julebu ;
    UIActionSheet *myActionSheet;
    NSString *picUrl ;

}

@end

@implementation AddZhanViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"设置" ;
    self.view.backgroundColor = [UIColor colorWithHexString:@"f5f6f7"];
    
    [self setBackBottmAndTitle];
    
    MeView *me = [MeView new];
    [me getKeShi:@"昵称" andWithContent:@"" andWithType:@"2"];
    me.origin = CGPointMake(0, 12);
    name = [me viewWithTag:11];
    name.delegate = self ;
    [self.view addSubview:me];
    
    MeView *me11 = [MeView new];
    [me11 getKeShi:@"性别" andWithContent:@"" andWithType:@"2"];
    me11.origin = CGPointMake(0, me.bottom);
    bussiness = [me11 viewWithTag:11];
    bussiness.delegate = self ;
    [self.view addSubview:me11];

    MeView *me12 = [MeView new];
    [me12 getKeShi:@"所在地" andWithContent:@"" andWithType:@"2"];
    me12.origin = CGPointMake(0, me11.bottom);
    address = [me12 viewWithTag:11];
    address.delegate = self ;
    [self.view addSubview:me12];

    MeView *me13 = [MeView new];
    [me13 getKeShi:@"生日" andWithContent:@"" andWithType:@"2"];
    me13.origin = CGPointMake(0, me12.bottom + 20);
    contact = [me13 viewWithTag:11];
    contact.delegate = self ;
    [self.view addSubview:me13];
    
    MeView *me21 = [MeView new];
    [me21 getKeShi:@"邮箱" andWithContent:@"" andWithType:@"2"];
    me21.origin = CGPointMake(0, me13.bottom);
    contact = [me21 viewWithTag:21];
    contact.delegate = self ;
    [self.view addSubview:me21];
    
    MeView *me22 = [MeView new];
    [me22 getKeShi:@"注册时间" andWithContent:@"" andWithType:@"2"];
    me22.origin = CGPointMake(0, me21.bottom);
    contact = [me22 viewWithTag:22];
    contact.delegate = self ;
    [self.view addSubview:me22];
    
    UIButton *exit = [[UIButton alloc] initWithFrame:CGRectMake(0 , me22.bottom + 20 , kScreen_Width , 82/2)];
    [exit setTitle:@"退出咖盟认证" forState:UIControlStateNormal];
    exit.titleLabel.font = [UIFont systemFontOfSize: 15];
    [exit setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [exit addTarget:self action:@selector(exit) forControlEvents:UIControlEventTouchUpInside];
    exit.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:exit];

    UIButton *exit2 = [[UIButton alloc] initWithFrame:CGRectMake(0 , exit.bottom + 20 , kScreen_Width , 82/2)];
    [exit2 setTitle:@"退出咖盟" forState:UIControlStateNormal];
    exit2.titleLabel.font = [UIFont systemFontOfSize: 15];
    [exit2 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [exit2 addTarget:self action:@selector(exit) forControlEvents:UIControlEventTouchUpInside];
    exit2.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:exit];

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


-(void)setBackBottmAndTitle{
    
    UIButton *backViewBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    backViewBtn.frame = CGRectMake(0, 0, 17, 17);
    [backViewBtn setImage:[UIImage imageNamed:@"back2"] forState:UIControlStateNormal];
    [backViewBtn addTarget:self action: @selector(back)
          forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *backItem = [[UIBarButtonItem alloc] initWithCustomView:backViewBtn];
    self.navigationItem.leftBarButtonItem = backItem ;
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

-(void)sendlogo{
    myActionSheet = [[UIActionSheet alloc]
                     initWithTitle:nil
                     delegate:self
                     cancelButtonTitle:@"取消"
                     destructiveButtonTitle:nil
                     otherButtonTitles: @"打开照相机", @"从手机相册获取",nil];
    
    [myActionSheet showInView:self.view];
    
}

-(void)publish{
//    APIClient *client = [APIClient sharedJsonClient];
    
    NSDictionary *params = [NSDictionary dictionaryWithObjectsAndKeys:                                                          name.text , @"name" ,
                            bussiness.text ,@"business",
                            address.text ,@"location" ,
                            contact.text ,@"contact" ,
                            _club , @"club" ,
                            picUrl , @"logourl",
                            nil];
//    [client requestJsonDataWithPath:addSponsor withParams:params withMethodType:Post andBlock:^(id data, NSError *error) {
//        if([data[@"code"] isEqualToString:@"0000"]){
//            self.HUD.mode = MBProgressHUDModeText;
//            self.HUD.removeFromSuperViewOnHide = YES;
//            self.HUD.labelText = @"发布成功";
//            [self.HUD hide:YES afterDelay:8];
//            
//        }else {
//            self.HUD.mode = MBProgressHUDModeText;
//            self.HUD.removeFromSuperViewOnHide = YES;
//            self.HUD.labelText = @"系统错误";
//            [self.HUD hide:YES afterDelay:3];
//        }
//    }];
    
    [self.navigationController popViewControllerAnimated:YES];
    
    [self closeProgressView];
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
    
//    APIClient *client = [APIClient sharedJsonClient];
//    NSDictionary *params = [NSDictionary dictionaryWithObjectsAndKeys:_encodedImageStr , @"base64file" , nil];
//    [client requestJsonDataWithPath:uploadPic withParams:params withMethodType:Post andBlock:^(id data, NSError *error) {
//        if([data[@"code"] isEqualToString:@"0000"]){
//            NSString *url = data[@"URL"] ;
//            picUrl = url ;
//            //添加图片界面上
//            [self showImage : url];
//            
//        }
//        [self closeProgressView];
//    }];
    
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

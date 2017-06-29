//
//  ChooseRoleViewController.m
//  FBLeague
//
//  Created by long-laptop on 2016/11/21.
//  Copyright © 2016年 long-laptop. All rights reserved.
//

#import "ChooseRoleViewController.h"

@interface ChooseRoleViewController (){
    UIView *chooseView ;
    UIImageView *choose1 ;
    UIImageView *choose2 ;
    UIImageView *choose3 ;
    UIButton *sender ;
    NSString *tag ;
}

@end

@implementation ChooseRoleViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setBackBottmAndTitle];
    
    self.title = @"选择角色" ;
    self.view.backgroundColor = [UIColor colorWithHexString:@"f6f6f6"] ;
    
    CGSize psdSize = [NSString getStringContentSizeWithFontSize:13 andContent:@"全部"] ;
    UILabel *psdname = [[UILabel alloc] initWithFrame:CGRectMake(15 , 10 , psdSize.width, psdSize.height)] ;
    psdname.text = @"全部" ;
    psdname.font = [UIFont systemFontOfSize:13] ;
    psdname.textColor = [UIColor colorWithHexString:@"999999"] ;
    [self.view addSubview:psdname];
    
    chooseView = [[UIView alloc] initWithFrame:CGRectMake(0 , psdname.bottom + 8, kScreen_Width, 98/2*3)];
    chooseView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:chooseView];
    
    [self fillContent];
    
    [self fillContent2];
    
    [self fillContent3];
    
    [self setRightBottom];
}


- (void)setRightBottom {
    CGSize size = [NSString getStringContentSizeWithFontSize:15 andContent:@"发送"] ;
    sender = [UIButton buttonWithType:UIButtonTypeCustom];
    sender.frame = CGRectMake(0, 0, size.width , size.height);
    [sender setTitle:@"确定" forState:UIControlStateNormal];
    sender.titleLabel.font = [UIFont systemFontOfSize: 15];
    sender.titleLabel.alpha = 1 ;

    [sender setTitleColor:[UIColor colorWithHexString:@"ffffff"]forState:UIControlStateNormal];
    [sender addTarget:self action: @selector(send)
     forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *backItem = [[UIBarButtonItem alloc] initWithCustomView:sender];
    self.navigationItem.rightBarButtonItem = backItem ;
}

-(void)send{
    NSString *role = nil ;
    if ([tag isEqualToString:@"1"]) {
        role = @"教练" ;
    }else if([tag isEqualToString:@"2"]){
        role = @"球员" ;
    }else{
        role = @"球迷" ;
    }

    
    VerifyCodeView2ViewController *verifyCode2 =
    [self.navigationController.viewControllers objectAtIndex:self.navigationController.viewControllers.count-2];
    verifyCode2.roleStr = role ;
    [self.navigationController popToViewController:verifyCode2 animated:YES];
}


-(void) fillContent {
    
    UIView *jiaolian = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreen_Width, 98/2)];
    jiaolian.backgroundColor = [UIColor clearColor] ;
    jiaolian.tag = 1 ;
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(do1)];
    [jiaolian addGestureRecognizer:tapGesture];
    [chooseView addSubview:jiaolian];
    
    CGSize jiaolianSize = [NSString getStringContentSizeWithFontSize:15 andContent:@"教练"] ;
    UILabel *jiaolianTxt = [[UILabel alloc] initWithFrame:CGRectMake(15 , (98/2 - jiaolianSize.height)/2 , jiaolianSize.width, jiaolianSize.height)] ;
    jiaolianTxt.text = @"教练" ;
    jiaolianTxt.font = [UIFont systemFontOfSize:15] ;
    jiaolianTxt.textColor = [UIColor colorWithHexString:@"333333"] ;
    [jiaolian addSubview:jiaolianTxt];
    
    choose1 = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"choose"]];
    choose1.frame = CGRectMake(kScreen_Width - 15 - 29/2, (jiaolian.height - 19/2)/2, 29/2, 19/2);
    choose1.hidden = true ;
    [jiaolian addSubview:choose1];
    
    UIView *line = [[UIView alloc] initWithFrame:CGRectMake(15 , 98/2, kScreen_Width - 30 , 1)];
    line.backgroundColor = [UIColor colorWithHexString:@"f3f3f4"];
    [chooseView addSubview:line];

}

-(void) fillContent2 {
    
    UIView *qiuyuan = [[UIView alloc] initWithFrame:CGRectMake(0, 98/2 , kScreen_Width, 98/2)];
    qiuyuan.backgroundColor = [UIColor clearColor] ;
    qiuyuan.tag = 2 ;
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(do2)];
    [qiuyuan addGestureRecognizer:tapGesture];
    [chooseView addSubview:qiuyuan];
    
    CGSize qiuyuanSize = [NSString getStringContentSizeWithFontSize:15 andContent:@"球员"] ;
    UILabel *qiuyuanTxt = [[UILabel alloc] initWithFrame:CGRectMake(15 , (qiuyuan.height - qiuyuanSize.height)/2 , qiuyuanSize.width, qiuyuanSize.height)] ;
    qiuyuanTxt.text = @"球员" ;
    qiuyuanTxt.font = [UIFont systemFontOfSize:15] ;
    qiuyuanTxt.textColor = [UIColor colorWithHexString:@"333333"] ;
    [qiuyuan addSubview:qiuyuanTxt];
    
    choose2 = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"choose"]];
    choose2.frame = CGRectMake(kScreen_Width - 15 - 29/2, (qiuyuan.height - 19/2)/2, 29/2, 19/2);
    choose2.hidden = true ;
    [qiuyuan addSubview:choose2];
    
    UIView *line = [[UIView alloc] initWithFrame:CGRectMake(15 , 98 , kScreen_Width - 30 , 1)];
    line.backgroundColor = [UIColor colorWithHexString:@"f3f3f4"];
    [chooseView addSubview:line];
    
}

-(void) fillContent3 {
    
    UIView *qiumi = [[UIView alloc] initWithFrame:CGRectMake(0, 98 , kScreen_Width, 98/2)];
    qiumi.backgroundColor = [UIColor clearColor] ;
    qiumi.tag = 3 ;
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(do3)];
    [qiumi addGestureRecognizer:tapGesture];

    [chooseView addSubview:qiumi];
    
    CGSize qiumiSize = [NSString getStringContentSizeWithFontSize:15 andContent:@"球迷"] ;
    UILabel *qiumiTxt = [[UILabel alloc] initWithFrame:CGRectMake(15 , (qiumi.height - qiumiSize.height)/2 , qiumiSize.width, qiumiSize.height)] ;
    qiumiTxt.text = @"球迷" ;
    qiumiTxt.font = [UIFont systemFontOfSize:15] ;
    qiumiTxt.textColor = [UIColor colorWithHexString:@"333333"] ;
    [qiumi addSubview:qiumiTxt];
    
    choose3 = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"choose"]];
    choose3.frame = CGRectMake(kScreen_Width - 15 - 29/2, (qiumi.height - 19/2)/2, 29/2, 19/2);
    choose3.hidden = true ;
    [qiumi addSubview:choose3];
    
}


-(void)do3{
    if (!choose3.hidden) {
        choose3.hidden = !choose3.hidden ;
    }else{
        choose1.hidden = choose3.hidden ;
        choose2.hidden = choose3.hidden ;
        choose3.hidden = !choose3.hidden ;
    }
    tag = @"3" ;
}

-(void)do2{
    if (!choose2.hidden) {
        choose2.hidden = !choose2.hidden ;
    }else{
        choose1.hidden = choose2.hidden ;
        choose3.hidden = choose2.hidden ;
        choose2.hidden = !choose2.hidden ;
    }
    tag = @"2" ;
}

-(void)do1{
    if (!choose1.hidden) {
        choose1.hidden = !choose1.hidden ;
    }else{
        choose2.hidden = choose1.hidden ;
        choose3.hidden = choose1.hidden ;
        choose1.hidden = !choose1.hidden ;
    }
    tag = @"1" ;
}


@end

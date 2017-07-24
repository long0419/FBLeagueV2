//
//  VerifyClubViewController.m
//  FBLeague
//
//  Created by long-laptop on 2017/7/21.
//  Copyright © 2017年 long-laptop. All rights reserved.
//

#import "VerifyClubViewController.h"
#import "ReadDetailContentViewController.h"

@interface VerifyClubViewController (){
    DSLLoginTextField *tf ;
    DSLLoginTextField *psw ;
    DSLLoginTextField *moto ;
    BOOL ischanged ;
    BFPaperCheckbox *checkbox ;
}

@end

@implementation VerifyClubViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    [self setBackBottmAndTitle];
    self.title = @"认证俱乐部" ;
    
    UIImageView *bgImg = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"认证券"]];
    [self.view addSubview:bgImg];
    [bgImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.view.mas_top).with.offset(18/2 + 44 + 20);
        make.centerX.mas_equalTo(self.view);
        make.width.mas_equalTo(kScreen_Width - 60);
        make.height.mas_equalTo(145);
    }];
    
    
    tf=[[DSLLoginTextField alloc]init];
    tf.clearButtonMode=UITextFieldViewModeWhileEditing;
    tf.placeholderColor=[UIColor colorWithHexString:@"cdcdcd"];
    tf.font=[UIFont systemFontOfSize:14];
    tf.placeholder=@"俱乐部创建人姓名";
    tf.maxTextLength= 11;
    tf.returnKeyType = UIReturnKeyGo ;
    tf.textAlignment = NSTextAlignmentCenter ;
    [self.view addSubview:tf];
    [tf mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(bgImg.mas_bottom).with.offset(33/2);
        make.left.mas_equalTo(SYRealValue(30)) ;
        make.height.mas_equalTo(SYRealValue(40));
        make.width.mas_equalTo(self.view.width - 60);
    }];
    
    psw=[[DSLLoginTextField alloc]init];
    psw.clearButtonMode=UITextFieldViewModeWhileEditing;
    psw.placeholderColor=[UIColor colorWithHexString:@"cdcdcd"];
    psw.font=[UIFont systemFontOfSize:14];
    psw.placeholder=@"创建人身份证号码";
    psw.maxTextLength= 11;
    psw.tag = 10 ;
    psw.textAlignment = NSTextAlignmentCenter ;
    [self.view addSubview:psw];
    [psw mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(tf.mas_bottom).with.offset(20) ;
        make.left.mas_equalTo(SYRealValue(30)) ;
        make.height.mas_equalTo(SYRealValue(40));
        make.width.mas_equalTo(self.view.width - 60);
    }];
    
    moto=[[DSLLoginTextField alloc]init];
    moto.clearButtonMode=UITextFieldViewModeWhileEditing;
    moto.placeholderColor=[UIColor colorWithHexString:@"cdcdcd"];
    moto.font=[UIFont systemFontOfSize:14];
    moto.placeholder=@"创建人收款账户（目前仅限支付宝）";
    moto.maxTextLength= 11;
    moto.textAlignment = NSTextAlignmentCenter ;
    [self.view addSubview:moto];
    [moto mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(psw.mas_bottom).with.offset(20) ;
        make.left.mas_equalTo(SYRealValue(30)) ;
        make.height.mas_equalTo(SYRealValue(40));
        make.width.mas_equalTo(self.view.width - 60);
    }];

    checkbox = [[BFPaperCheckbox alloc] init];
    checkbox.delegate = self;
    checkbox.tintColor = [UIColor blackColor];
    checkbox.checkmarkColor = [UIColor blackColor];
    checkbox.positiveColor = [[UIColor colorWithHexString:@"5c73d4"] colorWithAlphaComponent:0.5f];
    checkbox.negativeColor = [[UIColor blackColor] colorWithAlphaComponent:0.5f];
    [self.view addSubview:checkbox];
    [checkbox mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(SYRealValue(30)) ;
        make.top.mas_equalTo(moto.mas_bottom).with.offset(SYRealValue(15));
        make.width.mas_equalTo(45) ;
        make.height.mas_equalTo(45) ;

    }];

    QMUILabel *label12 = [[QMUILabel alloc] init];
    label12.text = @"阅读相关协议";
    label12.font = UIFontMake(12);
    label12.textColor = UIColorBlack ;
    [label12 sizeToFit];
    [self.view addSubview:label12];
    [label12 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(checkbox.mas_right) ;
        make.top.mas_equalTo(checkbox.mas_top).with.offset(SYRealValue(18)) ;
    }];

    
    QMUILabel *label1 = [[QMUILabel alloc] init];
    label1.text = @"选择支付方式";
    label1.font = UIFontMake(12);
    label1.textColor = UIColorBlack ;
    [label1 sizeToFit];
    [self.view addSubview:label1];
    [label1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(SYRealValue(30)) ;
        make.top.mas_equalTo(checkbox.mas_bottom).with.offset(SYRealValue(10));
    }];
    
    UIImageView *bgImg2 = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"支付宝"]];
    [self.view addSubview:bgImg2];
    [bgImg2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(label1.mas_bottom).with.offset(SYRealValue(30/2));
        make.centerX.mas_equalTo(self.view);
        make.width.mas_equalTo(kScreen_Width - 100);
        make.height.mas_equalTo(60);
    }];

    UIImageView *bgImg3 = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"微信"]];
    [self.view addSubview:bgImg3];
    [bgImg3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(bgImg2.mas_bottom).with.offset(50/2);
        make.centerX.mas_equalTo(self.view);
        make.width.mas_equalTo(kScreen_Width - 100);
        make.height.mas_equalTo(60);
    }];

    
}


-(void)paperCheckboxChangedState:(BFPaperCheckbox *)ck{
    if (ck.isChecked) {
        self.hidesBottomBarWhenPushed=YES;
        ReadDetailContentViewController *read = [ReadDetailContentViewController new];
        read.type = @"1" ;
        [self.navigationController pushViewController:read animated:YES];
    } else {

    }
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
    [self.navigationController popToRootViewControllerAnimated:YES];
}
@end

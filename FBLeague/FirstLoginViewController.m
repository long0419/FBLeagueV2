//
//  FirstLoginViewController.m
//  FBLeague
//
//  Created by long-laptop on 2017/7/1.
//  Copyright © 2017年 long-laptop. All rights reserved.
//

#import "FirstLoginViewController.h"
#import "UserDataVo.h"
#import "MWLocalDataTool.h"
#import "LoginViewController.h"

@interface FirstLoginViewController (){
    UIImageView *bg ;
    QMUIButton *imagePositionButton1 ;
    QMUIButton *left ;
    QMUIButton *right ;

}

@end

@implementation FirstLoginViewController

- (void)didInitialized {
    [super didInitialized];
    // init 时做的事情请写在这里
}

-(void)viewDidLoad {
    bg = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"图层-1"]];
    [self.view addSubview:bg];
    
    imagePositionButton1 = [[QMUIButton alloc] init];
    imagePositionButton1.imagePosition = QMUIButtonImagePositionTop;// 将图片位置改为在文字上方
    imagePositionButton1.imageEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 0);
    [imagePositionButton1 setImage:UIImageMake(@"随便逛逛") forState:UIControlStateNormal];
    imagePositionButton1.titleLabel.font = UIFontMake(11);
//    imagePositionButton1.qmui_borderPosition = QMUIBorderViewPositionTop | QMUIBorderViewPositionRight | QMUIBorderViewPositionBottom;
    [self.view addSubview:imagePositionButton1];

    
    left = [[QMUIButton alloc] init];
    left.imagePosition = QMUIButtonImagePositionTop;// 将图片位置改为在文字上方
    left.imageEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 0);
    [left setImage:UIImageMake(@"登陆") forState:UIControlStateNormal];
    left.titleLabel.font = UIFontMake(11);
    [left addTarget:self action:@selector(loginAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:left];

    right = [[QMUIButton alloc] init];
    right.imagePosition = QMUIButtonImagePositionTop;// 将图片位置改为在文字上方
    right.imageEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 0);
    [right setImage:UIImageMake(@"注册") forState:UIControlStateNormal];
    right.titleLabel.font = UIFontMake(11);
    [right addTarget:self action:@selector(registerAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:right];
    
    [bg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self.view);
    }] ;
    
    [imagePositionButton1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(-16);
        make.top.mas_equalTo(76/2);
        make.width.mas_equalTo(SYRealValue(100));
        make.height.mas_equalTo(SYRealValue(35));
    }];
    
    [left mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(30);
        make.bottom.mas_equalTo(-82/2);
        make.height.mas_equalTo(SYRealValue(30));
        make.width.mas_equalTo(SYRealValue(105));
    }];
    
    [right mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(-30);
        make.bottom.mas_equalTo(-82/2);
        make.height.mas_equalTo(SYRealValue(30));
        make.width.mas_equalTo(SYRealValue(105));
    }] ;

    
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:NO];
    
    YYCache *cache = [YYCache cacheWithName:@"FB"];
    UserDataVo *vo = [cache objectForKey:@"userData"];
    
    if (vo) {
        [[NSNotificationCenter defaultCenter] postNotificationName:@"verifyLoginStatus" object:self];
    }
}

-(void) loginAction {
    LoginViewController *lvc = [[LoginViewController alloc] init];
    [self.navigationController pushViewController:lvc animated:YES];
}

-(void)registerAction{
    RegisterViewController *rvc = [[RegisterViewController alloc] init];
    rvc.from = @"1" ;
    [self.navigationController pushViewController:rvc animated:YES];
}

@end

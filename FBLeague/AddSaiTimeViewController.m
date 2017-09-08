//
//  AddSaiTimeViewController.m
//  FBLeague
//
//  Created by long-laptop on 2017/9/8.
//  Copyright © 2017年 long-laptop. All rights reserved.
//

#import "AddSaiTimeViewController.h"

@interface AddSaiTimeViewController (){
    DSLLoginTextField *psw ;
    DSLLoginTextField *area ;

}


@end

@implementation AddSaiTimeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"发布比赛时间";
    
    [self setBackBottmAndTitle2];
    
    QMUILabel *label3 = [[QMUILabel alloc] init];
    label3.text = @"比赛时间";
    label3.font = UIFontMake(12);
    label3.textColor = UIColorBlack ;
    [label3 sizeToFit];
    [self.view addSubview:label3];
    [label3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(30);
        make.top.mas_equalTo(20 + 44 + 20) ;
    }];

    psw=[[DSLLoginTextField alloc]init];
    psw.frame = CGRectMake(30 , label3.bottom + 10 , kScreen_Width - 60 , 40);
    psw.clearButtonMode=UITextFieldViewModeWhileEditing;
    psw.placeholderColor=[UIColor colorWithHexString:@"ffffff"];
    psw.textColor = [UIColor blackColor] ;
    psw.font=[UIFont systemFontOfSize:14];
    psw.placeholder=@"选择时间";
    psw.maxTextLength= 11;
    psw.delegate = self ;
    psw.tag = 10 ;
    psw.textAlignment = NSTextAlignmentCenter ;
    [self.view addSubview:psw];
    
    QMUILabel *label = [[QMUILabel alloc] init];
    label.text = @"比赛地点";
    label.font = UIFontMake(12);
    label.textColor = UIColorBlack ;
    [label sizeToFit];
    [self.view addSubview:label];
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(30);
        make.top.mas_equalTo(psw.mas_bottom).with.offset(20);
    }];

    
    area=[[DSLLoginTextField alloc]init];
    area.frame = CGRectMake(30 , label.bottom + 10 , kScreen_Width - 60 , 100);
    area.clearButtonMode=UITextFieldViewModeWhileEditing;
    area.placeholderColor=[UIColor colorWithHexString:@"000000"];
    area.textColor = [UIColor blackColor] ;
    area.font=[UIFont systemFontOfSize:14];
    area.placeholder=@"";
//    area.maxTextLength= 11;
    area.delegate = self ;
    area.tag = 12 ;
    area.textAlignment = NSTextAlignmentCenter ;
    [self.view addSubview:psw];

}


@end

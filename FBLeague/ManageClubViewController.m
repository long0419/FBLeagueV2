//
//  ManageClubViewController.m
//  FBLeague
//
//  Created by long-laptop on 2017/10/9.
//  Copyright © 2017年 long-laptop. All rights reserved.
//

#import "ManageClubViewController.h"

@interface ManageClubViewController ()

@end

@implementation ManageClubViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"俱乐部管理" ;
    self.view.backgroundColor = [UIColor colorWithHexString:@"f9f9f9"];
    [self setBackBottmAndTitle];
    
    [self initView];
}

-(void)initView{
    UIView *atme3 = [self getItemViewByPic:@"@" andWithName:@"俱乐部成员"];
    atme3.origin = CGPointMake(0, 20 + 44 + 10);
    atme3.tag = 13 ;
    UITapGestureRecognizer *tapGesturRecognizerx=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(atMe)];
    [atme3 addGestureRecognizer:tapGesturRecognizerx];
    [self.view addSubview:atme3];
    
    UIView *atme = [self getItemViewByPic:@"图层-3" andWithName:@"我的团队"];
    atme.origin = CGPointMake(0, atme3.bottom + 5);
    atme.tag = 11 ;
    UITapGestureRecognizer *tapGesturRecognizer=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapAction)];
    [atme addGestureRecognizer:tapGesturRecognizer];
//    [self.view addSubview:atme];
    
    UIView *atme2 = [self getItemViewByPic:@"图层-3" andWithName:@"申请审核"];
    atme2.origin = CGPointMake(0, atme3.bottom + 5);
    atme2.tag = 11 ;
    UITapGestureRecognizer *tapGesturRecognizer2=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapAction2)];
    [atme2 addGestureRecognizer:tapGesturRecognizer2];
    [self.view addSubview:atme2];

    UIView *atme4 = [self getItemViewByPic:@"图层-3" andWithName:@"取消俱乐部认证"];
    atme4.origin = CGPointMake(0, atme2.bottom + 5);
    atme4.tag = 11 ;
    UITapGestureRecognizer *tapGesturRecognizer21=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapAction2)];
    [atme4 addGestureRecognizer:tapGesturRecognizer21];
//    [self.view addSubview:atme4];

    UIView *atme5 = [self getItemViewByPic:@"图层-3" andWithName:@"注销俱乐部"];
    atme5.origin = CGPointMake(0, atme2.bottom + 5);
    atme5.tag = 11 ;
    UITapGestureRecognizer *tapGesturRecognizer22=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapAction2)];
    [atme5 addGestureRecognizer:tapGesturRecognizer22];
    [self.view addSubview:atme5];

}

-(void)setBackBottmAndTitle{
    UIButton *backViewBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    backViewBtn.frame = CGRectMake(0, 0, 22, 17);
    [backViewBtn setImage:[UIImage imageNamed:@"back2"] forState:UIControlStateNormal];
    [backViewBtn addTarget:self action: @selector(back)
          forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *backItem = [[UIBarButtonItem alloc] initWithCustomView:backViewBtn];
    self.navigationItem.leftBarButtonItem = backItem ;
}

-(void)back{
    [self.navigationController popViewControllerAnimated:YES];
}

-(UIView *)getItemViewByPic : (NSString *)pic andWithName : (NSString *)name {
    
    UIView *item = [[UIView alloc] init];
    item.size = CGSizeMake(kScreen_Width, 44);
    item.backgroundColor = [UIColor whiteColor];
    
    UIImageView *head = [UIImageView new];
    head.frame = CGRectMake(12, 30/2 , 37/2, 32/2) ;
    [item addSubview:head];
    
    QMUILabel *label1 = [[QMUILabel alloc] init];
    label1.text = name ;
    label1.font = UIFontMake(12);
    label1.textColor = UIColorBlack ;
    [label1 sizeToFit];
    [item addSubview:label1];
    [label1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(item);
        make.left.mas_equalTo(head.mas_left);
    }];
    
    UIView *line = [[UIView alloc] initWithFrame:CGRectMake(0, item.bottom , kScreen_Width, .5)];
    line.backgroundColor = [UIColor colorWithHexString:@"efefef"];
    [item addSubview:line];
    
    return item ;
}

-(void)atMe{
    
    self.hidesBottomBarWhenPushed=YES;
    ClassesViewController *mem = [ClassesViewController new];
    mem.type = @"2" ;
    [self.navigationController pushViewController:mem animated:YES];
    
}

-(void)tapAction{
    self.hidesBottomBarWhenPushed=YES;
    MemberClubViewController *mem = [MemberClubViewController new] ;
    [self.navigationController pushViewController:mem animated:YES];
}

-(void)tapAction2{
    self.hidesBottomBarWhenPushed=YES;
    ApplyListViewController *mem = [ApplyListViewController new] ;
    [self.navigationController pushViewController:mem animated:YES];
}



@end

//
//  MeViewController.m
//  league
//
//  Created by long-laptop on 2016/11/7.
//  Copyright © 2016年 long-laptop. All rights reserved.
//

#import "MeViewController.h"
#import "AppDelegate.h"
#import "MyDataImportViewController.h"
#import "MyQiuYuanViewController.h"
#import "AddZhanViewController.h"

@interface MeViewController (){
    UserDataVo *uvo ;
    YYCache *cache ;

}

@end

@implementation MeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"我" ;
    cache = [YYCache cacheWithName:@"FB"];
    uvo = [cache objectForKey:@"userData"];
    self.view.backgroundColor = [UIColor colorWithHexString:@"f9f9f9"                        ];
    
    UIView *header = [[UIView alloc] initWithFrame:CGRectMake(0, 40 + 22 + 23 , kScreen_Width,  220/2)];
    header.backgroundColor = [UIColor whiteColor];
    UITapGestureRecognizer *tapGesturRecognizer1=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(detail)];
    [header addGestureRecognizer:tapGesturRecognizer1];
    [self.view addSubview:header];
    
    UIImageView *head ;
    if (nil == uvo.headpicurl || [uvo.headpicurl isEqual:[NSNull null]]) {
        head = [[UIImageView alloc]
                initWithImage:[UIImage imageNamed:@"head"]];
    }else{
        head = [[UIImageView alloc] init];
        [head sd_setImageWithURL:[NSURL URLWithString:uvo.headpicurl] placeholderImage:nil];
    }
    head.frame = CGRectMake(30, (header.height - 70)/2 , 140/2, 140/2) ;
    head.layer.masksToBounds =YES;
    head.layer.cornerRadius = 10 ;
    [header addSubview:head];
    
    NSString *name = uvo.nickname ;
    CGSize nameSize = [NSString getStringContentSizeWithFontSize:34/2 andContent:name];
    UILabel *nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(head.right + 12 , head.top , nameSize.width, nameSize.height)];
    nameLabel.font = [UIFont systemFontOfSize:30/2];
    nameLabel.textColor = [UIColor colorWithHexString:@"000"];
    nameLabel.text = name ;
    [header addSubview:nameLabel];
    
    UILabel *titleLabel = [UILabel new];
    titleLabel.font = [UIFont systemFontOfSize:10];
    titleLabel.numberOfLines = 0;//多行显示，计算高度
    titleLabel.textColor = [UIColor colorWithHexString:@"000"];
    //    NSString *desc =  [CommonFunc textFromBase64String:vo.desc];
    NSString *desc = uvo.areacode ;
    CGSize titleSize = [NSString getMultiStringContentSizeWithFontSize:10 andContent:desc];
    titleLabel.size = titleSize;
    titleLabel.text = desc ;
    titleLabel.x = nameLabel.left ;
    titleLabel.y = nameLabel.bottom + 5 ;
    [header addSubview:titleLabel];
    
    UILabel *titleLabel2 = [UILabel new];
    titleLabel2.font = [UIFont systemFontOfSize:10];
    titleLabel2.numberOfLines = 0;//多行显示，计算高度
    titleLabel2.textColor = [UIColor colorWithHexString:@"000"];
    NSString *desc2 = @"联盟认证号：暂无" ;
    CGSize titleSize2 = [NSString getMultiStringContentSizeWithFontSize:10 andContent:desc2];
    titleLabel2.size = titleSize2;
    titleLabel2.text = desc2 ;
    titleLabel2.x = nameLabel.left ;
    titleLabel2.y = titleLabel.bottom + 5 ;
    [header addSubview:titleLabel2];
    
    UIImageView *next = [[UIImageView alloc]
                         initWithImage:[UIImage imageNamed:@"下一步"]];
    next.frame = CGRectMake(kScreen_Width - 30, (header.height - 20)/2 , 20/2, 40/2) ;
    
    UIView *atme ;
    UIView *atme2 ;
    atme = [self getItemViewByPic:@"图层-3" andWithName:@"我的数据"];
    atme.origin = CGPointMake(0, header.bottom + 20);
    atme.tag = 11 ;
    UITapGestureRecognizer *tapGesturRecognizer=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapAction)];
    [atme addGestureRecognizer:tapGesturRecognizer];
    [self.view addSubview:atme];

    if([uvo.role isEqualToString: @"1"]){
        atme2 = [self getItemViewByPic:@"图层-3" andWithName:@"球员数据"];
        atme2.origin = CGPointMake(0, atme.bottom + .5);
        atme2.tag = 22 ;
        UITapGestureRecognizer *tapGesturRecognizer=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapAction2)];
        [atme2 addGestureRecognizer:tapGesturRecognizer];
        [self.view addSubview:atme2];
    }
    
    UIButton *exit = [[UIButton alloc] initWithFrame:CGRectMake(kScreen_Width - 60 - 1 , header.top + 5  , 60 + 12 , 24)];
    [exit setTitle: @"退出登录" forState: UIControlStateNormal];
    exit.titleLabel.font = [UIFont systemFontOfSize: 11.0];
    exit.titleLabel.textColor = [UIColor whiteColor];
    exit.layer.cornerRadius = 12 ;
    [exit addTarget:self action:@selector(exit) forControlEvents:UIControlEventTouchUpInside];
    [exit setBackgroundColor:[UIColor colorWithHexString:@"111111" andAlpha:.5]];
    [self.view addSubview:exit];
    
}

-(void)detail{
    self.hidesBottomBarWhenPushed=YES;
    AddZhanViewController *add = [AddZhanViewController new] ;
    [self.navigationController pushViewController:add animated:YES];
    self.hidesBottomBarWhenPushed=NO ;
}

-(void)tapAction{
    self.hidesBottomBarWhenPushed=YES;
    MyDataImportViewController *my = [[MyDataImportViewController alloc] init];
    my.phone = uvo.phone ;
    my.coachPhone = uvo.phone ;
    [self.navigationController pushViewController:my animated:YES];
    self.hidesBottomBarWhenPushed=NO;
}

-(void)tapAction2{
    self.hidesBottomBarWhenPushed=YES;
    MyQiuYuanViewController *qiuyuan = [MyQiuYuanViewController new];
    [self.navigationController pushViewController:qiuyuan animated:YES];
    self.hidesBottomBarWhenPushed=NO;

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
    
//    SaiResultViewController *member = [SaiResultViewController new] ;
//    [self.navigationController pushViewController:member animated:YES];
    
}


-(UIView *)getItemViewByPic : (NSString *)pic andWithName : (NSString *)name {
    UIView *item = [[UIView alloc] init];
    item.size = CGSizeMake(kScreen_Width, 44);
    item.backgroundColor = [UIColor whiteColor];
    
    UIImageView *head = [[UIImageView alloc]
                initWithImage:[UIImage imageNamed:pic]];
    head.frame = CGRectMake(30, 30/2 , 40/2, 30/2) ;
    [item addSubview:head];
    
    QMUILabel *label1 = [[QMUILabel alloc] init];
    label1.text = name ;
    label1.font = UIFontMake(12);
    label1.textColor = UIColorBlack ;
    [label1 sizeToFit];
    [item addSubview:label1];
    [label1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(item);
        make.left.mas_equalTo(head.mas_right).with.offset(36/2);
    }];

    UIImageView *next = [[UIImageView alloc]
                         initWithImage:[UIImage imageNamed:@"下一步"]];
    next.frame = CGRectMake(kScreen_Width - 30, 26/2 , 20/2, 40/2) ;
    [item addSubview:next];
    
    UIView *badge = [UIView new] ;
    badge.frame = CGRectMake(label1.right + 80 , 26/2 , 20/2, 40/2) ;
    [item addSubview:badge];
    [badge showBadgeWithStyle:WBadgeStyleNew value:1 animationType:WBadgeAnimTypeShake];

    UIView *line = [[UIView alloc] initWithFrame:CGRectMake(0, item.bottom , kScreen_Width, .5)];
    line.backgroundColor = [UIColor colorWithHexString:@"efefef"];
    [item addSubview:line];
    
    return item ;
}

@end

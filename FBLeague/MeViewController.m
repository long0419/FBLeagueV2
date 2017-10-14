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
#import "DongtaiViewController.h"
#import "UpdateUserInfoViewController.h"

@interface MeViewController (){
    UserDataVo *uvo ;
    YYCache *cache ;
    UIView *badge ;
    NSString *desc ;
    UILabel *titleLabel ;
    UILabel *titleLabel2 ;
}

@end

@implementation MeViewController

-(void)viewWillAppear:(BOOL)animated{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(showNew:) name:@"shownew" object:nil];
    
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self getRedPotData];

    [self getPersonInfo] ;
    
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
    
    titleLabel = [UILabel new];
    titleLabel.font = [UIFont systemFontOfSize:10];
    titleLabel.numberOfLines = 0;//多行显示，计算高度
    titleLabel.textColor = [UIColor colorWithHexString:@"000"];
    desc = [NSString stringWithFormat:@"%@ %@" , uvo.areaname , uvo.cityName] ;
    CGSize titleSize = [NSString getMultiStringContentSizeWithFontSize:10 andContent:desc];
    titleLabel.size = titleSize;
    titleLabel.text = desc ;
    titleLabel.x = nameLabel.left ;
    titleLabel.y = nameLabel.bottom + 5 ;
    [header addSubview:titleLabel];
    
    titleLabel2 = [UILabel new];
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
    UIView *atme3 ;
    UIView *atme4 ;

    atme3 = [self getItemViewByPic:@"@" andWithName:@"@我的"];
    atme3.origin = CGPointMake(0, header.bottom + 20);
    atme3.tag = 13 ;
    UITapGestureRecognizer *tapGesturRecognizerx=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(atMe)];
    [atme3 addGestureRecognizer:tapGesturRecognizerx];
    [self.view addSubview:atme3];

    atme = [self getItemViewByPic:@"图层-3" andWithName:@"我的数据"];
    atme.origin = CGPointMake(0, atme3.bottom + 5);
    atme.tag = 11 ;
    UITapGestureRecognizer *tapGesturRecognizer=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapAction)];
    [atme addGestureRecognizer:tapGesturRecognizer];
    [self.view addSubview:atme];
    

    if([uvo.role isEqualToString: @"1"]){
        atme2 = [self getItemViewByPic:@"加油" andWithName:@"球员数据"];
        atme2.origin = CGPointMake(0, atme.bottom + 5);
        atme2.tag = 22 ;
        UITapGestureRecognizer *tapGesturRecognizer=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapAction2)];
        [atme2 addGestureRecognizer:tapGesturRecognizer];
        [self.view addSubview:atme2];
        
        if(![uvo.club isEqualToString:@""] || uvo.club != nil){
            atme4 = [self getItemViewByPic:@"管理" andWithName:@"俱乐部管理"];
            atme4.origin = CGPointMake(0, atme2.bottom + 5);
            atme4.tag = 24 ;
            UITapGestureRecognizer *julebuorg=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(orgi)];
            [atme4 addGestureRecognizer:julebuorg];
            [self.view addSubview:atme4];
        }
    }
    
    UIButton *exit = [[UIButton alloc] initWithFrame:CGRectMake(kScreen_Width - 60 - 1 , header.top + 5  , 60 + 12 , 24)];
    [exit setTitle: @"退出登录" forState: UIControlStateNormal];
    exit.titleLabel.font = [UIFont systemFontOfSize: 11.0];
    exit.titleLabel.textColor = [UIColor whiteColor];
    exit.layer.cornerRadius = 12 ;
    [exit addTarget:self action:@selector(exit) forControlEvents:UIControlEventTouchUpInside];
    [exit setBackgroundColor:[UIColor colorWithHexString:@"111111" andAlpha:.5]];
//    [self.view addSubview:exit]   ;
    
}

-(void)getPersonInfo{
    cache = [YYCache cacheWithName:@"FB"];
    uvo = [cache objectForKey:@"userData"];
    
    NSDictionary *params = [NSDictionary dictionaryWithObjectsAndKeys:uvo.phone , @"phone" , uvo.phone ,  @"token", nil];
    [PPNetworkHelper POST:getCBDetail parameters:params success:^(id object) {
        if([object[@"code"] isEqualToString:@"0000"]){
            titleLabel.text = [NSString stringWithFormat:@"%@ %@" , object[@"user"][@"cityname"] , object[@"user"][@"areaname"] ] ;
            CGSize titleSize = [NSString getMultiStringContentSizeWithFontSize:10 andContent:titleLabel.text];
            titleLabel.size = titleSize;

            NSString *desc =  @"联盟认证号：暂无" ;
            titleLabel2.text = desc ;
            if ([object[@"user"][@"certification"] isEqualToString:@"<null>"]) {
                titleLabel2.text = [NSString stringWithFormat:@"%@" , object[@"user"][@"certification"]];
            }

        }
    } failure:^(NSError *error) {
        
    }];

}

-(void)orgi{
    self.hidesBottomBarWhenPushed=YES;
    ManageClubViewController *manage = [ManageClubViewController new];
    [self.navigationController pushViewController:manage animated:YES];
    self.hidesBottomBarWhenPushed=NO;
}

-(void)getRedPotData{
    cache = [YYCache cacheWithName:@"FB"];
    uvo = [cache objectForKey:@"userData"];
    
    NSDictionary *params = [NSDictionary dictionaryWithObjectsAndKeys:uvo.phone , @"phone" , uvo.phone ,  @"token", nil];
    [PPNetworkHelper POST:getUnreadCount parameters:params success:^(id object) {
        if([object[@"code"] isEqualToString:@"0000"]){
            
            NSString *likeCount = object[@"unreadCount"][@"likeCount"];
            NSString *followCount = object[@"unreadCount"][@"followCount"];
            NSString *atCount = object[@"unreadCount"][@"atCount"];
            
            NSInteger total = likeCount.integerValue + followCount.integerValue + atCount.integerValue ;
            
            NSDictionary *dict =[[NSDictionary alloc]initWithObjectsAndKeys:[NSString stringWithFormat:@"%ld" , total] ,@"textOne",nil];
            
            if (total > 0) {
                [[NSNotificationCenter defaultCenter]
                 postNotificationName:@"shownew" object:nil userInfo:nil]  ;
                
            }
        }
    } failure:^(NSError *error) {
        
    }];
    
}

-(void)atMe{
    [badge clearBadge];
    
    [[NSNotificationCenter defaultCenter]
     postNotificationName:@"removespot" object:nil userInfo:nil]  ;
    
    self.hidesBottomBarWhenPushed=YES ;
    DongtaiViewController *add = [DongtaiViewController new] ;
    add.type = @"1" ;
    [self.navigationController pushViewController:add animated:YES];
    self.hidesBottomBarWhenPushed=NO ;
}

-(void)detail{
    self.hidesBottomBarWhenPushed=YES;
    UpdateUserInfoViewController *add = [UpdateUserInfoViewController new] ;
//    AddZhanViewController *add = [AddZhanViewController new] ;
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
}


-(UIView *)getItemViewByPic : (NSString *)pic andWithName : (NSString *)name {
    
    UIView *item = [[UIView alloc] init];
    item.size = CGSizeMake(kScreen_Width, 44);
    item.backgroundColor = [UIColor whiteColor];
    
    UIImageView *head = [[UIImageView alloc]
                initWithImage:[UIImage imageNamed:pic]];
    head.frame = CGRectMake(30, 30/2 , 37/2, 32/2) ;
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
    
    if ([name isEqualToString:@"@我的"]) {
        badge = [UIView new] ;
        badge.frame = CGRectMake(label1.right + 70 , 26/2 , 20/2, 40/2) ;
        [item addSubview:badge];
    }
    
    UIView *line = [[UIView alloc] initWithFrame:CGRectMake(0, item.bottom , kScreen_Width, .5)];
    line.backgroundColor = [UIColor colorWithHexString:@"efefef"];
    [item addSubview:line];
    
    return item ;
}

-(void)showNew:(NSNotification *)notification{
    [badge showBadgeWithStyle:WBadgeStyleNew value:1 animationType:WBadgeAnimTypeShake];
}



@end

//
//  MyQiuYuanViewController.m
//  FBLeague
//
//  Created by long-laptop on 2017/1/3.
//  Copyright © 2017年 long-laptop. All rights reserved.
//

#import "MyQiuYuanViewController.h"
#import "UserDataVo.h"
#import "CoachVo.h"
#import "CoachChooseTableViewCell.h"
#import "ChineseString.h"
#import "UserDataVo.h"

@interface MyQiuYuanViewController (){
    NSString *pageNO ;
    NSMutableArray *coachList ;
    UserDataVo *uvo ;
    NSString *clubId ;

}

@end

@implementation MyQiuYuanViewController

-(void)viewWillAppear:(BOOL)animated{
    [self hideTabBottom];
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"球员列表" ;
    YYCache *cache = [YYCache cacheWithName:@"FB"];
    uvo = [cache objectForKey:@"userData"];

    [self setBackBottmAndTitle];
    
    [self setRightBottom];
    
    coachList = [[NSMutableArray alloc] init] ;
    
    _coachTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kScreen_Width, kScreen_Height)];
    _coachTableView.delegate = self ;
    _coachTableView.dataSource = self;
    _coachTableView.backgroundColor = [UIColor colorWithHexString:@"f6f6f6"];
    _coachTableView.separatorStyle = NO ;
    [self.view addSubview:_coachTableView];
    
    [self getUserInfo];

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

-(void)getUserInfo{
    
    NSDictionary *params = [NSDictionary dictionaryWithObjectsAndKeys: uvo.phone ,  @"phone" , uvo.phone , @"token" , nil];
    [PPNetworkHelper POST:getCBDetail parameters:params success:^(id data) {
        if([data[@"code"] isEqualToString:@"0000"]){
            NSString *cid = data[@"user"][@"club"] ;
            [self getCoachDatas:cid];
        }else {
            [SVProgressHUD showErrorWithStatus: @"系统错误"];
            [SVProgressHUD setDefaultStyle:SVProgressHUDStyleDark];
        }
        
    } failure:^(NSError *error) {
        
    }];
}

- (void)setRightBottom {
    UIButton *backViewBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    backViewBtn.frame = CGRectMake(0, 0, 23, 23);
    [backViewBtn setImage:[UIImage imageNamed:@"ring"] forState:UIControlStateNormal];
    [backViewBtn addTarget:self action: @selector(goAction)
          forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *backItem = [[UIBarButtonItem alloc] initWithCustomView:backViewBtn];
    self.navigationItem.rightBarButtonItem = backItem ;
}

-(void)goAction{
    //ApplyListViewController *recheck = [ApplyListViewController new];
    //[self.navigationController pushViewController:recheck animated:YES];
}

-(void)getCoachDatas : (NSString *) clubid {
    NSDictionary *params = [NSDictionary dictionaryWithObjectsAndKeys: clubid ,  @"id" , uvo.phone , @"token" , nil];
    [PPNetworkHelper POST:getUsersByClubId parameters:params success:^(id data) {
        if([data[@"code"] isEqualToString:@"0000"]){
                NSDictionary *list = data[@"users"];
                UserDataVo *vo = nil ;
                [coachList removeAllObjects];
            
                if (![list isEqual:[NSNull null]]) {
                    for (NSDictionary *dic in list) {
                        vo = [UserDataVo new];
                        vo.areacode = [NSString stringWithFormat:@"%@" , dic[@"areacode"]] ;
                        vo.brithday = [NSString stringWithFormat:@"%@" ,dic[@"brithday"]] ;
                        vo.citycode = [NSString stringWithFormat:@"%@" ,dic[@"citycode"]] ;
                        vo.club = [NSString stringWithFormat:@"%@" ,dic[@"club"]]  ;
                        vo.desc = [NSString stringWithFormat:@"%@" ,dic[@"description"]]  ;
                        vo.firstletter =  [NSString stringWithFormat:@"%@" ,dic[@"firstletter"]]  ;
                        vo.headpicurl =  [NSString stringWithFormat:@"%@" ,dic[@"headpicurl"]]  ;
                        vo.firstletter =  [NSString stringWithFormat:@"%@" ,dic[@"firstletter"]]  ;
                        vo.level =  [NSString stringWithFormat:@"%@" ,dic[@"level"]]  ;
                        vo.nickname = dic[@"nickname"]  ;
                        vo.openid = dic[@"openid"]  ;
                        vo.phone = dic[@"phone"]  ;
                        vo.position = dic[@"position"]  ;
                        vo.provincecode = dic[@"provincecode"]  ;
                        vo.pwd = dic[@"pwd"]  ;
                        vo.realname = dic[@"realname"]  ;
                        vo.registrationid = dic[@"registrationid"]  ;
                        vo.regtime = dic[@"regtime"]  ;
                        vo.role = dic[@"role"]  ;
                        vo.pass = dic[@"pass"];
                        vo.strength = dic[@"strength"];
                        vo.speed = dic[@"speed"];
                        vo.withstand = dic[@"withstand"];
                        vo.defend = dic[@"defend"];
                        vo.dribbling = dic[@"dribbling"];
                        vo.skill = dic[@"skill"];
                        vo.control = dic[@"control"];
                        vo.counterattack = dic[@"counterattack"];
                        vo.stronghand = dic[@"strongHand"];
                        vo.compete = dic[@"compete"];
                        vo.stimulate = dic[@"stimulate"];
                        if (![dic[@"role"] isEqualToString:@"1"]) {
                            [coachList addObject:vo];
                        }
                    }
                    [_coachTableView reloadData];
                }
            }else {
                [SVProgressHUD showErrorWithStatus: @"系统错误"];
                [SVProgressHUD setDefaultStyle:SVProgressHUDStyleDark];

        }
    } failure:^(NSError *error) {
        
    }];
}

#pragma mark 返回分组数
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return [coachList count] ;
}

#pragma mark 返回每组行数
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1 ;
}

#pragma mark返回每行的单元格
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *Categorys = @"Categorys";
    
    CoachChooseTableViewCell *cell = [[CoachChooseTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:Categorys];
    if (coachList.count > 0){
        UserDataVo *vo = [coachList objectAtIndex:indexPath.section];
        
        [cell setPhoneContactCellByImageName:vo.headpicurl andWithName:vo.nickname andWithPhoneNum:vo.phone andWithindex:indexPath.section andWithRole:vo.role andPosition:vo.position];
        
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone ;
    return cell ;
    
}

#pragma mark - 代理方法
#pragma mark 重新设置单元格高度
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 70  ;
}

#pragma mark 点击行
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    
    UserDataVo *vo = [coachList objectAtIndex:indexPath.section];
    
    self.hidesBottomBarWhenPushed=YES;

    if ([vo.role isEqualToString:@"1"]) {
        MyJiaoLianDataViewController *my = [MyJiaoLianDataViewController new];
        my.vo = vo ;
        [self.navigationController pushViewController:my animated:YES];

    }else{
        MyQiuYuanDataImportViewController *my = [MyQiuYuanDataImportViewController new] ;
        my.vo = vo ;
        [self.navigationController pushViewController:my animated:YES];

    }
    
    self.hidesBottomBarWhenPushed=NO;

}

@end

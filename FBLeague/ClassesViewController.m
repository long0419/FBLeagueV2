//
//  ClassesViewController.m
//  FBLeague
//
//  Created by long-laptop on 2017/7/24.
//  Copyright © 2017年 long-laptop. All rights reserved.
//

#import "ClassesViewController.h"
#import "SVPullToRefresh.h"
#import "CoachVo.h"
#import "MemberViewController.h"

@interface ClassesViewController (){
    NSMutableArray *kouList ;
    YYCache *cache ;
    UserDataVo *uvo ;
    NSString *pageNO ;

}

@end

@implementation ClassesViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    cache = [YYCache cacheWithName:@"FB"];
    uvo = [cache objectForKey:@"userData"];
    kouList= [NSMutableArray new] ;
    
    [self getNeedDatas : @"1"];
    pageNO = @"1" ;
    
    if ([_type isEqualToString:@"2"]) {
        [self setBackBottmAndTitle];
        self.title =@"俱乐部成员" ;
    }
    
    self.soTableView = [[UITableView alloc] initWithFrame:CGRectMake(0,  0 , kScreen_Width, kScreen_Height)];
    _soTableView.delegate = self ;
    _soTableView.dataSource = self;
    _soTableView.backgroundColor = [UIColor clearColor];
    _soTableView.separatorStyle = NO ;
    [self.view addSubview:_soTableView];
    
    __weak ClassesViewController *weakSelf = self ;
    [_soTableView addPullToRefreshWithActionHandler:^{
        [weakSelf getNeedDatas : @"1"];
        [weakSelf.soTableView.pullToRefreshView stopAnimating];
    }];
    
    __weak NSString *no = pageNO ;
    [_soTableView addInfiniteScrollingWithActionHandler:^{
        [weakSelf getNeedDatas : [NSString stringWithFormat:@"%@", no]];
        [weakSelf.soTableView.infiniteScrollingView stopAnimating];
    }];
    
    [_soTableView.pullToRefreshView setTitle:@"下拉刷新..." forState:SVPullToRefreshStateStopped];
    [_soTableView.pullToRefreshView setTitle:@"释放更新..." forState:SVPullToRefreshStateTriggered];
    [_soTableView.pullToRefreshView setTitle:@"加载中..." forState:SVPullToRefreshStateLoading];
    
}



-(void)getNeedDatas :(NSString *) page{
    
    NSDictionary *params = [NSDictionary dictionaryWithObjectsAndKeys:uvo.club , @"id" , uvo.phone , @"token" , nil];
    [PPNetworkHelper POST:getUsersByClubId parameters:params success:^(id object) {
        
        if([object[@"code"] isEqualToString:@"0000"]){
            NSDictionary *list = object[@"users"];
            NSString *clubName = object[@"clubName"] ;
            UserDataVo *vo = nil ;
            [kouList removeAllObjects];
            
            if (![list isEqual:[NSNull null]]) {
                for (NSDictionary *dic in list) {
                    vo = [UserDataVo new];
                    vo.areacode = [NSString stringWithFormat:@"%@" , dic[@"areacode"]] ;
                    vo.clubName = [CommonFunc textFromBase64String:clubName] ;
                    vo.brithday = [NSString stringWithFormat:@"%@" ,dic[@"brithday"]] ;
                    vo.citycode = [NSString stringWithFormat:@"%@" ,dic[@"citycode"]] ;
                    vo.cityName = [NSString stringWithFormat:@"%@" ,dic[@"cityname"]] ;
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
                    vo.areaname = dic[@"areaname"] ;
                    vo.sex = dic[@"sex"] ;
                    vo.team = dic[@"team"] ;
                    vo.openidbyqq = dic[@"openidbyqq"] ;
                    vo.openidbywx = dic[@"openidbywx"] ;
                    vo.certification = dic[@"certification"] ;
                    vo.fansCount = dic[@"fansCount"] ;
                    [kouList addObject:vo];
                }
            }
            [_soTableView reloadData];
        }
        
    } failure:^(NSError *error) {
        
    }];
}

#pragma mark 返回分组数
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return [kouList count] ;
}


#pragma mark 返回每组行数
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1 ;
}

#pragma mark返回每行的单元格
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *Categorys = @"Categorys";
    
    CoachChooseTableViewCell *cell = [[CoachChooseTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:Categorys];
    if (kouList.count > 0){
        UserDataVo *vo = [kouList objectAtIndex:indexPath.section];
        [cell setPhoneContactCellByImageName:vo.headpicurl andWithName:vo.nickname andWithPhoneNum:vo.phone andWithindex:indexPath.section andWithRole:vo.role andPosition:vo.position];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone ;
    return cell ;
}

#pragma mark - 代理方法
#pragma mark 重新设置单元格高度
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 70 ;
}

#pragma mark 点击行
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    
    UserDataVo *vo = [kouList objectAtIndex:indexPath.section];
    
    [[NSNotificationCenter defaultCenter] postNotification:[NSNotification notificationWithName:@"forwardDetail" object:vo userInfo:nil]];

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


@end

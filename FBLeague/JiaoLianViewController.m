//
//  JiaoLianViewController.m
//  FBLeague
//
//  Created by long-laptop on 2016/12/10.
//  Copyright © 2016年 long-laptop. All rights reserved.
//

#import "JiaoLianViewController.h"
#import "CoachVo.h"
#import "CoachChooseTableViewCell.h"
#import "ChineseString.h"
#import "pinyin.h"
#import "SVPullToRefresh.h"
#import "CommonFunc.h"

@interface JiaoLianViewController (){
    NSString *pageNO ;
    NSMutableArray *coachList ;
}

@end

@implementation JiaoLianViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    [self getCoachDatas:@"1"];
    
    pageNO = @"1" ;
    
    coachList = [[NSMutableArray alloc] init] ;
    _coachTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kScreen_Width, kScreen_Height - 20 - 44 - 50)];
    _coachTableView.delegate = self ;
    _coachTableView.dataSource = self;
    _coachTableView.backgroundColor = [UIColor colorWithHexString:@"ffffff"];
    _coachTableView.separatorStyle = NO ;
    [self.view addSubview:_coachTableView];
    
    
    __weak JiaoLianViewController *weakSelf = self ;
    [_coachTableView addPullToRefreshWithActionHandler:^{
        [weakSelf getCoachDatas : @"1"];
        [weakSelf.coachTableView.pullToRefreshView stopAnimating];
    }];
    
    __weak NSString *no = pageNO ;
    [_coachTableView addInfiniteScrollingWithActionHandler:^{
        [weakSelf getCoachDatas : [NSString stringWithFormat:@"%@", no]];
        [weakSelf.coachTableView.infiniteScrollingView stopAnimating];
    }];
    
    [_coachTableView.pullToRefreshView setTitle:@"下拉刷新..." forState:SVPullToRefreshStateStopped];
    [_coachTableView.pullToRefreshView setTitle:@"释放更新..." forState:SVPullToRefreshStateTriggered];
    [_coachTableView.pullToRefreshView setTitle:@"加载中..." forState:SVPullToRefreshStateLoading];
    

}

-(void)getCoachDatas : (NSString *) page {
    YYCache *cache = [YYCache cacheWithName:@"FB"];
    UserDataVo *uvo = [cache objectForKey:@"userData"];
    
    self.HUD = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    
    NSDictionary *params = [NSDictionary dictionaryWithObjectsAndKeys:page , @"page" , uvo.phone , @"phone"  , uvo.phone , @"token" , nil];
    
    [PPNetworkHelper POST:getCoaches parameters:params success:^(id object) {
        
        if([object[@"code"] isEqualToString:@"0000"]){
            NSDictionary *list = object[@"page"][@"list"];
            UserDataVo *model = nil ;
            [coachList removeAllObjects];
            
            if (![list isEqual:[NSNull null]]) {
                for (NSDictionary *dic in list) {
                    model = [UserDataVo new];
                    model.registrationid =  [NSString stringWithFormat:@"%@" ,dic[@"registrationid"]]  ;
                    model.areacode =  [NSString stringWithFormat:@"%@" ,dic[@"areacode"]]  ;
                    model.cityName =  [NSString stringWithFormat:@"%@" ,dic[@"cityname"]]  ;
                    model.position =  [NSString stringWithFormat:@"%@" ,dic[@"position"]]  ;
                    model.regtime =  [NSString stringWithFormat:@"%@" ,dic[@"regtime"]]  ;
                    model.team =  [NSString stringWithFormat:@"%@" ,dic[@"team"]]  ;
                    model.areaname =  [NSString stringWithFormat:@"%@" ,dic[@"areaname"]]  ;
                    model.nickname =  [NSString stringWithFormat:@"%@" ,dic[@"nickname"]]  ;
                    model.sex =  [NSString stringWithFormat:@"%@" ,dic[@"sex"]]  ;
                    model.fansCount =  [NSString stringWithFormat:@"%@" ,dic[@"fansCount"]]  ;
                    model.hasfocus =  [NSString stringWithFormat:@"%@" ,dic[@"hasfocus"]]  ;
                    model.realname =  [NSString stringWithFormat:@"%@" ,dic[@"realname"]]  ;
                    model.openidbyqq =  [NSString stringWithFormat:@"%@" ,dic[@"openidbyqq"]]  ;
                    model.openidbywx =  [NSString stringWithFormat:@"%@" ,dic[@"openidbywx"]]  ;
                    model.firstletter =  [NSString stringWithFormat:@"%@" ,dic[@"firstletter"]]  ;
                    model.level =  [NSString stringWithFormat:@"%@" ,dic[@"level"]]  ;
                    model.phone =  [NSString stringWithFormat:@"%@" ,dic[@"phone"]]  ;
                    model.headpicurl =  [NSString stringWithFormat:@"%@" ,dic[@"headpicurl"]]  ;
                    model.provincecode =  [NSString stringWithFormat:@"%@" ,dic[@"provincecode"]]  ;
                    model.role =  [NSString stringWithFormat:@"%@" ,dic[@"role"]]  ;
                    model.citycode =  [NSString stringWithFormat:@"%@" ,dic[@"citycode"]]  ;
                    model.club =  [NSString stringWithFormat:@"%@" ,dic[@"club"]]  ;
                    model.brithday =  [NSString stringWithFormat:@"%@" ,dic[@"brithday"]]  ;
                    model.certification =  [NSString stringWithFormat:@"%@" ,dic[@"certification"]]  ;
                    model.desc =  [NSString stringWithFormat:@"%@" ,dic[@"description"]]  ;

                    [coachList addObject:model];
                }
                
                [_coachTableView reloadData];
            }
        }else {
            self.HUD.mode = MBProgressHUDModeText;
            self.HUD.removeFromSuperViewOnHide = YES;
            self.HUD.labelText = @"系统错误";
            [self.HUD hide:YES afterDelay:3];
        }

    } failure:^(NSError *error) {
        
    }];

    [self closeProgressView];
}


-(void)processCoachData{
    
    NSMutableArray *tmp = [[NSMutableArray alloc] init];
    for (UserDataVo *vo in coachList) {
        [tmp addObject:[NSString stringWithFormat:@"%@" , vo.nickname]];
    }
    
    self.indexArray = [ChineseString IndexArray:tmp];

    NSLog(@"%@" , self.indexArray);
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

        [cell setPhoneContactCellByImageName:vo.headpicurl andWithName:vo.nickname andWithPhoneNum:[NSString stringWithFormat:@"%@ %@" , vo.areaname , vo.cityName] andWithChoose:vo.hasfocus andWithindex:indexPath.section];
        
        cell.delegate =  self ;
        
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone ;
    return cell ;
    
}

-(void) focusContact :(UIView *) view {
    YYCache *cache = [YYCache cacheWithName:@"FB"];
    UserDataVo *uvo = [cache objectForKey:@"userData"];
    
    CoachVo *vo = [coachList objectAtIndex:view.tag];
    NSDictionary *params = [NSDictionary dictionaryWithObjectsAndKeys: uvo.phone , @"fanphone" , vo.phone , @"famousphone" , @"1", @"famoustype", uvo.phone , @"token" , nil];
    
    [PPNetworkHelper POST:focusPerson parameters:params success:^(id object) {
        if([object[@"code"] isEqualToString:@"0000"]){
            view.backgroundColor = [UIColor colorWithHexString:@"000000"];
            
            UILabel *focusLabel = [view viewWithTag:12];
            focusLabel.font = [UIFont systemFontOfSize:14];
            focusLabel.textColor = [UIColor whiteColor];
            focusLabel.text = @"已关注" ;
            view.userInteractionEnabled = NO ;
            
            [SVProgressHUD showSuccessWithStatus:@"关注成功"];
            [SVProgressHUD setDefaultStyle:SVProgressHUDStyleDark];
            
        }else {
            [SVProgressHUD showSuccessWithStatus:@"系统错误"];
            [SVProgressHUD setDefaultStyle:SVProgressHUDStyleDark];
        }
    } failure:^(NSError *error) {
        
    }];
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

    MemberViewController *mem = [MemberViewController new] ;
    mem.userVo = vo ;
    [self.navigationController pushViewController:mem animated:YES];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 20 ;
}


@end

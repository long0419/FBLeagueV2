//
//  JulebuViewController.m
//  league
//
//  Created by long-laptop on 2016/11/7.
//  Copyright © 2016年 long-laptop. All rights reserved.
//

#import "JulebuViewController.h"
#import "CoachVo.h"
#import "SVPullToRefresh.h"
#import "SaiListViewController.h"
#import "ClubDetailViewController.h"
#import "CommonFunc.h"

@interface JulebuViewController (){
    NSMutableArray *kouList ;
    YYCache *cache ;
    UserDataVo *uvo ;
    NSString *pageNO ;

}

@end

@implementation JulebuViewController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];

    self.tabBarController.tabBar.hidden = YES ;
    if (self.view.subviews.count != nil && self.view.subviews.count > 1) {
        for(int i = 0;i  < [self.view.subviews count];i++){
            [[self.view.subviews objectAtIndex:i] removeFromSuperview];
        }
    }
    
    kouList = [[NSMutableArray alloc] init];

    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(forward:) name:@"forwardDetail" object:nil];
    
    self.title = @"俱乐部" ;
    cache = [YYCache cacheWithName:@"FB"];
    uvo = [cache objectForKey:@"userData"];
    
    if(![uvo.club isEqual:[NSNull null]] && ![uvo.club isEqualToString:@""]){
        NSDictionary *params = [NSDictionary dictionaryWithObjectsAndKeys: uvo.club , @"id" ,uvo.phone ,  @"token", nil];
        [PPNetworkHelper POST:clubDetail parameters:params success:^(id object) {
            if([object[@"code"] isEqualToString:@"0000"]){
                ClubOBJ *clubVo = [ClubOBJ new] ;
                clubVo.desc = object[@"club"][@"description"] ;
                clubVo.areacode = object[@"club"][@"areacode"] ;
                clubVo.logourl = object[@"club"][@"logourl"] ;
                clubVo.cityname = object[@"club"][@"cityname"] ;
                clubVo.creator = object[@"club"][@"creator"] ;
                clubVo.areaname = object[@"club"][@"areaname"] ;
                clubVo.name = object[@"club"][@"name"];
                clubVo.cid = object[@"club"][@"id"] ;
                clubVo.provincecode = object[@"club"][@"provincecode"] ;
                clubVo.cid = object[@"club"][@"id"] ;
                clubVo.creator = object[@"club"][@"creator"] ;
                clubVo.hasfocus = object[@"club"][@"hasfocus"] ;
                clubVo.citycode = object[@"club"][@"citycode"] ;
                clubVo.areaname = object[@"club"][@"areaname"] ;
                clubVo.certification = object[@"club"][@"certification"] ;
                clubVo.createdate = object[@"club"][@"createdate"] ;
                clubVo.areaname = object[@"club"][@"areaname"] ;
                self.navigationItem.rightBarButtonItem.customView.hidden = YES;

                [self setJulebuView : clubVo];

            }
        } failure:^(NSError *error) {
            
        }];
        
    }else{
        if([uvo.role isEqualToString:@"1"]){
            self.navigationItem.leftBarButtonItem.customView.hidden = NO ;
            [self setBackBottmAndTitle];
        }
        
        [self getNeedDatas : @"1"];
        pageNO = @"1" ;
        
        self.soTableView = [[UITableView alloc] initWithFrame:CGRectMake(0,  20 + 44 , kScreen_Width, kScreen_Height - 20 - 44 - 30)];
        _soTableView.delegate = self ;
        _soTableView.dataSource = self;
        _soTableView.backgroundColor = [UIColor clearColor];
        _soTableView.separatorStyle = NO ;
        [self.view addSubview:_soTableView];
        
        __weak JulebuViewController *weakSelf = self ;
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
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"forwardDetail" object:nil];
}


#pragma mark - 有俱乐部的情况
-(void)setJulebuView :(ClubOBJ *) clubVo{
    self.navigationItem.leftBarButtonItem.customView.hidden = YES;

    UIView *header = [[UIView alloc] initWithFrame:CGRectMake(0, 40 + 22 , kScreen_Width,  230/2)];
    header.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:header];
    
    UIImageView *head = [[UIImageView alloc] init];
    [head sd_setImageWithURL:[NSURL URLWithString:clubVo.logourl] placeholderImage:[UIImage imageNamed:@"defaulthead"]];
    head.frame = CGRectMake(30, 25 , 140/2, 140/2) ;
    head.layer.masksToBounds =YES;
    head.layer.cornerRadius = 10 ;

    [header addSubview:head];
    
    NSString *name =  [CommonFunc textFromBase64String:clubVo.name];
//    NSString *name = @"武汉体育学院足协代表队" ;
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
    NSString *desc =  [CommonFunc textFromBase64String:clubVo.desc];
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
    NSString *desc2 = [NSString stringWithFormat:@"%@ %@" , clubVo.cityname , clubVo.areaname] ;
    CGSize titleSize2 = [NSString getMultiStringContentSizeWithFontSize:10 andContent:desc2];
    titleLabel2.size = titleSize2;
    titleLabel2.text = desc2 ;
    titleLabel2.x = nameLabel.left ;
    titleLabel2.y = nameLabel.bottom + 5 ;
    [header addSubview:titleLabel2];

    UILabel *titleLabel3 = [UILabel new];
    titleLabel3.font = [UIFont systemFontOfSize:10];
    titleLabel3.numberOfLines = 0;//多行显示，计算高度
    titleLabel3.textColor = [UIColor colorWithHexString:@"000"];
    //    NSString *desc =  [CommonFunc textFromBase64String:vo.desc];
    NSString *desc3 = clubVo.desc ;
    CGSize titleSize3 = [NSString getMultiStringContentSizeWithFontSize:10 andContent:desc3];
    titleLabel3.size = titleSize3;
    titleLabel3.text = desc3 ;
    titleLabel3.x = nameLabel.left ;
    titleLabel3.y = titleLabel2.bottom + 5 ;
    [header addSubview:titleLabel3];

    DongtaiViewController *dongtai = [DongtaiViewController new] ;
    dongtai.type = @"2" ;
    dongtai.height = self.view.frame.size.height - 20 - 44 - 98/2 - 36 - 66 ;

    ClassesViewController *focus = [ClassesViewController new];
    
    SaiListViewController *jiaolian = [SaiListViewController new];
    jiaolian.from = @"1" ;
    
    NSArray *viewControllers = @[@{@"俱乐部动态":dongtai}, @{@"俱乐部成员":focus}, @{@"赛程":jiaolian}];
    YCSlideView * view = [[YCSlideView alloc] initWithFrame:CGRectMake(0, header.bottom, kScreen_Width, kScreen_Height - 20 - 44) WithViewControllers:viewControllers] ;
    [self.view addSubview:view];

}


#pragma mark - 没有俱乐部的情况
-(void)getNeedDatas :(NSString *) page{
    
    NSDictionary *params = [NSDictionary dictionaryWithObjectsAndKeys:uvo.phone , @"phone"  , page , @"page" ,uvo.phone ,  @"token", nil];
    [PPNetworkHelper POST:listClubs parameters:params success:^(id object) {
        
        if([object[@"code"] isEqualToString:@"0000"]){
            NSDictionary *list = object[@"page"][@"list"];
            ClubOBJ *model = nil ;
            [kouList removeAllObjects];
            
            if (![list isEqual:[NSNull null]]) {
                for (NSDictionary *dic in list) {
                    model = [ClubOBJ new];
                    
                    model.desc = [NSString stringWithFormat:@"%@" , dic[@"cityname"]] ;
                    model.cid = [NSString stringWithFormat:@"%@" , dic[@"id"]] ;
                    model.areacode = [NSString stringWithFormat:@"%@" , dic[@"areacode"]] ;
                    model.logourl = [NSString stringWithFormat:@"%@" , dic[@"logourl"]] ;
                    model.cityname = [NSString stringWithFormat:@"%@" , dic[@"cityname"]] ;
                    model.provincecode = [NSString stringWithFormat:@"%@" , dic[@"provincecode"]] ;
                    model.creator = [NSString stringWithFormat:@"%@" , dic[@"creator"]] ;
                    model.hasfocus = [NSString stringWithFormat:@"%@" , dic[@"hasfocus"]] ;
                    model.citycode = [NSString stringWithFormat:@"%@" , dic[@"citycode"]] ;
                    model.areaname = [NSString stringWithFormat:@"%@" , dic[@"areaname"]] ;
                    model.certification = [NSString stringWithFormat:@"%@" , dic[@"certification"]] ;
                    model.createdate = [NSString stringWithFormat:@"%@" , dic[@"createdate"]] ;
                    model.fansCount = [NSString stringWithFormat:@"%@" , dic[@"fansCount"]] ;
                    model.name = [NSString stringWithFormat:@"%@" , [CommonFunc textFromBase64String:dic[@"name"]]] ;
                    
                    if (![uvo.club isEqualToString:model.cid]) {
                        [kouList addObject:model];
                    }
                }
                [_soTableView reloadData];
            }
            
        }
        
    } failure:^(NSError *error) {
        
    }];
}

-(void)setBackBottmAndTitle{
    UIButton *backViewBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    backViewBtn.frame = CGRectMake(0, 0, 22, 17);
    [backViewBtn setImage:[UIImage imageNamed:@"创建"] forState:UIControlStateNormal];
    [backViewBtn addTarget:self action: @selector(add)
          forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *backItem = [[UIBarButtonItem alloc] initWithCustomView:backViewBtn];
    self.navigationItem.leftBarButtonItem = backItem ;
}

- (void)setRightBottom {
    UIButton *backViewBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    backViewBtn.frame = CGRectMake(0, 0, 17, 17);
    [backViewBtn setImage:[UIImage imageNamed:@"搜索"] forState:UIControlStateNormal];
    [backViewBtn addTarget:self action: @selector(goAction)
          forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *backItem = [[UIBarButtonItem alloc] initWithCustomView:backViewBtn];
    self.navigationItem.rightBarButtonItem = backItem ;
}

-(void)goAction{
    self.hidesBottomBarWhenPushed=YES;
    MemberViewController *member = [MemberViewController new];
    [self.navigationController pushViewController:member animated:YES];
    self.hidesBottomBarWhenPushed=NO;
}

-(void)add{
    self.hidesBottomBarWhenPushed=YES;
    CreateClubViewController *create = [CreateClubViewController new];
    [self.navigationController pushViewController:create animated:YES];
    self.hidesBottomBarWhenPushed=NO;
}

#pragma mark 返回分组数
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1 ;
}

#pragma mark 返回每组行数
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [kouList count];
}

#pragma mark返回每行的单元格
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *Categorys = @"Categorys";
    
    CoachChooseTableViewCell *cell = [[CoachChooseTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:Categorys];
    if (kouList.count > 0){
        ClubOBJ *vo = [kouList objectAtIndex:indexPath.row];
        
        [cell setPhoneApplyCellByImageName:vo.logourl andWithName:vo.name andWithPhoneNum:vo.cityname andWithTel : vo.cid andWithChoose:vo.hasfocus andWithindex:indexPath.section];
        cell.delegate =  self ;
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
    
    ClubOBJ *vo = [kouList objectAtIndex:indexPath.row];
    
    self.hidesBottomBarWhenPushed = YES ;
    ClubDetailViewController *detail = [[ClubDetailViewController alloc] init];
    detail.clubVo = vo ;
    [self.navigationController pushViewController:detail animated:YES];
    self.hidesBottomBarWhenPushed = NO ;
    
}

-(void) sendapply : (NSString *)clubid andWith :(NSString *)phone {
    cache = [YYCache cacheWithName:@"FB"];
    uvo = [cache objectForKey:@"userData"];
    
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    NSDictionary *params = [NSDictionary dictionaryWithObjectsAndKeys: clubid , @"famousphone" , @"2" , @"famoustype" , uvo.phone , @"fanphone" ,uvo.phone , @"token", nil];

    [PPNetworkHelper POST:focusClub parameters:params success:^(id object) {
        if([object[@"code"] isEqualToString:@"0000"]){
            hud.mode = MBProgressHUDModeText;
            hud.removeFromSuperViewOnHide = YES;
            hud.labelText = @"关注成功";
            [hud hide:YES afterDelay:2];
        }
    } failure:^(NSError *error) {
        
    }];
}

-(void)forward : (NSNotification *) notification {
    UserDataVo *vo = [notification object];
    self.hidesBottomBarWhenPushed=YES;
    
    MemberViewController *mem = [MemberViewController new] ;
    mem.userVo = vo ;
    [self.navigationController pushViewController:mem animated:YES];
    
    self.hidesBottomBarWhenPushed=NO;

}

@end

//
//  LangResultListViewController.m
//  FBLeague
//
//  Created by long-laptop on 2017/11/18.
//  Copyright © 2017年 long-laptop. All rights reserved.
//

#import "LangResultListViewController.h"
#import "SaiChengVo.h"
#import "SVPullToRefresh.h"
#import "LianSaiView.h"

@interface LangResultListViewController (){
    YYCache *cache ;
    UserDataVo *uvo ;
    NSString *pageNO ;
    NSMutableArray *kouList ;
    
}

@end

@implementation LangResultListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor colorWithHexString:@"323c45"];
    
    kouList = [[NSMutableArray alloc] init] ;
    
    _goodTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kScreen_Width, kScreen_Height - 40 - 49 - 20 - 60)];
    _goodTableView.delegate = self ;
    _goodTableView.dataSource = self;
    _goodTableView.backgroundColor = [UIColor clearColor];
    _goodTableView.separatorStyle = NO ;
    [self.view addSubview:_goodTableView];
    
    
    //获取需要数据内容 (获取第一页)
    pageNO = @"1" ;
    
    [self getNeedDatas:pageNO];
    
    __weak LangResultListViewController *weakSelf = self ;
    [_goodTableView addPullToRefreshWithActionHandler:^{
        [weakSelf getNeedDatas : @"1"];
        [weakSelf.goodTableView.pullToRefreshView stopAnimating];
    }];
    
    __weak NSString *no = pageNO ;
    [_goodTableView addInfiniteScrollingWithActionHandler:^{
        [weakSelf getNeedDatas : [NSString stringWithFormat:@"%@", no]];
        [weakSelf.goodTableView.infiniteScrollingView stopAnimating];
    }];
    
    [_goodTableView.pullToRefreshView setTitle:@"下拉刷新..." forState:SVPullToRefreshStateStopped];
    [_goodTableView.pullToRefreshView setTitle:@"释放更新..." forState:SVPullToRefreshStateTriggered];
    [_goodTableView.pullToRefreshView setTitle:@"加载中..." forState:SVPullToRefreshStateLoading];
    
}

-(void)getNeedDatas : (NSString *)pageNo{
    cache = [YYCache cacheWithName:@"FB"];
    uvo = [cache objectForKey:@"userData"];

    NSDictionary *params = [NSDictionary dictionaryWithObjectsAndKeys: _leagueId , @"leagueId" , _clubId , @"clubId"  , _camp , @"camp" , _areaCode , @"areaCode" , _roundNum , @"roundNum" , uvo.phone ,  @"token", nil];
    [PPNetworkHelper POST:listCurrentSchedules parameters:params success:^(id object) {
        if([object[@"code"] isEqualToString:@"0000"]){
            NSDictionary *list = object[@"schedules"];
            [kouList removeAllObjects];
            
            if (![list isEqual:[NSNull null]]) {
                for (NSDictionary *object in list) {
                    _vo = [SaiChengVo new] ;
                    _vo.visitingsubmit = [NSString stringWithFormat:@"%@" , object[@"visitingsubmit"]] ;
                    _vo.areacode = [NSString stringWithFormat:@"%@" , object[@"areacode"]] ;
                    _vo.homeclubjoininid = [NSString stringWithFormat:@"%@" , object[@"homeclubjoininid"]] ;
                    _vo.matchstatus = [NSString stringWithFormat:@"%@" , object[@"matchstatus"]] ;
                    _vo.visitingclub = [NSString stringWithFormat:@"%@" , object[@"visitingclub"]] ;
                    _vo.homeclubname = [NSString stringWithFormat:@"%@" , object[@"homeclubname"]] ;
                    _vo.visitingclubphone = [NSString stringWithFormat:@"%@" , object[@"visitingclubphone"]] ;
                    _vo.areaname = [NSString stringWithFormat:@"%@" , object[@"areaname"]] ;
                    _vo.startdate = [NSString stringWithFormat:@"%@" , object[@"startdate"]] ;
                    _vo.visitingeva = [NSString stringWithFormat:@"%@" , object[@"visitingeva"]] ;
                    _vo.homesubmit = [NSString stringWithFormat:@"%@" , object[@"homesubmit"]] ;
                    _vo.camp = [NSString stringWithFormat:@"%@" , object[@"camp"]] ;
                    _vo.hasplayed = [NSString stringWithFormat:@"%@" , object[@"hasplayed"]] ;
                    _vo.visitingclubname = [NSString stringWithFormat:@"%@" , object[@"visitingclubname"]] ;
                    _vo.enddate = [NSString stringWithFormat:@"%@" , object[@"enddate"]] ;
                    _vo.leagueid = [NSString stringWithFormat:@"%@" , object[@"leagueid"]] ;
                    _vo.homegoalcount = [NSString stringWithFormat:@"%@" , object[@"homegoalcount"]] ;
                    _vo.sid = [NSString stringWithFormat:@"%@" , object[@"id"]] ;
                    _vo.homeclubphone = [NSString stringWithFormat:@"%@" , object[@"homeclubphone"]] ;
                    _vo.visitinggoalcount = [NSString stringWithFormat:@"%@" , object[@"visitinggoalcount"]] ;
                    _vo.visitingclubjoininid = [NSString stringWithFormat:@"%@" , object[@"visitingclubjoininid"]] ;
                    _vo.homegoalcount = [NSString stringWithFormat:@"%@" , object[@"homegoalcount"]] ;
                    _vo.homeclub = [NSString stringWithFormat:@"%@" , object[@"homeclub"]] ;
                    _vo.roundnum = [NSString stringWithFormat:@"%@" , object[@"roundnum"]] ;
                    _vo.homeeva = [NSString stringWithFormat:@"%@" , object[@"homeeva"]] ;
                    [kouList addObject:_vo];
                }
                [_goodTableView reloadData];
            }
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
    static NSString *cellIdentifier  = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    SaiChengVo *vo = [kouList objectAtIndex:indexPath.section];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
        NSString *resultStr = [NSString stringWithFormat:@"%@:%@" , vo.homeeva , vo.visitingeva] ;
        if(![vo.matchstatus isEqualToString:@"3"] || [vo.matchstatus isEqualToString:@"5"]){
            resultStr = @"VS" ;
        }
        
        [cell.contentView addSubview:[[LianSaiView new] getHeSuiCell:[CommonFunc textFromBase64String:vo.homeclubname] andToSai: [CommonFunc textFromBase64String:vo.visitingclubname]  andWithResult:resultStr]];
    }
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone ;
    return cell ;
    
}


#pragma mark - 代理方法
#pragma mark 重新设置单元格高度
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 90/2 ;
}

#pragma mark 点击行
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
}


@end

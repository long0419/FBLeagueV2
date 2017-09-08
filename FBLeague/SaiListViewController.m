//
//  SaiListViewController.m
//  FBLeague
//
//  Created by long-laptop on 2017/9/6.
//  Copyright © 2017年 long-laptop. All rights reserved.
//

#import "SaiListViewController.h"
#import "SaiChengVo.h"
#import "SVPullToRefresh.h"
#import "LianSaiView.h"

@interface SaiListViewController (){
    YYCache *cache ;
    UserDataVo *uvo ;
    NSString *pageNO ;
    NSMutableArray *kouList ;
    
}

@end

@implementation SaiListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor colorWithHexString:@"323c45"];
    
    kouList = [[NSMutableArray alloc] init] ;
    
    _goodTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kScreen_Width, kScreen_Height - 20 -44 - 100 - 40)];
    _goodTableView.delegate = self ;
    _goodTableView.dataSource = self;
    _goodTableView.backgroundColor = [UIColor clearColor];
    _goodTableView.separatorStyle = NO ;
    [self.view addSubview:_goodTableView];
    
    
    //获取需要数据内容 (获取第一页)
    pageNO = @"1" ;
    
    [self getNeedDatas:pageNO];
    
    __weak SaiListViewController *weakSelf = self ;
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

-(void) getNeedDatas : (NSString *) page{
    cache = [YYCache cacheWithName:@"FB"];
    uvo = [cache objectForKey:@"userData"];
    //    self.HUD = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    
    NSDictionary *params = [NSDictionary dictionaryWithObjectsAndKeys: uvo.club , @"clubId" , uvo.phone ,  @"token", nil];
    [PPNetworkHelper POST:listSchedules parameters:params success:^(id data) {
        if([data[@"code"] isEqualToString:@"0000"]){
            if ([data[@"schedules"] isEqual:[NSNull null]]) {
                return ;
            }
            NSDictionary *list = data[@"schedules"];
            SaiChengVo *model = nil ;
            [kouList removeAllObjects];
            
            if (![list isEqual:[NSNull null]]) {
                for (NSDictionary *dic in list) {
                    model = [SaiChengVo new];
                    model.visitingsubmit = [NSString stringWithFormat:@"%@" , dic[@"visitingsubmit"]] ;
                    model.matchstatus = [NSString stringWithFormat:@"%@" , dic[@"matchstatus"]] ;
                    model.matchid = [NSString stringWithFormat:@"%@" , dic[@"matchid"]] ;
                    model.matchid = [NSString stringWithFormat:@"%@" , dic[@"matchid"]] ;
                    model.visitingclub = [NSString stringWithFormat:@"%@" , dic[@"visitingclub"]] ;
                    model.homeclubname = [NSString stringWithFormat:@"%@" , dic[@"homeclubname"]] ;
                    model.visitingeva = [NSString stringWithFormat:@"%@" , dic[@"visitingeva"]] ;
                    model.homesubmit = [NSString stringWithFormat:@"%@" , dic[@"homesubmit"]] ;
                    model.field = [NSString stringWithFormat:@"%@" , dic[@"field"]] ;
                    model.hasplayed = [NSString stringWithFormat:@"%@" , dic[@"hasplayed"]] ;
                    model.visitingclubname = [NSString stringWithFormat:@"%@" , dic[@"visitingclubname"]] ;
                    model.challengeid = [NSString stringWithFormat:@"%@" , dic[@"challengeid"]] ;
                    model.leagueid = [NSString stringWithFormat:@"%@" , dic[@"leagueid"]] ;
                    model.sid = [NSString stringWithFormat:@"%@" , dic[@"id"]] ;
                    model.challengeid = [NSString stringWithFormat:@"%@" , dic[@"challengeid"]] ;
                    model.visitinggoalcount = [NSString stringWithFormat:@"%@" , dic[@"visitinggoalcount"]] ;
                    model.matchname = [NSString stringWithFormat:@"%@" , dic[@"matchname"]] ;
                    model.homegoalcount = [NSString stringWithFormat:@"%@" , dic[@"homegoalcount"]] ;
                    model.homeclub = [NSString stringWithFormat:@"%@" , dic[@"homeclub"]] ;
                    model.remarks = [NSString stringWithFormat:@"%@" , dic[@"remarks"]] ;
                    model.matchtime = [NSString stringWithFormat:@"%@" , dic[@"matchtime"]] ;
                    model.roundnum = [NSString stringWithFormat:@"%@" , dic[@"roundnum"]] ;
                    model.homeeva = [NSString stringWithFormat:@"%@" , dic[@"homeeva"]] ;
                    [kouList addObject:model];
                }
            }else {
                self.HUD.mode = MBProgressHUDModeText;
                self.HUD.removeFromSuperViewOnHide = YES;
                self.HUD.labelText = @"系统错误";
                [self.HUD hide:YES afterDelay:3];
            }
            [_goodTableView reloadData];
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
    SaiChengVo *vo = [kouList objectAtIndex:indexPath.section];
    NSString *content = [NSString stringWithFormat:@"%@ vs %@" , vo.homeclubname , vo.visitingclubname];
    
    if(![vo.hasplayed isEqualToString:@"n"]){
        content = [NSString stringWithFormat:@"%@ 2 - 1 %@" ,vo.homeclubname , vo.visitingclubname];
    }
    
    LianSaiView *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];

    if(!cell) {
        cell = [LianSaiView new];
        [cell getSaiLineView:content andWithType:vo.matchstatus];
    }
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone ;
    return cell ;
    
}


#pragma mark - 代理方法
#pragma mark 重新设置单元格高度
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 80/2 ;
}

#pragma mark 点击行
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    
}


@end

//
//  BaomingViewController.m
//  FBLeague
//
//  Created by long-laptop on 2017/9/6.
//  Copyright © 2017年 long-laptop. All rights reserved.
//

#import "BaomingViewController.h"
#import "LianSaiData.h"
#import "SVPullToRefresh.h"
#import "LianSaiView.h"

@interface BaomingViewController (){
    YYCache *cache ;
    UserDataVo *uvo ;
    NSString *pageNO ;
    NSMutableArray *kouList ;
    LianSaiData *model ;
}

@end

@implementation BaomingViewController

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
    
}

-(void) getNeedDatas : (NSString *) page{
    cache = [YYCache cacheWithName:@"FB"];
    uvo = [cache objectForKey:@"userData"];

    NSDictionary *params = [NSDictionary dictionaryWithObjectsAndKeys: page , @"page" , uvo.club ,@"clubId" , _leagueId , @"leagueId" , uvo.phone ,  @"token", nil];
    [PPNetworkHelper POST:listJoinin parameters:params success:^(id data) {
        if([data[@"code"] isEqualToString:@"0000"]){
            if ([data[@"page"] isEqual:[NSNull null]]) {
                return ;
            }
            NSDictionary *dic = data[@"match"];
            [kouList removeAllObjects];

            if (![dic isEqual:[NSNull null]]) {
//                for (NSDictionary *dic in list) {
                    model = [LianSaiData new];
                    model.lid = [NSString stringWithFormat:@"%@" , dic[@"id"]] ;
                    model.provincename = [NSString stringWithFormat:@"%@" , dic[@"provincename"]] ;
                    model.areacode = [NSString stringWithFormat:@"%@" , dic[@"areacode"]] ;
                    model.matchname = [NSString stringWithFormat:@"%@" , dic[@"matchname"]] ;
                    model.leagueid = [NSString stringWithFormat:@"%@" , dic[@"leagueid"]] ;
                    model.isfull = [NSString stringWithFormat:@"%@" , dic[@"isfull"]] ;
                    model.cityname = [NSString stringWithFormat:@"%@" , dic[@"cityname"]] ;
                    model.grouptype = [NSString stringWithFormat:@"%@" , dic[@"grouptype"]] ;
                    model.provincecode = [NSString stringWithFormat:@"%@" , dic[@"provincecode"]] ;
                    model.grouptype = [NSString stringWithFormat:@"%@" , dic[@"grouptype"]] ;
                    model.citycode = [NSString stringWithFormat:@"%@" , dic[@"citycode"]] ;
                    model.enabled = [NSString stringWithFormat:@"%@" , dic[@"enabled"]] ;
                    model.format = [NSString stringWithFormat:@"%@" , dic[@"format"]] ;
                    model.joininCount = [NSString stringWithFormat:@"%@" , dic[@"joininCount"]] ;
                    model.areaname = [NSString stringWithFormat:@"%@" , dic[@"areaname"]] ;
                    model.matchnumber = [NSString stringWithFormat:@"%@" , dic[@"matchnumber"]] ;
                    model.number = [NSString stringWithFormat:@"%@" , dic[@"number"]] ;
                    model.bonus = [NSString stringWithFormat:@"%@" , dic[@"bonus"]] ;
                    [kouList addObject:model];
//                }
//                if (currPage.longLongValue == nextPage.longLongValue) {
//                    pageNO =  currPage ;
//                }else{
//                    pageNO =  nextPage ;
//                }
                
            }else {
                self.HUD.mode = MBProgressHUDModeText;
                self.HUD.removeFromSuperViewOnHide = YES;
                self.HUD.labelText = @"系统错误";
                [self.HUD hide:YES afterDelay:3];
            }
            [_goodTableView reloadData];
        }
//        [self closeProgressView];

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
    LianSaiData *vo = [kouList objectAtIndex:indexPath.section];
    NSString *title = [NSString stringWithFormat:@"%@ %@ %@" , vo.provincename , vo.cityname , vo.areaname];

    LianSaiView *cell = [LianSaiView new];
    [cell BaomingView:title andWithName:vo.matchname andWithLineData:vo.joininCount withTotal:@"20"];
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
    
    LianSaiData *vo = [kouList objectAtIndex:indexPath.section];
    
}


@end

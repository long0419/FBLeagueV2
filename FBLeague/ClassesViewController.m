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

    [self getNeedDatas : @"1"];
    pageNO = @"1" ;
    
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
    
    NSDictionary *params = [NSDictionary dictionaryWithObjectsAndKeys:uvo.phone , @"phone"  , page , @"page" , nil];
    [PPNetworkHelper POST:listClubs parameters:params success:^(id object) {
        
        if([object[@"code"] isEqualToString:@"0000"]){
            NSDictionary *list = object[@"coaches"];
            CoachVo *model = nil ;
            [kouList removeAllObjects];
            
            if (![list isEqual:[NSNull null]]) {
                for (NSDictionary *dic in list) {
                    model = [CoachVo new];
                    model.cityName = [NSString stringWithFormat:@"%@" , dic[@"cityName"]] ;
                    model.firstLetter = [NSString stringWithFormat:@"%@" ,dic[@"firstLetter"]] ;
                    model.hasFocus = [NSString stringWithFormat:@"%@" ,dic[@"hasFocus"]] ;
                    model.level = [NSString stringWithFormat:@"%@" ,dic[@"level"]]  ;
                    model.name = [NSString stringWithFormat:@"%@" ,dic[@"name"]]  ;
                    model.phone =  [NSString stringWithFormat:@"%@" ,dic[@"phone"]]  ;
                    model.headerUrl =  [NSString stringWithFormat:@"%@" ,dic[@"headpicurl"]]  ;
                    [kouList addObject:model];
                }
                [_soTableView reloadData];
            }
            
        }
        
    } failure:^(NSError *error) {
        
    }];
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
        CoachVo *vo = [kouList objectAtIndex:indexPath.row];
        
        [cell setPhoneContactCellByImageName:vo.headerUrl andWithName:vo.name andWithPhoneNum:vo.cityName andWithChoose:vo.hasFocus andWithindex:indexPath.section];
        //        cell.delegate =  self ;
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
    
    CoachVo *vo = [kouList objectAtIndex:indexPath.section];
    
    
}


@end

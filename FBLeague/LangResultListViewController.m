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
    
    _goodTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kScreen_Width, kScreen_Height - 20 -44 - 100 - 40)];
    _goodTableView.delegate = self ;
    _goodTableView.dataSource = self;
    _goodTableView.backgroundColor = [UIColor clearColor];
    _goodTableView.separatorStyle = NO ;
    [self.view addSubview:_goodTableView];
    
    
    //获取需要数据内容 (获取第一页)
    pageNO = @"1" ;
    
//    [self getNeedDatas:pageNO];
    
    __weak LangResultListViewController *weakSelf = self ;
    [_goodTableView addPullToRefreshWithActionHandler:^{
//        [weakSelf getNeedDatas : @"1"];
        [weakSelf.goodTableView.pullToRefreshView stopAnimating];
    }];
    
    __weak NSString *no = pageNO ;
    [_goodTableView addInfiniteScrollingWithActionHandler:^{
//        [weakSelf getNeedDatas : [NSString stringWithFormat:@"%@", no]];
        [weakSelf.goodTableView.infiniteScrollingView stopAnimating];
    }];
    
    [_goodTableView.pullToRefreshView setTitle:@"下拉刷新..." forState:SVPullToRefreshStateStopped];
    [_goodTableView.pullToRefreshView setTitle:@"释放更新..." forState:SVPullToRefreshStateTriggered];
    [_goodTableView.pullToRefreshView setTitle:@"加载中..." forState:SVPullToRefreshStateLoading];
    
}

#pragma mark 返回分组数
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 44 ;
//    [kouList count] ;
}

#pragma mark 返回每组行数
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1 ;
}

#pragma mark返回每行的单元格
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellIdentifier  = @"cell";
    UITableViewCell *cell = [UITableViewCell new] ;
    
    LianSaiView *view = [LianSaiView new];
    [cell addSubview: [view getHeSuiCell:@"洪山区" andToSai:@"武汉大学队" andWithResult:@"VS"]];
    
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

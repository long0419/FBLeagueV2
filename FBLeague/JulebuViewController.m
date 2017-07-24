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

@interface JulebuViewController (){
    NSMutableArray *kouList ;
    YYCache *cache ;
    UserDataVo *uvo ;
    NSString *pageNO ;

}

@end

@implementation JulebuViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    kouList = [[NSMutableArray alloc] init];

    self.title = @"俱乐部" ;
    cache = [YYCache cacheWithName:@"FB"];
    uvo = [cache objectForKey:@"userData"];
    
    if(![uvo.club isEqual:[NSNull null]]){
        [self setJulebuView];
    }else{
        if([uvo.role isEqualToString:@"1"]){
            [self setBackBottmAndTitle];
        }
        
        [self getNeedDatas : @"1"];
        pageNO = @"1" ;
        
        self.soTableView = [[UITableView alloc] initWithFrame:CGRectMake(0,  0 , kScreen_Width, kScreen_Height)];
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
    
    [self setRightBottom];
    
}

#pragma mark - 有俱乐部的情况
-(void)setJulebuView{
    UIView *header = [[UIView alloc] initWithFrame:CGRectMake(0, 40 + 22 , kScreen_Width,  230/2)];
    header.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:header];
    
    UIImageView *head ;
    if (nil == uvo.headpicurl || [@"" isEqualToString:uvo.headpicurl]) {
        head = [[UIImageView alloc]
                initWithImage:[UIImage imageNamed:@"defaulthead"]];
    }else{
        head = [[UIImageView alloc] init];
        [head sd_setImageWithURL:[NSURL URLWithString:uvo.headpicurl] placeholderImage:nil];
    }
    head.frame = CGRectMake(30, 25 , 140/2, 140/2) ;
    head.layer.masksToBounds =YES;
    head.layer.cornerRadius = 10 ;

//    head.userInteractionEnabled = YES ;
//    UITapGestureRecognizer *singleTap3 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(addPic)];
//    [head addGestureRecognizer:singleTap3];
    [header addSubview:head];
    
//    NSString *name =  [CommonFunc textFromBase64String:vo.name];
    NSString *name = @"武汉体育学院足协代表队" ;
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
//    NSString *desc =  [CommonFunc textFromBase64String:vo.desc];
    NSString *desc = @"不错 不错" ;
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
    //    NSString *desc =  [CommonFunc textFromBase64String:vo.desc];
    NSString *desc2 = @"口号：备战特步大学生足球联赛" ;
    CGSize titleSize2 = [NSString getMultiStringContentSizeWithFontSize:10 andContent:desc2];
    titleLabel2.size = titleSize2;
    titleLabel2.text = desc2 ;
    titleLabel2.x = nameLabel.left ;
    titleLabel2.y = titleLabel.bottom + 5 ;
    [header addSubview:titleLabel2];

    UILabel *titleLabel3 = [UILabel new];
    titleLabel3.font = [UIFont systemFontOfSize:10];
    titleLabel3.numberOfLines = 0;//多行显示，计算高度
    titleLabel3.textColor = [UIColor colorWithHexString:@"000"];
    //    NSString *desc =  [CommonFunc textFromBase64String:vo.desc];
    NSString *desc3 = @"关注：200     粉丝：200" ;
    CGSize titleSize3 = [NSString getMultiStringContentSizeWithFontSize:10 andContent:desc2];
    titleLabel3.size = titleSize3;
    titleLabel3.text = desc3 ;
    titleLabel3.x = nameLabel.left ;
    titleLabel3.y = titleLabel2.bottom + 5 ;
    [header addSubview:titleLabel3];

    DongtaiViewController *dongtai = [DongtaiViewController new] ;
    
    MemberViewController *focus = [MemberViewController new];
    
    SaiChengViewController *jiaolian = [SaiChengViewController new] ;    
    
    NSArray *viewControllers = @[@{@"俱乐部动态":dongtai}, @{@"俱乐部成员":focus}, @{@"赛程":jiaolian}];
    YCSlideView * view = [[YCSlideView alloc] initWithFrame:CGRectMake(0, header.bottom, kScreen_Width, kScreen_Height - 20 - 44) WithViewControllers:viewControllers] ;
    [self.view addSubview:view];

}


#pragma mark - 没有俱乐部的情况
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
    
    MemberViewController *detail = [[MemberViewController alloc] init];
//    detail.coachPhone = vo.phone ;
    [self.navigationController pushViewController:detail animated:YES];
    
}


@end

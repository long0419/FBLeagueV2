//
//  QiuYuanDataDetailViewController.m
//  FBLeague
//
//  Created by long-laptop on 2017/10/17.
//  Copyright © 2017年 long-laptop. All rights reserved.
//

#import "QiuYuanDataDetailViewController.h"

@interface QiuYuanDataDetailViewController (){
    QiuYuanVo *vo;
    UIView *header ;
    UITableView *table ;
    YYCache *cache ;
    UserDataVo *uvo ;
}


@end

@implementation QiuYuanDataDetailViewController

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = YES ;
    [self hideTabBottom];
}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    
    [self showTabBottom];
}


-(void)getNeedData{
    cache = [YYCache cacheWithName:@"FB"];
    uvo = [cache objectForKey:@"userData"];
    
    NSDictionary *params = [NSDictionary dictionaryWithObjectsAndKeys: _qPhone , @"phone" ,uvo.phone , @"token", nil];
    [PPNetworkHelper POST:getCBDetail parameters:params success:^(id data) {
        if([data[@"code"] isEqualToString:@"0000"]){
            vo = [QiuYuanVo new];
            vo.age = data[@"trainee"][@"age"];
            vo.cityName = data[@"trainee"][@"cityName"];
            vo.clubName = data[@"trainee"][@"clubName"];
            vo.defend = data[@"trainee"][@"defend"];
            vo.dribbling = data[@"trainee"][@"dribbling"];
            vo.firstLetter = data[@"trainee"][@"firstLetter"];
            vo.hasFocus = data[@"trainee"][@"hasFocus"];
            vo.headpicurl = data[@"trainee"][@"headpicurl"];
            vo.name = data[@"trainee"][@"name"];
            vo.pass = data[@"trainee"][@"pass"];
            vo.phone = data[@"trainee"][@"phone"];
            vo.speed = data[@"trainee"][@"speed"];
            vo.strength = data[@"trainee"][@"strength"];
            vo.withstand = data[@"trainee"][@"withstand"];
            
        }else {
            [SVProgressHUD showErrorWithStatus: @"系统错误"];
            [SVProgressHUD setDefaultStyle:SVProgressHUDStyleDark];
        }
    } failure:^(NSError *error) {
        
    }];
    
    
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self getNeedData];
}


-(UIView *)cellView {
    UIView *tmpView = [[UIView alloc] init];
    [self.view addSubview:tmpView];
    
    [tmpView addSubview:header];
    
    UIView *one = [ExplainView titleView:@"个人资料"];
    one.origin = CGPointMake(0, header.bottom);
    [tmpView addSubview:one];
    
    UIView *name = [ExplainView textView : [NSString stringWithFormat:@"姓       名 : %@" , vo.name]];
    name.origin = CGPointMake(0, one.bottom);
    [tmpView addSubview:name];
    
    NSString *cname = [CommonFunc textFromBase64String:vo.clubName];
    UIView *clueName = [ExplainView textView : [NSString stringWithFormat:@"球队名称 : %@" , cname]];
    clueName.origin = CGPointMake(0, name.bottom + 1);
    [tmpView addSubview:clueName];
    
    UIView *age = [ExplainView textView : [NSString stringWithFormat:@"年        龄 : %@" , vo.age]];
    age.origin = CGPointMake(0, clueName.bottom + 1);
    [tmpView addSubview:age];
    
    UIView *two = [ExplainView titleView:@"能力值"];
    two.origin = CGPointMake(0, age.bottom);
    [tmpView addSubview:two];
    
    JHRadarChart *radarChart = [[JHRadarChart alloc] initWithFrame:CGRectMake(0, two.bottom, kScreen_Width , 300)];
    radarChart.backgroundColor = [UIColor whiteColor];
    /*       Each point of the description text, according to the number of the array to determine the number of basic modules         */
    radarChart.valueDescArray = @[
                                  [NSString stringWithFormat:@"传球 %d" , [vo.pass intValue]],
                                  [NSString stringWithFormat:@"力量 %d" , [vo.strength intValue]],
                                  [NSString stringWithFormat:@"速度 %d" , [vo.speed intValue]],
                                  [NSString stringWithFormat:@"对抗 %d" , [vo.withstand intValue]],
                                  [NSString stringWithFormat:@"防守 %d" , [vo.defend intValue]],
                                  [NSString stringWithFormat:@"盘带 %d" , [vo.dribbling intValue]]];
    
    /*         Number of basic module layers        */
    radarChart.layerCount = 5;
    
    /*        @"80",@"40",@"100",@"76",@"75",@"50"    vo.skill,vo.control,vo.strongHand ,vo.counterattack ,vo.compete ,vo.stimulate     */
    radarChart.valueDataArray = @[@[vo.pass ,vo.strength,vo.speed,vo.withstand ,vo.defend,vo.dribbling]];
    
    /*        Color of each basic module layer   ffce56      */
    radarChart.layerFillColor = [UIColor colorWithHexString:@"ffffff" andAlpha:.5];
    
    /*        The fill color of the value module is required to specify the color for each value module         */
    radarChart.valueDrawFillColorArray = @[[UIColor colorWithHexString:@"4cc07f" andAlpha:.5]];
    
    /*       show        */
    [radarChart showAnimation];
    
    [tmpView addSubview:radarChart];
    
    
    //传球、力量、速度、对抗、防守、盘带
    UIView *detail1 = [ExplainView metricDetail:@"传球" andWithNum:[vo.pass intValue] andWithColor:@"4bc0c0" andRight:YES];
    detail1.origin = CGPointMake(0, 21) ;
    
    UIView *detailViews = [[UIView alloc] init];
    detailViews.origin = CGPointMake(0, radarChart.bottom);
    detailViews.backgroundColor = [UIColor whiteColor];
    [tmpView addSubview:detailViews];
    [detailViews addSubview:detail1];
    
    UIView *detail2 = [ExplainView metricDetail:@"力量" andWithNum:[vo.strength intValue] andWithColor:@"f44336" andRight:NO];
    detail2.origin = CGPointMake(detail1.right , 21) ;
    [detailViews addSubview:detail2];
    
    UIView *detail3 = [ExplainView metricDetail:@"速度" andWithNum:[vo.speed intValue] andWithColor:@"ffce56" andRight:true];
    detail3.origin = CGPointMake(0 , detail2.bottom + 15) ;
    [detailViews addSubview:detail3];
    
    UIView *detail4 = [ExplainView metricDetail:@"对抗" andWithNum:[vo.withstand intValue] andWithColor:@"03a9f4" andRight:NO];
    detail4.origin = CGPointMake(detail3.right , detail2.bottom + 15) ;
    [detailViews addSubview:detail4];
    
    UIView *detail5 = [ExplainView metricDetail:@"防守" andWithNum:[vo.defend intValue] andWithColor:@"22b66e" andRight:true];
    detail5.origin = CGPointMake(0 , detail3.bottom + 15) ;
    [detailViews addSubview:detail5];
    
    UIView *detail6 = [ExplainView metricDetail:@"盘带" andWithNum:[vo.dribbling intValue] andWithColor:@"8bc34a" andRight:NO];
    detail6.origin = CGPointMake(detail5.right , detail3.bottom + 15) ;
    [detailViews addSubview:detail6];
    detailViews.size = CGSizeMake(kScreen_Width, detail6.bottom - detail1.top + 40);
    
    tmpView.frame = CGRectMake(0, 0, kScreen_Width, detail6.bottom - one.top) ;
    return tmpView ;
}

#pragma mark 返回分组数
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1 ;
}

#pragma mark 返回每组行数
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1 ;
}

#pragma mark返回每行的单元格
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *Categorys = @"Categorys";
    
    UITableViewCell *cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:Categorys];
    [cell addSubview:[self cellView]];
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone ;
    return cell ;
}

#pragma mark - 代理方法
#pragma mark 重新设置单元格高度
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 780 ;
}

#pragma mark 点击行
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
}

@end

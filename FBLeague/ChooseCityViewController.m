//
//  ChooseCityViewController.m
//  FBLeague
//
//  Created by long-laptop on 2016/11/24.
//  Copyright © 2016年 long-laptop. All rights reserved.
//

#import "ChooseCityViewController.h"
#import "ProvinceVo.h"
#import "PersonInfoViewController.h"

@interface ChooseCityViewController (){
    NSMutableArray *kouList ;
    UIButton *sender ;
    NSString *chooseProAndCity ;
    NSString *proCityCode ;
}

@end

@implementation ChooseCityViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setBackBottmAndTitle];
    
    kouList = [[NSMutableArray alloc] init] ;
    
    self.title = @"选择城市" ;
    self.view.backgroundColor = [UIColor colorWithHexString:@"ffffff"];
    
    self.navigationController.navigationBar.titleTextAttributes = [NSDictionary dictionaryWithObjectsAndKeys:[UIColor blackColor], UITextAttributeTextColor,nil];
    self.navigationController.navigationBar.barTintColor = [UIColor whiteColor];
    [self setBackBottmAndTitle];
    
    
//    [self setRightBottom];

    _goodTableView = [[UITableView alloc] initWithFrame:CGRectMake(0,0 , kScreen_Width, kScreen_Height)];
    _goodTableView.delegate = self ;
    _goodTableView.dataSource = self;
    _goodTableView.backgroundColor = [UIColor clearColor];
    _goodTableView.separatorStyle = NO ;
    [self.view addSubview:_goodTableView];
    
    [self getNeedDatas];

}

- (void)setRightBottom {
    CGSize size = [NSString getStringContentSizeWithFontSize:15 andContent:@"发送"] ;
    sender = [UIButton buttonWithType:UIButtonTypeCustom];
    sender.frame = CGRectMake(0, 0, size.width , size.height);
    [sender setTitle:@"确定" forState:UIControlStateNormal];
    sender.titleLabel.font = [UIFont systemFontOfSize: 15];
    sender.titleLabel.alpha = 1 ;
    [sender setTitleColor:[UIColor colorWithHexString:@"000000"]forState:UIControlStateNormal];
    [sender addTarget:self action: @selector(send)
     forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *backItem = [[UIBarButtonItem alloc] initWithCustomView:sender];
    self.navigationItem.rightBarButtonItem = backItem ;
}

-(void)send{
    RTContainerController *verifyCode2 =
    [self.rt_navigationController.viewControllers objectAtIndex:self.rt_navigationController.viewControllers.count - 3];
    PersonInfoViewController *info = verifyCode2.contentViewController ;
    info.areaStr = chooseProAndCity ;
    info.areaCodeStr = proCityCode ;
    [self.rt_navigationController popToViewController:info animated:YES];
}

-(void)getNeedDatas{
    
    if ([_isfrom isEqualToString:@"2"]) {
        NSDictionary *params = [NSDictionary dictionaryWithObjectsAndKeys:_code , @"provinceCode" , nil];
        [PPNetworkHelper POST:getCountyAreas parameters:nil success:^(id data) {
            if([data[@"code"] isEqualToString:@"0000"]){
                NSDictionary *list = data[@"cities"];
                CityVo *model = nil ;
                [kouList removeAllObjects];
                
                if (![list isEqual:[NSNull null]]) {
                    for (NSDictionary *dic in list) {
                        model = [CityVo new];
                        model.provincecode = [NSString stringWithFormat:@"%@" , dic[@"provincecode"]] ;
                        model.name = [NSString stringWithFormat:@"%@" ,dic[@"name"]] ;
                        model.code = [NSString stringWithFormat:@"%@" ,dic[@"code"]] ;
                        model.cid = [NSString stringWithFormat:@"%@" ,dic[@"id"]] ;
                        if ([dic[@"provincecode"] isEqualToString:_code]) {
                            [kouList addObject:model];
                        }
                    }
                }
                [_goodTableView reloadData];
            }else {
                
                [SVProgressHUD showErrorWithStatus:@"系统错误"];
                [SVProgressHUD setDefaultStyle:SVProgressHUDStyleDark];
                
            }
        } failure:^(NSError *error) {
            
        }];

    }else{
        NSDictionary *params = [NSDictionary dictionaryWithObjectsAndKeys:_code , @"provinceCode" , nil];
        [PPNetworkHelper POST:getCities parameters:params success:^(id data) {
            if([data[@"code"] isEqualToString:@"0000"]){
                NSDictionary *list = data[@"cities"];
                CityVo *model = nil ;
                [kouList removeAllObjects];
                
                if (![list isEqual:[NSNull null]]) {
                    for (NSDictionary *dic in list) {
                        model = [CityVo new];
                        model.code = [NSString stringWithFormat:@"%@" , dic[@"provincecode"]] ;
                        model.name = [NSString stringWithFormat:@"%@" ,dic[@"name"]] ;
                        model.provincecode = [NSString stringWithFormat:@"%@" ,dic[@"code"]] ;
                        model.cid = [NSString stringWithFormat:@"%@" ,dic[@"id"]] ;
                        [kouList addObject:model];
                    }
                }
                [_goodTableView reloadData];
            }else {
                
                [SVProgressHUD showErrorWithStatus:@"系统错误"];
                [SVProgressHUD setDefaultStyle:SVProgressHUDStyleDark];
                
            }
        } failure:^(NSError *error) {
            
        }];
    }
    
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
    static NSString *Categorys = @"ChooseArea";
    
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:Categorys];
    if (kouList.count > 0){
        ProvinceVo *vo = [kouList objectAtIndex:indexPath.section];
        [cell addSubview:[self chooseAreaView:vo.name]];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone ;
    return cell ;
}

#pragma mark - 代理方法
#pragma mark 重新设置单元格高度
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 98/2 ;
}


#pragma mark 点击行
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    CityVo *vo = [kouList objectAtIndex:indexPath.section];
    
    chooseProAndCity = [NSString stringWithFormat:@"%@ %@" , _provincename , vo.name];
    proCityCode = [NSString stringWithFormat:@"%@ %@" , vo.provincecode , vo.code];

    self.hidesBottomBarWhenPushed=YES;
    ChooseSectionViewController *city = [[ChooseSectionViewController alloc] init];
    city.code = proCityCode ;
    if ([_isfrom isEqualToString:@"2"]) {
        city.cityCode = vo.code ;
    }else{
        city.cityCode = vo.provincecode ;
    }
    city.name = chooseProAndCity ;
    city.isfrom = _isfrom ;
    [self.navigationController pushViewController:city animated:YES];
    self.hidesBottomBarWhenPushed=NO;

}

-(void)cancelChooseStatus : (UITableView *)tableView :(NSIndexPath *) indexPath{
    NSArray *cells = tableView.visibleCells ;
    for (int i = 0 ; i<[cells count]; i++) {
        if (i != indexPath.section) {
            UITableViewCell *cell = [cells objectAtIndex:i];
            UIView *right = [[cell subviews] objectAtIndex:1] ;
            [right viewWithTag:11].hidden = YES ;

        }
    }
}

-(UIView *) chooseAreaView :(NSString *) title {
    
    UIView *qiumi = [[UIView alloc] initWithFrame:CGRectMake(0, 0 , kScreen_Width, 98/2)];
    qiumi.backgroundColor = [UIColor clearColor] ;
    
    CGSize qiumiSize = [NSString getStringContentSizeWithFontSize:15 andContent:title] ;
    UILabel *qiumiTxt = [[UILabel alloc] initWithFrame:CGRectMake(15 , (qiumi.height - qiumiSize.height)/2 , qiumiSize.width, qiumiSize.height)] ;
    qiumiTxt.text = title ;
    qiumiTxt.font = [UIFont systemFontOfSize:15] ;
    qiumiTxt.textColor = [UIColor colorWithHexString:@"333333"] ;
    [qiumi addSubview:qiumiTxt];
    
    UIView *line = [[UIView alloc] initWithFrame:CGRectMake(15 , qiumi.bottom - 1 , kScreen_Width - 30 , 1)];
    line.backgroundColor = [UIColor colorWithHexString:@"f3f3f4"];
    [qiumi addSubview:line];
    
    UIImageView *extend = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"choose"]];
    extend.tag = 11 ;
    extend.frame = CGRectMake(kScreen_Width - 15 - 29/2 , (qiumi.height - 19/2)/2, 29/2, 19/2);
    extend.hidden = true ;
    [qiumi addSubview:extend];
    
    return qiumi ;
}


@end

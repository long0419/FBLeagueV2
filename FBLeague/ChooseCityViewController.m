//
//  ChooseCityViewController.m
//  FBLeague
//
//  Created by long-laptop on 2016/11/24.
//  Copyright © 2016年 long-laptop. All rights reserved.
//

#import "ChooseCityViewController.h"
#import "ProvinceVo.h"
#import "VerifyCodeView2ViewController.h"

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
    self.view.backgroundColor = [UIColor colorWithHexString:@"f6f6f6"] ;
    
    CGSize psdSize = [NSString getStringContentSizeWithFontSize:13 andContent:@"全部"] ;
    UILabel *psdname = [[UILabel alloc] initWithFrame:CGRectMake(15 , 10 , psdSize.width, psdSize.height)] ;
    psdname.text = @"全部" ;
    psdname.font = [UIFont systemFontOfSize:13] ;
    psdname.textColor = [UIColor colorWithHexString:@"999999"] ;
    [self.view addSubview:psdname];
    
    [self setRightBottom];

    
    _goodTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, psdname.bottom + 10 , kScreen_Width, kScreen_Height - 20 - 44 - psdname.bottom - 10)];
    _goodTableView.delegate = self ;
    _goodTableView.dataSource = self;
    //    _goodTableView.scrollEnabled = NO ;
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
    [sender setTitleColor:[UIColor colorWithHexString:@"ffffff"]forState:UIControlStateNormal];
    [sender addTarget:self action: @selector(send)
     forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *backItem = [[UIBarButtonItem alloc] initWithCustomView:sender];
    self.navigationItem.rightBarButtonItem = backItem ;
}

-(void)send{
    if (_isfrom) {
        CreateClueViewController *club = [self.navigationController.viewControllers objectAtIndex:self.navigationController.viewControllers.count-3];
        club.areaStr = chooseProAndCity ;
        [self.navigationController popToViewController:club animated:true];
    }else{
        VerifyCodeView2ViewController *verifyCode2 =
        [self.navigationController.viewControllers objectAtIndex:self.navigationController.viewControllers.count- 3];
        verifyCode2.areaStr = chooseProAndCity ;
        verifyCode2.areaCodeStr = proCityCode ;
        [self.navigationController popToViewController:verifyCode2 animated:YES];
    }
    
   
    
}

-(void)getNeedDatas{
    self.HUD = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    
    APIClient *client = [APIClient sharedJsonClient];
//    NSDictionary *params = [NSDictionary dictionaryWithObjectsAndKeys:_code , @"provinceCode" , nil];
    
    NSString *url = [NSString stringWithFormat:@"%@?provinceCode=%@" , getCities , _code] ;
    [client requestJsonDataWithPath:url withParams:nil withMethodType:Post andBlock:^(id data, NSError *error) {
        if([data[@"code"] isEqualToString:@"0000"]){
            NSDictionary *list = data[@"cities"];
            CityVo *model = nil ;
            [kouList removeAllObjects];
            
            if (![list isEqual:[NSNull null]]) {
                for (NSDictionary *dic in list) {
                    model = [CityVo new];
                    model.code = [NSString stringWithFormat:@"%@" , dic[@"code"]] ;
                    model.name = [NSString stringWithFormat:@"%@" ,dic[@"name"]] ;
                    model.provincecode = [NSString stringWithFormat:@"%@" ,dic[@"provincecode"]] ;
                    model.cid = [NSString stringWithFormat:@"%@" ,dic[@"id"]] ;
                    [kouList addObject:model];
                }
            }
            [_goodTableView reloadData];
        }else {
            self.HUD.mode = MBProgressHUDModeText;
            self.HUD.removeFromSuperViewOnHide = YES;
            self.HUD.labelText = @"系统错误";
            [self.HUD hide:YES afterDelay:3];
        }
    }];
    [self closeProgressView];
    
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
    
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    UIView *right = [[cell subviews] objectAtIndex:1] ;
    //显示当前的点击效果
    [right viewWithTag:11].hidden = ![right viewWithTag:11].hidden ;
    
    //去掉之前有勾选的状态
    [self cancelChooseStatus:tableView : indexPath];
    
    chooseProAndCity = [NSString stringWithFormat:@"%@ %@" , _provincename , vo.name];
    proCityCode = [NSString stringWithFormat:@"%@ %@" , vo.provincecode , vo.code];

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
